# Program Design - Monex

## 1. Mục Tiêu

Tài liệu này mô tả cách chia module chương trình của Monex, vai trò của từng nhóm file và các chức năng chính trong app.

## 2. Cấu Trúc Module

```text
lib/
|-- data/       # Model dữ liệu, AppState, lưu/khôi phục dữ liệu
|-- screens/    # Màn hình giao diện
|-- services/   # Notification, báo cáo, insight, AI Rule
|-- theme/      # Màu sắc, theme, background
`-- widgets/    # Widget dùng chung
```

## 3. Module Data

**Vị trí:** `lib/data/`

**Thành phần chính:**

- `UserAccount`: thông tin tài khoản.
- `TransactionEntry`: giao dịch thu/chi.
- `SavingsGoal`: mục tiêu tiết kiệm.
- `ReminderEntry`: hóa đơn/lời nhắc.
- `RecurringTransactionRule`: quy tắc giao dịch lặp lại.
- `BudgetInfo`: ngân sách danh mục.
- `MonexAppState`: trung tâm quản lý trạng thái app.

**Trách nhiệm:**

- Đăng ký, đăng nhập, đăng xuất.
- Quản lý ledger riêng theo từng tài khoản.
- Thêm thu nhập, chi phí, danh mục.
- Thêm/nạp/rút mục tiêu tiết kiệm.
- Thêm/xử lý hóa đơn.
- Lưu và khôi phục dữ liệu từ SharedPreferences.

## 4. Module Screens

**Vị trí:** `lib/screens/`

| Nhóm màn hình | Vai trò |
| --- | --- |
| `auths/` | Đăng nhập, đăng ký, quên mật khẩu |
| `onboarding/` | Giới thiệu app lần đầu |
| `pages/overview_page.dart` | Dashboard tổng quan |
| `pages/add_income_page.dart` | Thêm thu nhập |
| `pages/add_expense_page.dart` | Thêm chi phí |
| `pages/analytics_page.dart` | Thống kê, biểu đồ, calendar, AI Rule panel |
| `pages/notification_page.dart` | Thông báo và cảnh báo thông minh |
| `pages/savings_page.dart` | Danh sách mục tiêu tiết kiệm |
| `pages/reminder_page.dart` | Hóa đơn/lời nhắc |
| `widgets/` | Empty state, skeleton, tab navigator, animated money |

## 5. Module Services

**Vị trí:** `lib/services/`

| Service | Vai trò |
| --- | --- |
| `ai_rule_service.dart` | Dự đoán chi tiêu, phát hiện bất thường, trend, đề xuất ngân sách |
| `insight_service.dart` | Tổng hợp insight và cảnh báo tài chính |
| `notification_service.dart` | Local notification và thông báo trong app |
| `report_service.dart` | Xuất báo cáo PDF/Excel |
| `home_widget_service.dart` | Cập nhật Android home widget |

## 6. Thiết Kế Chức Năng Chính

### 6.1 Đăng Ký Tài Khoản

```text
RegisterScreen -> appState.register() -> tạo UserAccount -> tạo AccountLedger riêng -> lưu SharedPreferences
```

### 6.2 Thêm Giao Dịch

```text
AddIncome/AddExpense -> validate form -> appState.addTransaction() -> cập nhật ledger -> tạo thông báo -> lưu dữ liệu
```

### 6.3 Thống Kê Theo Tháng/Năm

```text
transactions -> lọc theo date.month/date.year -> tính tổng thu/chi -> biểu đồ + dashboard
```

Điểm quan trọng: dùng ngày giao dịch (`date`), không dùng ngày nhập (`createdAt`), để giao dịch tháng trước không bị cộng nhầm vào tháng hiện tại.

### 6.4 Xử Lý Hóa Đơn

```text
ReminderEntry quá hạn -> hiển thị cảnh báo -> người dùng bấm thanh toán -> markReminderPaid() -> ẩn khỏi nhóm quá hạn
```

### 6.5 Trợ Lý Chi Tiêu

```text
ledger hiện tại -> AI Rule Service -> cảnh báo/gợi ý -> notification/dashboard
```

## 7. Nguyên Tắc Thiết Kế

- UI không xử lý logic tài chính phức tạp.
- AppState là nơi cập nhật dữ liệu tập trung.
- Service phụ trách phân tích, thông báo và báo cáo.
- Dữ liệu tài khoản phải được cô lập.
- Form nhập liệu phải có validate để tránh dữ liệu sai.
