# Data Design - Monex

## 1. Mục Tiêu Thiết Kế Dữ Liệu

Dữ liệu của Monex được thiết kế để phục vụ app quản lý tài chính cá nhân chạy cục bộ. Mục tiêu quan trọng nhất là dữ liệu của từng tài khoản phải được tách riêng và các giao dịch phải thống kê đúng theo ngày giao dịch.

## 2. Thực Thể Chính

### 2.1 UserAccount

| Thuộc tính | Kiểu | Mô tả |
| --- | --- | --- |
| `username` | String | Tên đăng nhập |
| `email` | String | Email người dùng |
| `password` | String | Mật khẩu demo cục bộ |

### 2.2 AccountLedger

`AccountLedger` là vùng dữ liệu riêng của mỗi tài khoản.

| Thuộc tính | Mô tả |
| --- | --- |
| `transactions` | Danh sách giao dịch thu/chi |
| `goals` | Danh sách mục tiêu tiết kiệm |
| `reminders` | Danh sách hóa đơn/lời nhắc |
| `recurringRules` | Quy tắc giao dịch lặp lại |
| `incomeCategories` | Danh mục thu nhập |
| `expenseCategories` | Danh mục chi phí |
| `budgetLimits` | Ngân sách theo danh mục |

### 2.3 TransactionEntry

| Thuộc tính | Kiểu | Mô tả |
| --- | --- | --- |
| `id` | String | Mã giao dịch |
| `type` | TransactionType | Thu nhập hoặc chi phí |
| `title` | String | Tên giao dịch |
| `category` | String | Danh mục |
| `amount` | double | Số tiền |
| `date` | DateTime | Ngày giao dịch dùng cho thống kê |
| `createdAt` | DateTime | Ngày tạo dữ liệu trong app |
| `paymentMethod` | String | Phương thức thanh toán/nhận tiền |
| `icon` | IconData | Icon hiển thị |

### 2.4 SavingsGoal

| Thuộc tính | Kiểu | Mô tả |
| --- | --- | --- |
| `id` | String | Mã mục tiêu |
| `title` | String | Tên mục tiêu |
| `targetAmount` | double | Số tiền cần đạt |
| `currentAmount` | double | Số tiền đã tiết kiệm |
| `deadline` | DateTime | Hạn mục tiêu |
| `frequency` | String | Tần suất dự kiến |
| `icon` | IconData | Icon hiển thị |

### 2.5 ReminderEntry

| Thuộc tính | Kiểu | Mô tả |
| --- | --- | --- |
| `id` | String | Mã hóa đơn/lời nhắc |
| `title` | String | Tên hóa đơn |
| `amount` | double | Số tiền cần thanh toán |
| `reminderDate` | DateTime | Ngày nhắc |
| `dueDate` | DateTime | Ngày đến hạn |
| `frequency` | String | Tần suất |
| `isPaid` | bool | Đã thanh toán hay chưa |
| `paidAt` | DateTime? | Thời điểm thanh toán |

### 2.6 RecurringTransactionRule

| Thuộc tính | Kiểu | Mô tả |
| --- | --- | --- |
| `id` | String | Mã quy tắc |
| `type` | TransactionType | Thu hoặc chi |
| `title` | String | Tên giao dịch lặp lại |
| `category` | String | Danh mục |
| `amount` | double | Số tiền |
| `frequency` | String | Tần suất lặp |
| `dayOfMonth` | int | Ngày trong tháng |
| `nextRunDate` | DateTime | Lần chạy tiếp theo |
| `isActive` | bool | Còn hoạt động hay không |

## 3. Quan Hệ Dữ Liệu

```text
UserAccount 1 --- 1 AccountLedger
AccountLedger 1 --- n TransactionEntry
AccountLedger 1 --- n SavingsGoal
AccountLedger 1 --- n ReminderEntry
AccountLedger 1 --- n RecurringTransactionRule
AccountLedger 1 --- n BudgetInfo
```

## 4. Lưu Trữ

Monex lưu dữ liệu cục bộ bằng SharedPreferences theo dạng JSON. Khi app mở:

1. Đọc danh sách tài khoản.
2. Đọc ledger tương ứng với từng tài khoản.
3. Khôi phục dữ liệu vào `MonexAppState`.
4. UI render theo tài khoản đang đăng nhập.

## 5. Quy Tắc Toàn Vẹn Dữ Liệu

- Số tiền giao dịch phải lớn hơn 0.
- Tài khoản mới phải có ledger riêng.
- Danh mục không được trùng tên trong cùng một tài khoản.
- Rút tiền tiết kiệm không được vượt quá số tiền hiện có.
- Hóa đơn đã thanh toán không còn được tính là quá hạn.
- Thống kê tháng/năm phải dùng `TransactionEntry.date`.

## 6. Hướng Phát Triển Dữ Liệu

- Chuyển SharedPreferences sang SQLite/Hive/Isar khi dữ liệu lớn hơn.
- Thêm backend để đồng bộ nhiều thiết bị.
- Mã hóa dữ liệu nhạy cảm nếu triển khai thực tế.
