# Program Design

## 1. Module Data

Vi tri:

```text
lib/data/
```

Chuc nang:

- Dinh nghia `UserAccount`, `TransactionEntry`, `SavingsGoal`, `ReminderEntry`, `BudgetInfo`.
- Quan ly trang thai ung dung bang `MonexAppState`.
- Luu va khoi phuc du lieu tu SharedPreferences.

## 2. Module Screens

Vi tri:

```text
lib/screens/
```

Chuc nang:

- Dang nhap/dang ky.
- Tong quan.
- Them thu nhap/chi phi.
- Tiet kiem.
- Thong bao.
- Thong ke.

## 3. Module Services

Vi tri:

```text
lib/services/
```

Chuc nang:

- `insight_service.dart`: tao canh bao va goi y chi tieu.
- `notification_service.dart`: local notification.
- `report_service.dart`: xuat PDF/Excel.
- `home_widget_service.dart`: cap nhat widget Android.

## 4. Module Theme

Vi tri:

```text
lib/theme/
```

Chuc nang:

- Mau sac.
- Theme sang/toi.
- Background ung dung.
