# Architecture Design - Monex

## 1. Mục Tiêu Thiết Kế

Kiến trúc của Monex được thiết kế theo hướng đơn giản, dễ chạy trên Android Studio và phù hợp với phạm vi bài tập lớn. Ứng dụng hoạt động cục bộ, không phụ thuộc backend, nhưng vẫn tách rõ các nhóm trách nhiệm để dễ bảo trì.

## 2. Kiến Trúc Tổng Quan

```text
UI Layer
   |
   v
Application State Layer
   |
   v
Service Layer
   |
   v
Local Storage / Android Platform
```

## 3. Các Layer Chính

| Layer | Thành phần | Vai trò |
| --- | --- | --- |
| UI Layer | `lib/screens`, `lib/widgets`, `lib/theme` | Hiển thị giao diện, nhận thao tác người dùng |
| Application State | `lib/data/app_state.dart` | Quản lý tài khoản, ledger, giao dịch, tiết kiệm, hóa đơn, ngân sách |
| Service Layer | `lib/services` | Thông báo, insight, AI Rule, báo cáo, home widget |
| Local Storage | SharedPreferences | Lưu dữ liệu tài khoản và dữ liệu tài chính cục bộ |
| Android Platform | `android/` | Cấu hình Android, launcher icon, notification, widget |

## 4. Luồng Dữ Liệu

1. Người dùng thao tác trên màn hình Flutter.
2. Màn hình gọi hàm trong `MonexAppState`.
3. `MonexAppState` cập nhật ledger của tài khoản hiện tại.
4. Service tương ứng được gọi nếu cần, ví dụ tạo thông báo hoặc phân tích cảnh báo.
5. Dữ liệu được lưu lại vào SharedPreferences.
6. UI lắng nghe thay đổi và render lại màn hình.

## 5. Tách Dữ Liệu Theo Tài Khoản

Monex dùng khái niệm `AccountLedger` để quản lý dữ liệu riêng của từng tài khoản. Mỗi ledger chứa:

- Danh sách giao dịch.
- Mục tiêu tiết kiệm.
- Hóa đơn/lời nhắc.
- Danh mục thu nhập.
- Danh mục chi phí.
- Ngân sách theo danh mục.
- Quy tắc giao dịch lặp lại.

Thiết kế này đảm bảo tài khoản mới không nhìn thấy thu chi của tài khoản cũ.

## 6. Kiến Trúc Trợ Lý Chi Tiêu

Trợ lý chi tiêu được đặt ở service riêng để không làm rối UI:

```text
Transactions + Budgets + Reminders
        |
        v
AI Rule / Insight Services
        |
        v
Smart Notifications + Budget Suggestions + Dashboard Alerts
```

Các cảnh báo chính:

- Vượt hoặc gần vượt ngân sách.
- Chi phí cao bất thường so với trung bình danh mục.
- Xu hướng chi tiêu tăng liên tục.
- Hóa đơn sắp đến hạn hoặc quá hạn.
- Gợi ý ngân sách tháng tới.

## 7. Ưu Điểm

- Dễ mở và chạy trực tiếp bằng Android Studio.
- Không cần cài backend/database ngoài.
- Dễ kiểm thử logic cục bộ.
- Dữ liệu từng tài khoản được cô lập.
- Có thể mở rộng sang backend/cloud sync trong tương lai.

## 8. Hạn Chế Và Hướng Mở Rộng

| Hạn chế hiện tại | Hướng phát triển |
| --- | --- |
| Dữ liệu chỉ lưu cục bộ | Thêm backend API và cloud sync |
| AI Rule chưa dùng model online | Tích hợp AI API nếu có điều kiện |
| SharedPreferences phù hợp demo hơn dữ liệu lớn | Chuyển sang SQLite/Isar/Hive |
| Chưa có xác thực email thật | Thêm Firebase Auth hoặc backend auth |
