import 'dart:math' as math;

import 'package:monex/data/app_state.dart';

class AiRuleReport {
  const AiRuleReport({
    required this.targetMonth,
    required this.predictions,
    required this.anomalies,
    required this.trend,
    required this.budgetRecommendations,
    required this.reductionSuggestions,
    required this.achievements,
  });

  final DateTime targetMonth;
  final List<SpendingPrediction> predictions;
  final List<AnomalyInsight> anomalies;
  final TrendInsight trend;
  final List<BudgetRecommendation> budgetRecommendations;
  final List<ReductionSuggestion> reductionSuggestions;
  final List<SavingsAchievement> achievements;
}

class SpendingPrediction {
  const SpendingPrediction({
    required this.category,
    required this.predictedAmount,
    required this.sampleMonths,
    required this.budgetLimit,
  });

  final String category;
  final double predictedAmount;
  final int sampleMonths;
  final double? budgetLimit;

  bool get isRisky => budgetLimit != null && predictedAmount > budgetLimit!;
}

class AnomalyInsight {
  const AnomalyInsight({
    required this.entry,
    required this.categoryAverage,
    required this.multiplier,
  });

  final TransactionEntry entry;
  final double categoryAverage;
  final double multiplier;
}

class TrendInsight {
  const TrendInsight({
    required this.month,
    required this.currentExpense,
    required this.previousExpense,
    required this.sameMonthLastYearExpense,
    required this.momPercent,
    required this.yoyPercent,
    required this.trendSlope,
  });

  final DateTime month;
  final double currentExpense;
  final double previousExpense;
  final double sameMonthLastYearExpense;
  final double momPercent;
  final double yoyPercent;
  final double trendSlope;

  bool get isRising => trendSlope > 0;
}

class ReductionSuggestion {
  const ReductionSuggestion({
    required this.category,
    required this.currentAmount,
    required this.suggestedSaving,
    required this.reductionPercent,
    required this.reason,
  });

  final String category;
  final double currentAmount;
  final double suggestedSaving;
  final double reductionPercent;
  final String reason;
}

class BudgetRecommendation {
  const BudgetRecommendation({
    required this.category,
    required this.suggestedLimit,
    required this.currentSpent,
    required this.monthlyAverage,
    required this.yearlyAverage,
    required this.incomeRatio,
    required this.priority,
    required this.reason,
  });

  final String category;
  final double suggestedLimit;
  final double currentSpent;
  final double monthlyAverage;
  final double yearlyAverage;
  final double incomeRatio;
  final int priority;
  final String reason;

  bool get isOverSuggested =>
      currentSpent > suggestedLimit && suggestedLimit > 0;
}

class _BudgetPlan {
  const _BudgetPlan({
    required this.category,
    required this.incomeRatio,
    required this.minimum,
    required this.priority,
    this.historyFactor = 1.08,
  });

  final String category;
  final double incomeRatio;
  final double minimum;
  final int priority;
  final double historyFactor;
}

class SavingsAchievement {
  const SavingsAchievement({
    required this.title,
    required this.subtitle,
    required this.level,
  });

  final String title;
  final String subtitle;
  final int level;
}

class AiRuleService {
  AiRuleReport buildReport(MonexAppState state, {DateTime? focusMonth}) {
    final month = DateTime(
      (focusMonth ?? DateTime.now()).year,
      (focusMonth ?? DateTime.now()).month,
    );
    final targetMonth = DateTime(month.year, month.month + 1);

    return AiRuleReport(
      targetMonth: targetMonth,
      predictions: predictNextMonth(state, targetMonth),
      anomalies: detectAnomalies(state),
      trend: buildTrendInsight(state, month),
      budgetRecommendations: buildBudgetRecommendations(state, month),
      reductionSuggestions: buildReductionSuggestions(state, month),
      achievements: buildAchievements(state, month),
    );
  }

