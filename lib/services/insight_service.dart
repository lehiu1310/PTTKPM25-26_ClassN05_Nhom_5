import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:monex/data/app_state.dart';
import 'package:monex/services/ai_rule_service.dart';

enum InsightSeverity { info, good, warning, danger }

class AssistantInsight {
  const AssistantInsight({
    required this.title,
    required this.subtitle,
    required this.message,
    required this.status,
    required this.severity,
    required this.progress,
    required this.primaryAction,
    this.actionType,
    this.targetId,
  });

  final String title;
  final String subtitle;
  final String message;
  final String status;
  final InsightSeverity severity;
  final double progress;
  final String primaryAction;
  final String? actionType;
  final String? targetId;
}

class SmartNotification {
  const SmartNotification({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.timeLabel,
    required this.source,
    required this.severity,
    required this.sortDate,
    this.actionType,
    this.targetId,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String timeLabel;
  final String source;
  final InsightSeverity severity;
  final DateTime sortDate;
  final String? actionType;
  final String? targetId;
}

class InsightService {
  AssistantInsight buildAssistantInsight(MonexAppState state) {
    final notifications = buildNotifications(state);
    final urgent = notifications.where(
      (item) => item.severity == InsightSeverity.danger,
    );
    if (urgent.isNotEmpty) {
      final item = urgent.first;
      return AssistantInsight(
        title: item.title,
        subtitle: item.source,
        message: item.subtitle,
        status: 'Gấp',
        severity: InsightSeverity.danger,
        progress: 1,
        primaryAction: _primaryActionForNotification(item),
        actionType: item.actionType,
        targetId: item.targetId,
      );
    }

    if (state.transactions.isEmpty && state.reminders.isEmpty) {
      return const AssistantInsight(
        title: 'Chưa đủ dữ liệu để phân tích',
        subtitle: 'Trợ lý đang chờ dữ liệu thật',
        message:
            'Khi bạn thêm thu nhập, chi phí hoặc hóa đơn, app mới tạo cảnh báo. Không có dữ liệu thì không hiện thông báo giả.',
        status: 'Mới',
        severity: InsightSeverity.info,
        progress: 0,
        primaryAction: 'Thêm dữ liệu',
      );
    }

    final recentInsight = _recentTransactionInsight(state);
    if (recentInsight != null) return recentInsight;

    final highRisk = state.highestBudgetRisk;
    if (highRisk != null && highRisk.progress >= 0.75) {
      final remaining = (highRisk.limit - highRisk.spent)
          .clamp(0, highRisk.limit)
          .toDouble();
      final daysLeft = _daysLeftInMonth();
      final dailyCap = daysLeft == 0 ? remaining : remaining / daysLeft;
      return AssistantInsight(
        title: '${highRisk.category} đang sát ngân sách',
        subtitle:
            '${money(highRisk.spent)} / ${money(highRisk.limit)} trong tháng này',
        message:
            'Bạn còn ${money(remaining)} cho ${highRisk.category.toLowerCase()}. Nếu muốn giữ an toàn, mỗi ngày chỉ nên dùng khoảng ${money(dailyCap)} cho mục này.',
        status: highRisk.progress >= 1 ? 'Vượt' : 'Cao',
        severity: highRisk.progress >= 1
            ? InsightSeverity.danger
            : InsightSeverity.warning,
        progress: highRisk.progress.clamp(0.0, 1.0).toDouble(),
        primaryAction: 'Xem ngân sách',
      );
    }

    final upcomingBills = state.reminders.where((item) {
      final days = _dateOnly(item.dueDate).difference(_today()).inDays;
      return days >= 0 && days <= 7;
    }).toList()..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    if (upcomingBills.isNotEmpty) {
      final bill = upcomingBills.first;
      return AssistantInsight(
        title: 'Có hóa đơn sắp đến hạn',
        subtitle: '${bill.title} - ${_dueLabel(bill.dueDate)}',
        message:
            'Khoản ${money(bill.amount)} cần trả vào ${shortDate(bill.dueDate)}. App chỉ nhắc vì bạn đã tạo hóa đơn này trong tài khoản hiện tại.',
        status: 'Nhắc',
        severity: InsightSeverity.warning,
        progress: 0.65,
        primaryAction: 'Thanh toán',
        actionType: 'pay_bill',
        targetId: bill.id,
      );
    }

    final goalInsight = _goalInsight(state);
    if (goalInsight != null) return goalInsight;

    if (state.currentMonthIncomeTotal > 0 &&
        state.currentMonthExpenseTotal == 0) {
      return AssistantInsight(
        title: 'Thu nhập đã có, chi tiêu chưa ghi',
        subtitle: 'Số dư hiện tại ${money(state.currentMonthBalance)}',
        message:
            'Bạn đã ghi thu nhập nhưng chưa có khoản chi nào. Trợ lý sẽ bắt đầu cảnh báo chính xác hơn sau khi có ít nhất một chi phí thật.',
        status: 'Ổn',
        severity: InsightSeverity.good,
        progress: 0.2,
        primaryAction: 'Thêm chi phí',
      );
    }

    if (state.currentMonthIncomeTotal == 0 &&
        state.currentMonthExpenseTotal > 0) {
      return AssistantInsight(
        title: 'Có chi tiêu nhưng chưa có thu nhập',
        subtitle: 'Chi tiêu hiện tại ${money(state.currentMonthExpenseTotal)}',
        message:
            'Bạn nên thêm nguồn thu nhập để app tính số dư và cảnh báo ngân sách chính xác hơn cho tài khoản này.',
        status: 'Thiếu',
        severity: InsightSeverity.warning,
        progress: 0.5,
        primaryAction: 'Thêm thu nhập',
      );
    }

    final ratio = state.currentMonthIncomeTotal == 0
        ? 0.0
        : (state.currentMonthExpenseTotal / state.currentMonthIncomeTotal)
              .clamp(0.0, 1.0)
              .toDouble();
    final topCategory = _topExpenseCategory(state);
    if (ratio >= 0.65) {
      return AssistantInsight(
        title: 'Tỷ lệ chi tiêu hơi cao',
        subtitle: 'Đã dùng ${(ratio * 100).round()}% thu nhập tháng này',
        message: topCategory == null
            ? 'Chi tiêu đang tăng nhanh so với thu nhập. Hãy theo dõi thêm vài giao dịch để app chỉ ra nhóm chi cụ thể.'
            : 'Nhóm chi lớn nhất là ${topCategory.name} với ${money(topCategory.amount)}. Đây là nơi nên kiểm tra trước nếu muốn giảm chi.',
        status: 'Theo dõi',
        severity: InsightSeverity.warning,
        progress: ratio,
        primaryAction: 'Xem phân tích',
      );
    }

    return AssistantInsight(
      title: 'Dòng tiền đang ổn',
      subtitle: 'Số dư ${money(state.currentMonthBalance)}',
      message: topCategory == null
          ? 'Chưa có rủi ro đáng chú ý. App sẽ chỉ tạo thông báo khi phát hiện hóa đơn đến hạn, ngân sách vượt ngưỡng hoặc giao dịch bất thường.'
          : 'Nhóm chi lớn nhất hiện là ${topCategory.name} (${money(topCategory.amount)}), nhưng chưa vượt ngưỡng cảnh báo.',
      status: 'Ổn',
      severity: InsightSeverity.good,
      progress: math.max(ratio, 0.18),
      primaryAction: 'Xem giao dịch',
    );
  }

  List<SmartNotification> buildNotifications(MonexAppState state) {
    final notifications = <SmartNotification>[];
    notifications.addAll(_recentTransactionNotifications(state));
    notifications.addAll(_aiRuleNotifications(state));
    notifications.addAll(_billNotifications(state));
    notifications.addAll(_budgetNotifications(state));
    notifications.addAll(_cashFlowNotifications(state));
    notifications.addAll(_goalNotifications(state));
    notifications.addAll(_unusualTransactionNotifications(state));

    notifications.sort((a, b) {
      final severity = _severityRank(
        b.severity,
      ).compareTo(_severityRank(a.severity));
      if (severity != 0) return severity;
      return b.sortDate.compareTo(a.sortDate);
    });

    return notifications.take(8).toList(growable: false);
  }

  String _primaryActionForNotification(SmartNotification item) {
    if (item.actionType == 'pay_bill') return 'Thanh toán';
    if (item.source == 'Ngân sách') return 'Xem ngân sách';
    if (item.source == 'AI Rule') return 'Xem phân tích';
    if (item.source == 'Dòng tiền' || item.source == 'Giao dịch') {
      return 'Xem giao dịch';
    }
    if (item.source == 'Tiết kiệm') return 'Xem tiết kiệm';
    return 'Xem chi tiết';
  }

  List<SmartNotification> _aiRuleNotifications(MonexAppState state) {
    final report = aiRuleService.buildReport(state);
    final notifications = <SmartNotification>[];

    final riskyPrediction = report.predictions
        .where((item) => item.isRisky)
        .toList(growable: false);
    if (riskyPrediction.isNotEmpty) {
      final item = riskyPrediction.first;
      notifications.add(
        SmartNotification(
          icon: Icons.auto_graph_outlined,
          title: 'Dự đoán vượt ngân sách tháng tới',
          subtitle:
              '${item.category} có thể tới ${money(item.predictedAmount)}, cao hơn giới hạn ${money(item.budgetLimit ?? 0)}.',
          timeLabel: 'Tháng ${report.targetMonth.month}',
          source: 'AI Rule',
          severity: InsightSeverity.warning,
          sortDate: DateTime.now(),
        ),
      );
    }

    final overBudget = report.budgetRecommendations
        .where((item) => item.isOverSuggested)
        .toList(growable: false);
    if (overBudget.isNotEmpty) {
      final item = overBudget.first;
      notifications.add(
        SmartNotification(
          icon: Icons.savings_outlined,
          title: 'AI đề xuất siết ngân sách',
          subtitle:
              '${item.category} đã dùng ${money(item.currentSpent)}, cao hơn mức đề xuất ${money(item.suggestedLimit)}.',
          timeLabel: 'Tháng này',
          source: 'AI Rule',
          severity: InsightSeverity.warning,
          sortDate: DateTime.now().subtract(const Duration(seconds: 30)),
        ),
      );
    }

    for (final anomaly in report.anomalies.take(2)) {
      notifications.add(
        SmartNotification(
          icon: Icons.manage_search_outlined,
          title: 'Giao dịch bất thường',
          subtitle:
              '${anomaly.entry.title} cao gấp ${anomaly.multiplier.toStringAsFixed(1)}x trung bình ${anomaly.entry.category} trong 30 ngày.',
          timeLabel: _relativeDate(anomaly.entry.date),
          source: 'AI Rule',
          severity: anomaly.multiplier >= 3
              ? InsightSeverity.danger
              : InsightSeverity.warning,
          sortDate: anomaly.entry.date,
        ),
      );
    }

    if (report.reductionSuggestions.isNotEmpty) {
      final item = report.reductionSuggestions.first;
      notifications.add(
        SmartNotification(
          icon: Icons.lightbulb_outline_rounded,
          title: 'Gợi ý cắt giảm thông minh',
          subtitle:
              'Giảm ${item.category} khoảng ${item.reductionPercent.toStringAsFixed(0)}% để tiết kiệm thêm ${money(item.suggestedSaving)}.',
          timeLabel: '3 tháng tăng',
          source: 'AI Rule',
          severity: InsightSeverity.info,
          sortDate: DateTime.now().subtract(const Duration(minutes: 1)),
        ),
      );
    }

    return notifications;
  }

  List<SmartNotification> _billNotifications(MonexAppState state) {
    final today = _today();
    return state.reminders
        .where((item) {
          final days = _dateOnly(item.dueDate).difference(today).inDays;
          return days <= 7;
        })
        .map((item) {
          final days = _dateOnly(item.dueDate).difference(today).inDays;
          final isOverdue = days < 0;
          final isDueSoon = days <= 2;
          return SmartNotification(
            icon: isOverdue
                ? Icons.warning_amber_rounded
                : Icons.receipt_long_outlined,
            title: isOverdue
                ? 'Hóa đơn quá hạn'
                : days == 0
                ? 'Hóa đơn đến hạn hôm nay'
                : 'Hóa đơn sắp đến hạn',
            subtitle: isOverdue
                ? '${item.title} cần ${money(item.amount)} - hạn ${shortDate(item.dueDate)}. Thanh toán xong thì app sẽ ngừng nhắc.'
                : '${item.title} cần ${money(item.amount)} - hạn ${shortDate(item.dueDate)}.',
            timeLabel: _dueLabel(item.dueDate),
            source: 'Hóa đơn',
            severity: isOverdue
                ? InsightSeverity.danger
                : isDueSoon
                ? InsightSeverity.warning
                : InsightSeverity.info,
            sortDate: item.dueDate,
            actionType: 'pay_bill',
            targetId: item.id,
          );
        })
        .toList(growable: false);
  }

  List<SmartNotification> _budgetNotifications(MonexAppState state) {
    final risks = state.budgets.where((item) => item.spent > 0).toList()
      ..sort((a, b) => b.progress.compareTo(a.progress));

    return risks
        .where((item) => item.progress >= 0.7)
        .take(3)
        .map((item) {
          final remaining = (item.limit - item.spent)
              .clamp(0, item.limit)
              .toDouble();
          final isOver = item.progress >= 1;
          return SmartNotification(
            icon: isOver
                ? Icons.error_outline_rounded
                : Icons.pie_chart_outline_rounded,
            title: isOver
                ? 'Vượt ngân sách ${item.category}'
                : 'Sắp chạm ngân sách ${item.category}',
            subtitle: isOver
                ? 'Đã dùng ${money(item.spent)} trong khi giới hạn là ${money(item.limit)}.'
                : 'Còn ${money(remaining)} trước khi chạm giới hạn ${money(item.limit)}.',
            timeLabel: 'Tháng này',
            source: 'Ngân sách',
            severity: isOver ? InsightSeverity.danger : InsightSeverity.warning,
            sortDate: DateTime.now(),
          );
        })
        .toList(growable: false);
  }

  List<SmartNotification> _cashFlowNotifications(MonexAppState state) {
    if (state.currentMonthTransactions.isEmpty) return [];
    if (state.currentMonthBalance < 0) {
      return [
        SmartNotification(
          icon: Icons.account_balance_wallet_outlined,
          title: 'Số dư đang âm',
          subtitle:
              'Chi tiêu đang vượt thu nhập ${money(state.currentMonthBalance.abs())}. Hãy kiểm tra lại các khoản chi gần đây.',
          timeLabel: 'Ngay bây giờ',
          source: 'Dòng tiền',
          severity: InsightSeverity.danger,
          sortDate: DateTime.now(),
        ),
      ];
    }

    if (state.currentMonthIncomeTotal > 0 &&
        state.currentMonthExpenseTotal >=
            state.currentMonthIncomeTotal * 0.85) {
      return [
        SmartNotification(
          icon: Icons.trending_up_rounded,
          title: 'Chi tiêu gần bằng thu nhập',
          subtitle:
              'Bạn đã dùng ${(state.currentMonthExpenseTotal / state.currentMonthIncomeTotal * 100).round()}% thu nhập tháng này.',
          timeLabel: 'Tháng này',
          source: 'Dòng tiền',
          severity: InsightSeverity.warning,
          sortDate: DateTime.now(),
        ),
      ];
    }

    return [];
  }

  List<SmartNotification> _goalNotifications(MonexAppState state) {
    final today = _today();
    return state.goals
        .where((goal) {
          final days = _dateOnly(goal.deadline).difference(today).inDays;
          return goal.progress >= 0.9 ||
              (days >= 0 && days <= 30 && goal.progress < 0.75);
        })
        .take(3)
        .map((goal) {
          final days = _dateOnly(goal.deadline).difference(today).inDays;
          final isAlmostDone = goal.progress >= 0.9;
          return SmartNotification(
            icon: isAlmostDone
                ? Icons.flag_circle_outlined
                : Icons.savings_outlined,
            title: isAlmostDone
                ? 'Mục tiêu gần hoàn thành'
                : 'Mục tiêu cần tăng tốc',
            subtitle: isAlmostDone
                ? '${goal.title} đã đạt ${(goal.progress * 100).round()}%.'
                : '${goal.title} còn $days ngày nhưng mới đạt ${(goal.progress * 100).round()}%.',
            timeLabel: isAlmostDone ? 'Gần đạt' : 'Còn $days ngày',
            source: 'Tiết kiệm',
            severity: isAlmostDone
                ? InsightSeverity.good
                : InsightSeverity.info,
            sortDate: goal.deadline,
          );
        })
        .toList(growable: false);
  }

  List<SmartNotification> _unusualTransactionNotifications(
    MonexAppState state,
  ) {
    final expenses = state.currentMonthExpenses;
    if (expenses.length < 3) return [];

    final average = state.currentMonthExpenseTotal / expenses.length;
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    final floor = math.max(
      average * 1.8,
      state.currentMonthExpenseTotal * 0.28,
    );
    final unusual =
        expenses
            .where(
              (item) => item.date.isAfter(sevenDaysAgo) && item.amount >= floor,
            )
            .toList()
          ..sort((a, b) => b.amount.compareTo(a.amount));

    return unusual
        .take(2)
        .map((item) {
          return SmartNotification(
            icon: item.icon,
            title: 'Giao dịch lớn bất thường',
            subtitle:
                '${item.title} (${money(item.amount)}) cao hơn mức chi trung bình ${money(average)}.',
            timeLabel: _relativeDate(item.date),
            source: 'Giao dịch',
            severity: InsightSeverity.warning,
            sortDate: item.date,
          );
        })
        .toList(growable: false);
  }

  AssistantInsight? _recentTransactionInsight(MonexAppState state) {
    final latest = _latestCreatedTransaction(state);
    if (latest == null || !_isFresh(latest)) return null;

    final monthIncome = state.incomeTotalForMonth(latest.date);
    final monthExpense = state.expenseTotalForMonth(latest.date);
    final monthBalance = state.balanceForMonth(latest.date);

    if (latest.isIncome) {
      final goal =
          _completableGoal(state, monthBalance) ?? _nearestOpenGoal(state);
      if (goal != null) {
        final remaining = _goalRemaining(goal);
        final canComplete = remaining > 0 && monthBalance >= remaining;
        return AssistantInsight(
          title: 'Vừa có thu nhập mới',
          subtitle: '${latest.title} +${money(latest.amount)}',
          message: canComplete
              ? 'Số dư tháng này đủ để hoàn thành mục tiêu ${goal.title} còn ${money(remaining)}. Đây là thời điểm tốt để nạp thêm vào tiết kiệm.'
              : 'Bạn vừa ghi ${money(latest.amount)} vào ${latest.category}. Nếu trích một phần nhỏ cho ${goal.title}, mục tiêu sẽ tiến nhanh hơn.',
          status: canComplete ? 'Có thể đạt' : 'Tốt',
          severity: InsightSeverity.good,
          progress: canComplete ? 0.95 : math.max(goal.progress, 0.35),
          primaryAction: 'Xem tiết kiệm',
        );
      }

      return AssistantInsight(
        title: 'Vừa ghi thu nhập mới',
        subtitle: '${latest.title} +${money(latest.amount)}',
        message:
            'Số dư tháng này hiện là ${money(monthBalance)}. Khi bạn tiếp tục thêm chi phí, trợ lý sẽ so sánh thu/chi và cảnh báo đúng theo dữ liệu mới.',
        status: 'Tốt',
        severity: InsightSeverity.good,
        progress: 0.35,
        primaryAction: 'Xem giao dịch',
      );
    }

    final budget = _budgetForCategory(state, latest);
    if (budget != null && budget.progress >= 0.75) {
      final remaining = (budget.limit - budget.spent)
          .clamp(0, budget.limit)
          .toDouble();
      final isOver = budget.progress >= 1;
      return AssistantInsight(
        title: isOver
            ? 'Khoản chi vừa nhập làm vượt ngân sách'
            : 'Khoản chi vừa nhập sát ngân sách',
        subtitle:
            '${latest.category}: ${money(budget.spent)} / ${money(budget.limit)}',
        message: isOver
            ? 'Bạn vừa chi ${money(latest.amount)} cho ${latest.title}. Nhóm ${latest.category} đã vượt giới hạn, nên kiểm tra lại các khoản cùng danh mục.'
            : 'Sau khoản ${latest.title}, nhóm ${latest.category} chỉ còn ${money(remaining)} trước khi chạm ngân sách.',
        status: isOver ? 'Gấp' : 'Cần xem',
        severity: isOver ? InsightSeverity.danger : InsightSeverity.warning,
        progress: budget.progress.clamp(0.0, 1.0).toDouble(),
        primaryAction: 'Xem ngân sách',
      );
    }

    if (monthIncome > 0 && monthExpense >= monthIncome * 0.7) {
      final ratio = (monthExpense / monthIncome).clamp(0.0, 1.0).toDouble();
      return AssistantInsight(
        title: 'Khoản chi mới làm tỷ lệ chi tăng',
        subtitle: 'Đã dùng ${(ratio * 100).round()}% thu nhập tháng này',
        message:
            'Bạn vừa chi ${money(latest.amount)} cho ${latest.title}. Tổng chi tháng này là ${money(monthExpense)}, số dư còn ${money(monthBalance)}.',
        status: ratio >= 0.9 ? 'Căng' : 'Theo dõi',
        severity: ratio >= 0.9
            ? InsightSeverity.danger
            : InsightSeverity.warning,
        progress: ratio,
        primaryAction: 'Xem phân tích',
      );
    }

    if (monthBalance < 0) {
      return AssistantInsight(
        title: 'Số dư tháng này đang âm',
        subtitle: 'Âm ${money(monthBalance.abs())} sau khoản chi mới',
        message:
            'Khoản ${latest.title} vừa nhập làm dòng tiền âm. Hãy xem lại danh sách giao dịch hoặc bổ sung nguồn thu tương ứng.',
        status: 'Gấp',
        severity: InsightSeverity.danger,
        progress: 1,
        primaryAction: 'Xem giao dịch',
      );
    }

    return null;
  }

  AssistantInsight? _goalInsight(MonexAppState state) {
    final monthBalance = state.currentMonthBalance;
    final completable = _completableGoal(state, monthBalance);
    if (completable != null) {
      final remaining = _goalRemaining(completable);
      return AssistantInsight(
        title: 'Có thể hoàn thiện mục tiêu',
        subtitle: '${completable.title} còn ${money(remaining)}',
        message:
            'Số dư tháng này đủ để nạp nốt mục tiêu ${completable.title}. Nếu bạn muốn mua/đạt mục tiêu sớm, đây là khoản nên ưu tiên.',
        status: 'Có thể đạt',
        severity: InsightSeverity.good,
        progress: completable.progress.clamp(0.0, 1.0).toDouble(),
        primaryAction: 'Xem tiết kiệm',
      );
    }

    final goal = _nearestOpenGoal(state);
    if (goal == null) return null;
    final days = _dateOnly(goal.deadline).difference(_today()).inDays;
    final remaining = _goalRemaining(goal);

    if (days < 0 && remaining > 0) {
      return AssistantInsight(
        title: 'Mục tiêu tiết kiệm đã quá hạn',
        subtitle: '${goal.title} còn ${money(remaining)}',
        message:
            'Mục tiêu này đã qua hạn nhưng chưa hoàn thành. Bạn có thể gia hạn hoặc nạp thêm từng phần để không mất nhịp tiết kiệm.',
        status: 'Quá hạn',
        severity: InsightSeverity.warning,
        progress: goal.progress.clamp(0.0, 1.0).toDouble(),
        primaryAction: 'Xem tiết kiệm',
      );
    }

    if (goal.progress >= 0.8 && remaining > 0) {
      return AssistantInsight(
        title: 'Mục tiêu tiết kiệm sắp hoàn thành',
        subtitle: '${goal.title} đã đạt ${(goal.progress * 100).round()}%',
        message:
            'Bạn chỉ còn ${money(remaining)} để hoàn thành ${goal.title}. Nạp thêm từng khoản nhỏ sau mỗi lần có thu nhập sẽ dễ đạt hơn.',
        status: 'Sắp đạt',
        severity: InsightSeverity.good,
        progress: goal.progress.clamp(0.0, 1.0).toDouble(),
        primaryAction: 'Xem tiết kiệm',
      );
    }

    if (days >= 0 && days <= 30 && goal.progress < 0.75) {
      final perDay = remaining / math.max(days + 1, 1);
      return AssistantInsight(
        title: 'Mục tiêu cần tăng tốc',
        subtitle: '${goal.title} còn $days ngày',
        message:
            'Để kịp hạn, bạn cần tiết kiệm khoảng ${money(perDay)} mỗi ngày cho mục tiêu này.',
        status: 'Nhắc',
        severity: InsightSeverity.info,
        progress: goal.progress.clamp(0.0, 1.0).toDouble(),
        primaryAction: 'Xem tiết kiệm',
      );
    }

    return null;
  }

  List<SmartNotification> _recentTransactionNotifications(MonexAppState state) {
    final items = state.transactions.where(_isFresh).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return items
        .take(3)
        .map((entry) {
          final budget = entry.isIncome
              ? null
              : _budgetForCategory(state, entry);
          final isOverBudget = budget != null && budget.progress >= 1;
          final isNearBudget = budget != null && budget.progress >= 0.8;
          return SmartNotification(
            icon: entry.isIncome ? Icons.arrow_downward_rounded : entry.icon,
            title: entry.isIncome ? 'Vừa ghi thu nhập' : 'Vừa ghi chi tiêu',
            subtitle: entry.isIncome
                ? '${entry.title} +${money(entry.amount)} vào ${entry.category}.'
                : '${entry.title} -${money(entry.amount)} cho ${entry.category}${isOverBudget
                      ? ', đã vượt ngân sách.'
                      : isNearBudget
                      ? ', sắp chạm ngân sách.'
                      : '.'}',
            timeLabel: _relativeDate(entry.createdAt),
            source: 'Giao dịch',
            severity: entry.isIncome
                ? InsightSeverity.good
                : isOverBudget
                ? InsightSeverity.danger
                : isNearBudget
                ? InsightSeverity.warning
                : InsightSeverity.info,
            sortDate: entry.createdAt,
          );
        })
        .toList(growable: false);
  }

  TransactionEntry? _latestCreatedTransaction(MonexAppState state) {
    if (state.transactions.isEmpty) return null;
    final items = state.transactions.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return items.first;
  }

  bool _isFresh(TransactionEntry entry) {
    final diff = DateTime.now().difference(entry.createdAt);
    return !diff.isNegative && diff <= const Duration(hours: 24);
  }

  BudgetInfo? _budgetForCategory(MonexAppState state, TransactionEntry entry) {
    for (final budget in state.budgetsForMonth(entry.date)) {
      if (budget.category.toLowerCase() == entry.category.toLowerCase()) {
        return budget;
      }
    }
    return null;
  }

  SavingsGoal? _completableGoal(MonexAppState state, double availableBalance) {
    final goals =
        state.goals
            .where((goal) => goal.progress < 1 && _goalRemaining(goal) > 0)
            .where((goal) => availableBalance >= _goalRemaining(goal))
            .toList()
          ..sort((a, b) => _goalRemaining(a).compareTo(_goalRemaining(b)));
    return goals.isEmpty ? null : goals.first;
  }

  SavingsGoal? _nearestOpenGoal(MonexAppState state) {
    final goals =
        state.goals
            .where((goal) => goal.progress < 1 && _goalRemaining(goal) > 0)
            .toList()
          ..sort((a, b) => a.deadline.compareTo(b.deadline));
    return goals.isEmpty ? null : goals.first;
  }

  double _goalRemaining(SavingsGoal goal) {
    return (goal.targetAmount - goal.currentAmount)
        .clamp(0, goal.targetAmount)
        .toDouble();
  }

  _CategoryTotal? _topExpenseCategory(MonexAppState state) {
    final totals = <String, double>{};
    for (final item in state.currentMonthExpenses) {
      totals[item.category] = (totals[item.category] ?? 0) + item.amount;
    }
    if (totals.isEmpty) return null;
    final entry = totals.entries.reduce(
      (best, item) => item.value > best.value ? item : best,
    );
    return _CategoryTotal(entry.key, entry.value);
  }

  int _daysLeftInMonth() {
    final now = DateTime.now();
    final lastDay = DateTime(now.year, now.month + 1, 0).day;
    return math.max(1, lastDay - now.day + 1);
  }

  DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  String _dueLabel(DateTime dueDate) {
    final days = _dateOnly(dueDate).difference(_today()).inDays;
    if (days < 0) return 'Quá hạn ${days.abs()} ngày';
    if (days == 0) return 'Hôm nay';
    if (days == 1) return 'Ngày mai';
    return 'Còn $days ngày';
  }

  String _relativeDate(DateTime value) {
    final diff = DateTime.now().difference(value);
    if (diff.inMinutes < 1) return 'Vừa xong';
    if (diff.inHours < 1) return '${diff.inMinutes} phút trước';
    if (diff.inDays < 1) return '${diff.inHours} giờ trước';
    return '${diff.inDays} ngày trước';
  }

  int _severityRank(InsightSeverity severity) {
    return switch (severity) {
      InsightSeverity.danger => 4,
      InsightSeverity.warning => 3,
      InsightSeverity.good => 2,
      InsightSeverity.info => 1,
    };
  }
}

class _CategoryTotal {
  const _CategoryTotal(this.name, this.amount);

  final String name;
  final double amount;
}

final InsightService insightService = InsightService();
