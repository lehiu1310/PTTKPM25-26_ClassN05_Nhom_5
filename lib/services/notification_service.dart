import 'dart:math' as math;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:monex/data/app_state.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _askedPermission = false;

  Future<void> init() async {
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _plugin.initialize(settings);
    await _plugin.cancelAll();
  }

  Future<void> scheduleReminder(ReminderEntry reminder) async {
    await _ensureNotificationPermission();

    final now = DateTime.now();
    var scheduled = DateTime(
      reminder.dueDate.year,
      reminder.dueDate.month,
      reminder.dueDate.day,
      9,
    ).subtract(const Duration(days: 1));
    if (scheduled.isBefore(now)) {
      scheduled = now.add(const Duration(seconds: 15));
    }

    await _plugin.zonedSchedule(
      reminder.id.hashCode & 0x7fffffff,
      'Sắp đến hạn: ${reminder.title}',
      'Khoản ${money(reminder.amount)} đến hạn ngày ${shortDate(reminder.dueDate)}',
      tz.TZDateTime.from(scheduled, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'monex_bills',
          'Nhắc hóa đơn',
          channelDescription: 'Thông báo các hóa đơn và khoản cần trả.',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelReminderById(String reminderId) {
    return _plugin.cancel(reminderId.hashCode & 0x7fffffff);
  }

  Future<void> showTransactionFeedback(
    MonexAppState state,
    TransactionEntry entry,
  ) async {
    await _ensureNotificationPermission();

    final title = entry.isIncome
        ? 'Đã ghi thu nhập ${money(entry.amount)}'
        : 'Đã ghi chi tiêu ${money(entry.amount)}';
    final body = entry.isIncome
        ? _incomeFeedback(state, entry)
        : _expenseFeedback(state, entry);

    await _plugin.show(
      entry.id.hashCode & 0x7fffffff,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'monex_transactions',
          'Giao dịch Monex',
          channelDescription:
              'Thông báo sau khi thêm thu nhập hoặc chi tiêu trong app.',
          importance: Importance.high,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(body),
        ),
      ),
    );
  }

  String _incomeFeedback(MonexAppState state, TransactionEntry entry) {
    final monthBalance = state.balanceForMonth(entry.date);
    final openGoals =
        state.goals
            .where((goal) => goal.currentAmount < goal.targetAmount)
            .toList()
          ..sort((a, b) {
            final aRemaining = a.targetAmount - a.currentAmount;
            final bRemaining = b.targetAmount - b.currentAmount;
            return aRemaining.compareTo(bRemaining);
          });

    if (openGoals.isNotEmpty && monthBalance > 0) {
      final goal = openGoals.first;
      final remaining = (goal.targetAmount - goal.currentAmount)
          .clamp(0, goal.targetAmount)
          .toDouble();
      if (remaining > 0 && monthBalance >= remaining) {
        return 'Thu nhập mới giúp số dư tháng này đủ để hoàn thành "${goal.title}" còn ${money(remaining)}.';
      }

      final suggested = math.min(remaining, entry.amount * 0.2);
      if (suggested > 0) {
        return 'Đã cộng vào ${entry.category}. Có thể trích khoảng ${money(suggested)} cho mục tiêu "${goal.title}" nếu muốn tiến nhanh hơn.';
      }
    }

    return 'Đã cộng vào ${entry.category}. Số dư tháng này hiện là ${money(monthBalance)}.';
  }

  String _expenseFeedback(MonexAppState state, TransactionEntry entry) {
    final monthExpense = state.expenseTotalForMonth(entry.date);
    final monthIncome = state.incomeTotalForMonth(entry.date);
    final monthBalance = state.balanceForMonth(entry.date);
    final budget = _budgetForCategory(state, entry);

    if (budget != null && budget.limit > 0 && budget.progress >= 1) {
      return '${entry.category} đã vượt ngân sách: ${money(budget.spent)} / ${money(budget.limit)}. Hãy xem lại các khoản chi gần đây.';
    }

    if (budget != null && budget.limit > 0 && budget.progress >= 0.8) {
      final remaining = (budget.limit - budget.spent)
          .clamp(0, budget.limit)
          .toDouble();
      return '${entry.category} sắp chạm ngân sách. Còn ${money(remaining)} trước giới hạn ${money(budget.limit)}.';
    }

    if (monthIncome > 0 && monthExpense >= monthIncome * 0.85) {
      final ratio = (monthExpense / monthIncome * 100).round();
      return 'Chi tiêu tháng này đã dùng $ratio% thu nhập. Số dư còn ${money(monthBalance)}.';
    }

    if (monthBalance < 0) {
      return 'Số dư tháng này đang âm ${money(monthBalance.abs())}. Nên kiểm tra lại các khoản chi lớn.';
    }

    return 'Đã ghi vào ${entry.category}. Tổng chi tháng này là ${money(monthExpense)}, số dư còn ${money(monthBalance)}.';
  }

  BudgetInfo? _budgetForCategory(MonexAppState state, TransactionEntry entry) {
    for (final budget in state.budgetsForMonth(entry.date)) {
      if (budget.category.toLowerCase() == entry.category.toLowerCase()) {
        return budget;
      }
    }
    return null;
  }

  Future<void> _ensureNotificationPermission() async {
    if (_askedPermission) return;
    _askedPermission = true;
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }
}

final NotificationService notificationService = NotificationService();