  List<BudgetRecommendation> buildBudgetRecommendations(
    MonexAppState state,
    DateTime month,
  ) {
    if (state.transactions.isEmpty) return [];

    final categories = _recommendedBudgetCategories(state);
    final avgIncome = _averageIncome(state, month);
    final currentIncome = state.incomeTotalForMonth(month);
    final spendableIncome = (avgIncome > 0 ? avgIncome : currentIncome) * 0.85;
    final historyExpense = _averageTotalExpense(state, month);
    final budgetBase = spendableIncome > 0
        ? spendableIncome
        : historyExpense > 0
        ? historyExpense * 1.08
        : 1200.0;
    final recommendations = <BudgetRecommendation>[];

    for (final plan in categories) {
      final monthlyAverage = _averageExpenseForCategory(
        state,
        plan.category,
        month,
        6,
      );
      final yearlyAverage = _averageExpenseForCategory(
        state,
        plan.category,
        month,
        12,
      );
      final currentSpent = _expenseForCategory(state, plan.category, month);
      final historySuggestion = monthlyAverage > 0
          ? monthlyAverage * plan.historyFactor
          : yearlyAverage * plan.historyFactor;
      final ratioSuggestion = budgetBase * plan.incomeRatio;
      final suggested = historySuggestion > 0
          ? historySuggestion * 0.68 + ratioSuggestion * 0.32
          : ratioSuggestion;
      final safeSuggested = math.max(
        plan.minimum,
        currentSpent > 0 ? math.max(suggested, currentSpent * 1.05) : suggested,
      );

      recommendations.add(
        BudgetRecommendation(
          category: plan.category,
          suggestedLimit: safeSuggested,
          currentSpent: currentSpent,
          monthlyAverage: monthlyAverage,
          yearlyAverage: yearlyAverage,
          incomeRatio: plan.incomeRatio,
          priority: plan.priority,
          reason: _budgetReason(
            plan,
            monthlyAverage: monthlyAverage,
            yearlyAverage: yearlyAverage,
            avgIncome: avgIncome,
          ),
        ),
      );
    }

    recommendations.sort((a, b) {
      if (a.isOverSuggested != b.isOverSuggested) {
        return a.isOverSuggested ? -1 : 1;
      }
      final priority = a.priority.compareTo(b.priority);
      if (priority != 0) return priority;
      return b.suggestedLimit.compareTo(a.suggestedLimit);
    });
    return recommendations.take(10).toList(growable: false);
  }

  List<SpendingPrediction> predictNextMonth(
    MonexAppState state,
    DateTime targetMonth,
  ) {
    final categories = state.expenseCategories;
    final predictions = <SpendingPrediction>[];

    for (final category in categories) {
      final monthTotals = <double>[];
      for (var i = 6; i >= 1; i--) {
        final month = DateTime(targetMonth.year, targetMonth.month - i);
        final total = _expenseForCategory(state, category, month);
        monthTotals.add(total);
      }

      final activeMonths = monthTotals.where((amount) => amount > 0).length;
      if (activeMonths == 0) continue;

      final average =
          monthTotals.fold<double>(0, (sum, amount) => sum + amount) /
          math.max(activeMonths, 1);
      if (average <= 0) continue;

      predictions.add(
        SpendingPrediction(
          category: category,
          predictedAmount: average,
          sampleMonths: activeMonths,
          budgetLimit: _budgetLimitFor(state, category),
        ),
      );
    }

    predictions.sort((a, b) {
      if (a.isRisky != b.isRisky) return a.isRisky ? -1 : 1;
      return b.predictedAmount.compareTo(a.predictedAmount);
    });
    return predictions.take(5).toList(growable: false);
  }

  List<AnomalyInsight> detectAnomalies(MonexAppState state) {
    final now = DateTime.now();
    final start = now.subtract(const Duration(days: 30));
    final recentExpenses = state.expenses
        .where(
          (entry) => !entry.date.isBefore(start) && !entry.date.isAfter(now),
        )
        .toList();
    final anomalies = <AnomalyInsight>[];

    for (final entry in recentExpenses) {
      final peers = recentExpenses
          .where(
            (item) =>
                item.id != entry.id &&
                item.category.toLowerCase() == entry.category.toLowerCase(),
          )
          .toList();
      if (peers.length < 2) continue;

      final average =
          peers.fold<double>(0, (sum, item) => sum + item.amount) /
          peers.length;
      if (average <= 0 || entry.amount <= average * 2) continue;

      anomalies.add(
        AnomalyInsight(
          entry: entry,
          categoryAverage: average,
          multiplier: entry.amount / average,
        ),
      );
    }

    anomalies.sort((a, b) => b.multiplier.compareTo(a.multiplier));
    return anomalies.take(5).toList(growable: false);
  }

