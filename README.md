# Monex - Quản Lý Tài Chính Cá Nhân

Repository bài tập lớn môn phân tích và thiết kế phần mềm

## Cấu Trúc Theo Yêu Cầu

```text
Quan-Ly-Tai-Chinh-Monex/
|-- Documents/      # Ke hoach, SRS, bao cao hang tuan, bao cao du an
|-- Design/         # Thiet ke kien truc, chuong trinh, du lieu, sketch
|-- SRC/            # Source code chuong trinh
|-- CHANGELOG.md    # Lich su thay doi
`-- README.md       # Thong tin du an
```

## Thông Tin Dự Án

- Tên dự án: Monex - Quan ly tai chinh ca nhan
- Nền tảng: Android
- Framework: Flutter
- Ngôn ngữ: Dart
- Lưu trữ dữ liệu: SharedPreferences
- IDE: Android Studio

## Chức Năng Chính

- Đăng ký, đăng nhập, đăng xuất tài khỏan.
- Tách dữ liệu thu chi theo từng tài khỏan.
- Thêm thu nhập, chi phí, danh mục và ngày giao dịch.
- Nhập giao dịch của tháng trước/năm trước.
- Thống kê theo tháng và năm, không cộng dồn sai giữa các tháng.
- Quản lý tiết kiệm theo mục tiêu, nạp/rút tiền nhiều lần.
- Tạo hóa đơn, lời nhắc và thông báo cục bộ.
- Trợ lý AI chi tiêu dựa trên dữ liệu thực.
- Xuất báo cáo PDF/Excel.

## Source Code

Source Flutter nằm tại:

```text
SRC/monex
```

Mở project bằng Android Studio tại thư mục:

```text
D:\HOC_TAP\quan_ly_tai_chinh\monex\SRC\monex
```

Không mở thu mục cha `D:\HOC_TAP\quan_ly_tai_chinh\monex` nếu muốn chạy app, vì thư mục cha chỉ là repository tổng hợp tài liệu + source.

## Chạy App

Trong Android Studio:

1. File -> Open.
2. Chọn `D:\HOC_TAP\quan_ly_tai_chinh\monex\SRC\monex`.
3. Chọn Android Emulator.
4. Bấm Run.

Hoặc build debug bằng Gradle:

```powershell
cd D:\HOC_TAP\quan_ly_tai_chinh\monex\SRC\monex\android
.\gradlew.bat :app:assembleDebug -Ptarget-platform=android-x64 --no-daemon
```

APK debug sau khi build:

```text
SRC/monex/build/app/outputs/flutter-apk/app-debug.apk
```

## Tài Khoản Demo

```text
Username: minh
Email: minh@monex.vn
Password: 123456
```

## Tài Liệu

- Kế hoạch dự án: `Documents/Project_Plan.md`
- SRS: `Documents/SRS.md`
- Báo cáo hàng tuan: `Documents/Weekly_Report.md`
- Báo cáo dự án: `Documents/Project_Report.md`
- Báo cáo PDF: `Documents/Bao_cao_Monex.pdf`
- Thiết kế kiến trúc: `Design/Architecture.md`
- Thiết kế chương trình: `Design/Program_Design.md`
- Thiết kế dữ liệu: `Design/Data_Design.md`

## Ghi Chú Git

- Các thư mục build/cache như `.runtime`, `.dart_tool`, `build` không đưa lên GitHub.