  TrendInsight buildTrendInsight(MonexAppState state, DateTime month) {
    final current = state.expenseTotalForMonth(month);
    final previous = state.expenseTotalForMonth(
      DateTime(month.year, month.month - 1),
    );
    final sameLastYear = state.expenseTotalForMonth(
      DateTime(month.year - 1, month.month),
    );
    final monthlyTotals = List.generate(6, (index) {
      final itemMonth = DateTime(month.year, month.month - (5 - index));
      return state.expenseTotalForMonth(itemMonth);
    });

    return TrendInsight(
      month: month,
      currentExpense: current,
      previousExpense: previous,
      sameMonthLastYearExpense: sameLastYear,
      momPercent: _percentDelta(current, previous),
      yoyPercent: _percentDelta(current, sameLastYear),
      trendSlope: _linearSlope(monthlyTotals),
    );
  }

  List<ReductionSuggestion> buildReductionSuggestions(
    MonexAppState state,
    DateTime month,
  ) {
    final goalPressure = _monthlyGoalPressure(state);
    final suggestions = <ReductionSuggestion>[];

    for (final category in state.expenseCategories) {
      final first = _expenseForCategory(
        state,
        category,
        DateTime(month.year, month.month - 2),
      );
      final second = _expenseForCategory(
        state,
        category,
        DateTime(month.year, month.month - 1),
      );
      final third = _expenseForCategory(state, category, month);
      if (first <= 0 || second <= first || third <= second) continue;

      final growthSaving = math.max(third - second, third * 0.12);
      final targetSaving = goalPressure <= 0
          ? third * 0.15
          : math.min(third * 0.3, math.max(growthSaving, goalPressure * 0.35));
      final reductionPercent = (targetSaving / third * 100).clamp(5, 30);

      suggestions.add(
        ReductionSuggestion(
          category: category,
          currentAmount: third,
          suggestedSaving: third * reductionPercent / 100,
          reductionPercent: reductionPercent.toDouble(),
          reason:
              '$category tăng liên tục 3 tháng. Giảm khoảng ${reductionPercent.toStringAsFixed(0)}% sẽ tạo thêm dư địa tiết kiệm.',
        ),
      );
    }

    suggestions.sort((a, b) => b.currentAmount.compareTo(a.currentAmount));
    return suggestions.take(4).toList(growable: false);
  }

  List<SavingsAchievement> buildAchievements(
    MonexAppState state,
    DateTime month,
  ) {
    final achievements = <SavingsAchievement>[];
    final streak = budgetStreakDays(state);
    achievements.add(
      SavingsAchievement(
        title: streak == 0 ? 'Chưa có streak' : '$streak ngày giữ ngân sách',
        subtitle: streak == 0
            ? 'Bắt đầu bằng một ngày chi tiêu có kiểm soát.'
            : 'Chuỗi ngày gần nhất không vượt mức chi tiêu an toàn.',
        level: streak >= 7
            ? 3
            : streak >= 3
            ? 2
            : 1,
      ),
    );

    final income = state.incomeTotalForMonth(month);
    final expense = state.expenseTotalForMonth(month);
    if (income > 0 && expense <= income * 0.75) {
      achievements.add(
        SavingsAchievement(
          title: 'Tiết kiệm giỏi tháng ${month.month}',
          subtitle:
              'Chi tiêu đang dưới 75% thu nhập tháng này, đủ điều kiện nhận badge.',
          level: 3,
        ),
      );
    } else if (income > 0 && expense <= income * 0.9) {
      achievements.add(
        SavingsAchievement(
          title: 'Chi tiêu ổn định',
          subtitle: 'Chi tiêu vẫn thấp hơn 90% thu nhập tháng này.',
          level: 2,
        ),
      );
    } else {
      achievements.add(
        const SavingsAchievement(
          title: 'Cần thêm dữ liệu tốt',
          subtitle:
              'Khi thu nhập và chi tiêu cân bằng hơn, app sẽ mở badge tiết kiệm.',
          level: 1,
        ),
      );
    }

    return achievements;
  }

  int budgetStreakDays(MonexAppState state) {
    if (state.transactions.isEmpty) return 0;
    final budgets = state.budgets;
    if (budgets.isEmpty) return 0;
    final monthlyLimit = budgets.fold<double>(
      0,
      (sum, budget) => sum + budget.limit,
    );
    if (monthlyLimit <= 0) return 0;

    final today = DateTime.now();
    final oldest = state.transactions
        .map(
          (entry) =>
              DateTime(entry.date.year, entry.date.month, entry.date.day),
        )
        .reduce((a, b) => a.isBefore(b) ? a : b);
    final safeDailyLimit =
        monthlyLimit / DateTime(today.year, today.month + 1, 0).day;
    var streak = 0;
    for (var offset = 0; offset < 60; offset++) {
      final day = DateTime(today.year, today.month, today.day - offset);
      if (day.isBefore(oldest)) break;
      final dayExpense = state
          .transactionsInRange(day, day.add(const Duration(days: 1)))
          .where((entry) => !entry.isIncome)
          .fold<double>(0, (sum, entry) => sum + entry.amount);
      if (dayExpense > safeDailyLimit) break;
      streak++;
    }
    return streak;
  }

  double _expenseForCategory(
    MonexAppState state,
    String category,
    DateTime month,
  ) {
    return state
        .expensesForMonth(month)
        .where(
          (entry) => entry.category.toLowerCase() == category.toLowerCase(),
        )
        .fold<double>(0, (sum, entry) => sum + entry.amount);
  }

  List<_BudgetPlan> _recommendedBudgetCategories(MonexAppState state) {
    const basePlans = [
      _BudgetPlan(
        category: 'Tiền thuê nhà',
        incomeRatio: 0.24,
        minimum: 180,
        priority: 1,
        historyFactor: 1.02,
      ),
      _BudgetPlan(
        category: 'Ăn uống',
        incomeRatio: 0.16,
        minimum: 120,
        priority: 2,
      ),
      _BudgetPlan(
        category: 'Tiền điện',
        incomeRatio: 0.04,
        minimum: 35,
        priority: 3,
      ),
      _BudgetPlan(
        category: 'Tiền nước',
        incomeRatio: 0.025,
        minimum: 20,
        priority: 4,
      ),
      _BudgetPlan(
        category: 'Xăng xe',
        incomeRatio: 0.06,
        minimum: 45,
        priority: 5,
      ),
      _BudgetPlan(
        category: 'Internet',
        incomeRatio: 0.025,
        minimum: 25,
        priority: 6,
      ),
      _BudgetPlan(
        category: 'Điện thoại',
        incomeRatio: 0.02,
        minimum: 18,
        priority: 7,
      ),
      _BudgetPlan(
        category: 'Y tế',
        incomeRatio: 0.05,
        minimum: 45,
        priority: 8,
      ),
      _BudgetPlan(
        category: 'Giáo dục',
        incomeRatio: 0.05,
        minimum: 45,
        priority: 9,
      ),
      _BudgetPlan(
        category: 'Mua sắm',
        incomeRatio: 0.07,
        minimum: 60,
        priority: 10,
      ),
      _BudgetPlan(
        category: 'Giải trí',
        incomeRatio: 0.045,
        minimum: 35,
        priority: 11,
      ),
      _BudgetPlan(
        category: 'Gia đình',
        incomeRatio: 0.055,
        minimum: 45,
        priority: 12,
      ),
      _BudgetPlan(
        category: 'Dự phòng',
        incomeRatio: 0.07,
        minimum: 60,
        priority: 13,
        historyFactor: 1.0,
      ),
    ];

    final plans = <String, _BudgetPlan>{
      for (final plan in basePlans) plan.category.toLowerCase(): plan,
    };
    for (final category in state.expenseCategories) {
      final key = category.toLowerCase();
      plans.putIfAbsent(
        key,
        () => _BudgetPlan(
          category: category,
          incomeRatio: 0.04,
          minimum: 35,
          priority: 20,
        ),
      );
    }
    return plans.values.toList(growable: false);
  }

  double _averageIncome(MonexAppState state, DateTime month) {
    final values = <double>[];
    for (var i = 0; i < 6; i++) {
      final value = state.incomeTotalForMonth(
        DateTime(month.year, month.month - i),
      );
      if (value > 0) values.add(value);
    }
    if (values.isEmpty) return 0;
    return values.fold<double>(0, (sum, value) => sum + value) / values.length;
  }

  double _averageTotalExpense(MonexAppState state, DateTime month) {
    final values = <double>[];
    for (var i = 0; i < 6; i++) {
      final value = state.expenseTotalForMonth(
        DateTime(month.year, month.month - i),
      );
      if (value > 0) values.add(value);
    }
    if (values.isEmpty) return 0;
    return values.fold<double>(0, (sum, value) => sum + value) / values.length;
  }

  double _averageExpenseForCategory(
    MonexAppState state,
    String category,
    DateTime month,
    int months,
  ) {
    final values = <double>[];
    for (var i = 0; i < months; i++) {
      final value = _expenseForCategory(
        state,
        category,
        DateTime(month.year, month.month - i),
      );
      if (value > 0) values.add(value);
    }
    if (values.isEmpty) return 0;
    return values.fold<double>(0, (sum, value) => sum + value) / values.length;
  }

  String _budgetReason(
    _BudgetPlan plan, {
    required double monthlyAverage,
    required double yearlyAverage,
    required double avgIncome,
  }) {
    if (monthlyAverage > 0) {
      return 'Dựa trên trung bình 6 tháng của ${plan.category} và khoảng ${(plan.incomeRatio * 100).toStringAsFixed(0)}% thu nhập.';
    }
    if (yearlyAverage > 0) {
      return 'Dựa trên trung bình 12 tháng của ${plan.category}, dùng làm mức kiểm soát cho tháng tới.';
    }
    if (avgIncome > 0) {
      return 'Chưa có lịch sử riêng, app đề xuất theo ${(plan.incomeRatio * 100).toStringAsFixed(0)}% thu nhập trung bình.';
    }
    return 'Chưa đủ thu nhập lịch sử, app dùng mức khởi tạo an toàn cho danh mục này.';
  }

  double? _budgetLimitFor(MonexAppState state, String category) {
    for (final budget in state.budgets) {
      if (budget.category.toLowerCase() == category.toLowerCase()) {
        return budget.limit;
      }
    }
    return null;
  }

  double _monthlyGoalPressure(MonexAppState state) {
    final openGoals = state.goals
        .where((goal) => goal.currentAmount < goal.targetAmount)
        .toList();
    if (openGoals.isEmpty) return 0;

    openGoals.sort((a, b) => a.deadline.compareTo(b.deadline));
    final goal = openGoals.first;
    final remaining = (goal.targetAmount - goal.currentAmount)
        .clamp(0, goal.targetAmount)
        .toDouble();
    final days = math.max(goal.deadline.difference(DateTime.now()).inDays, 1);
    return remaining / days * 30;
  }

  double _percentDelta(double current, double previous) {
    if (previous == 0) return current == 0 ? 0 : 100;
    return (current - previous) / previous * 100;
  }

  double _linearSlope(List<double> values) {
    if (values.length < 2) return 0;
    final n = values.length;
    final avgX = (n - 1) / 2;
    final avgY = values.fold<double>(0, (sum, value) => sum + value) / n;
    var numerator = 0.0;
    var denominator = 0.0;
    for (var i = 0; i < n; i++) {
      final dx = i - avgX;
      numerator += dx * (values[i] - avgY);
      denominator += dx * dx;
    }
    if (denominator == 0) return 0;
    return numerator / denominator;
  }
}

final AiRuleService aiRuleService = AiRuleService();
