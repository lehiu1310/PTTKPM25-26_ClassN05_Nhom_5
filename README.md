# Monex - Ứng Dụng Quản Lý Tài Chính Cá Nhân

Monex là ứng dụng Android hỗ trợ người dùng quản lý thu nhập, chi tiêu, tiết kiệm, hóa đơn và ngân sách cá nhân. Ứng dụng được xây dựng bằng Flutter, tập trung vào trải nghiệm sử dụng trực quan, dữ liệu tách riêng theo từng tài khoản và các gợi ý tài chính dựa trên lịch sử thu chi thực tế.

Repository này được tổ chức phục vụ bài tập lớn học phần Phân tích và Thiết kế Phần mềm.

## Tổng Quan Dự Án

| Hạng mục | Thông tin |
| --- | --- |
| Tên ứng dụng | Monex |
| Lĩnh vực | Quản lý tài chính cá nhân |
| Nền tảng | Android |
| Framework | Flutter |
| Ngôn ngữ | Dart |
| Lưu trữ dữ liệu | SharedPreferences |
| IDE khuyến nghị | Android Studio |

## Điểm Nổi Bật

- Giao diện mobile hiện đại, phù hợp với ứng dụng tài chính cá nhân.
- Mỗi tài khoản có dữ liệu thu chi riêng, tránh lẫn dữ liệu giữa nhiều người dùng.
- Cho phép nhập giao dịch của tháng trước, năm trước và thống kê đúng theo thời gian giao dịch.
- Quản lý tiết kiệm theo kiểu "bỏ lợn": có thể nạp tiền nhiều lần và rút tiền khi cần.
- Hóa đơn có trạng thái xử lý, khi thanh toán xong sẽ không tiếp tục báo quá hạn.
- Trợ lý chi tiêu sử dụng AI Rule để phân tích ngân sách, phát hiện chi tiêu bất thường và đưa ra gợi ý thực tế.
- Hỗ trợ xuất báo cáo PDF/Excel ở mức demo phục vụ trình bày sản phẩm.

## Tính Năng Chính

### Tài Khoản

- Đăng ký tài khoản mới.
- Đăng nhập bằng tên đăng nhập hoặc email.
- Đăng xuất tài khoản.
- Lưu nhiều tài khoản cục bộ.
- Tách riêng dữ liệu thu chi, tiết kiệm, hóa đơn, danh mục và ngân sách theo từng tài khoản.

### Thu Nhập Và Chi Tiêu

- Thêm thu nhập theo tên, số tiền, danh mục, ngày giao dịch và phương thức nhận tiền.
- Thêm chi phí theo tên, số tiền, danh mục, ngày giao dịch và phương thức thanh toán.
- Thêm danh mục thu/chi phát sinh.
- Tìm kiếm và lọc giao dịch theo loại, danh mục, từ khóa, tháng hoặc năm.
- Ghi nhận giao dịch ở các mốc thời gian khác nhau mà không bị cộng dồn sai giữa các tháng.

### Thống Kê Và Ngân Sách

- Dashboard tổng quan số dư, tổng thu nhập, tổng chi phí theo tháng hiện tại.
- Thống kê theo tháng, theo năm và theo danh mục.
- So sánh thu/chi với kỳ trước.
- Biểu đồ xu hướng giúp người dùng nhìn nhanh mức tăng giảm chi tiêu.
- Gợi ý ngân sách theo các nhóm như ăn uống, tiền thuê nhà, tiền điện, tiền nước, xăng xe, mua sắm, y tế, giáo dục, giải trí.

### Tiết Kiệm

- Tạo mục tiêu tiết kiệm.
- Nạp tiền nhiều lần vào cùng một mục tiêu.
- Rút tiền khỏi mục tiêu khi cần sử dụng.
- Theo dõi tiến độ hoàn thành mục tiêu.

### Hóa Đơn Và Lời Nhắc

- Tạo hóa đơn hoặc lời nhắc thanh toán.
- Theo dõi ngày đến hạn.
- Cảnh báo hóa đơn sắp đến hạn hoặc quá hạn.
- Xử lý thanh toán để cập nhật trạng thái hóa đơn.

### Trợ Lý Chi Tiêu

Trợ lý chi tiêu trong Monex không tạo thông báo ngẫu nhiên. Các cảnh báo được tạo dựa trên dữ liệu thực của tài khoản hiện tại:

- Cảnh báo khi chi tiêu gần vượt hoặc đã vượt thu nhập tháng.
- Phát hiện giao dịch bất thường lớn hơn mức trung bình danh mục.
- Dự đoán xu hướng chi tiêu tháng tới dựa trên lịch sử giao dịch.
- Gợi ý cắt giảm khi một danh mục tăng liên tục.
- Đề xuất ngân sách hợp lý theo thói quen thu chi của người dùng.

## Công Nghệ Sử Dụng

| Nhóm | Công nghệ |
| --- | --- |
| Mobile | Flutter, Dart |
| Nền tảng chạy | Android |
| Lưu trữ cục bộ | SharedPreferences |
| Biểu đồ | fl_chart |
| Thông báo | flutter_local_notifications |
| Widget Android | home_widget |
| Báo cáo PDF | pdf, printing |
| Báo cáo Excel | syncfusion_flutter_xlsio |
| Chia sẻ file | share_plus |

## Cấu Trúc Thư Mục

```text
Quan-Ly-Tai-Chinh-Monex/
|-- Documents/      # Kế hoạch, SRS, báo cáo tuần, báo cáo học phần
|-- Design/         # Thiết kế kiến trúc, thiết kế dữ liệu, thiết kế chương trình
|-- android/        # Cấu hình Android
|-- lib/            # Source code Flutter/Dart
|-- test/           # Kiểm thử
|-- tools/          # Script hỗ trợ chạy, format, analyze trên máy local
|-- CHANGELOG.md    # Lịch sử thay đổi
|-- pubspec.yaml    # Khai báo package Flutter
`-- README.md       # Giới thiệu dự án
```

## Cách Chạy Ứng Dụng

### Chạy bằng Android Studio

1. Mở Android Studio.
2. Chọn `File -> Open`.
3. Chọn thư mục gốc của repository Monex.
4. Chọn Android Emulator hoặc thiết bị Android thật.
5. Bấm `Run`.

### Chạy bằng lệnh Flutter

```powershell
flutter pub get
flutter run
```

### Build APK debug

```powershell
cd android
.\gradlew.bat :app:assembleDebug -Ptarget-platform=android-x64 --no-daemon
```

File APK sau khi build:

```text
build/app/outputs/flutter-apk/app-debug.apk
```

## Tài Khoản Demo

```text
Username: minh
Email: minh@monex.vn
Password: 123456
```

Người dùng cũng có thể tạo tài khoản mới trực tiếp trong màn hình đăng nhập. Dữ liệu của tài khoản mới sẽ được tách riêng với tài khoản demo.

## Tài Liệu Dự Án

| Tài liệu | Đường dẫn |
| --- | --- |
| Kế hoạch dự án | `Documents/Project_Plan.md` |
| Đặc tả yêu cầu phần mềm | `Documents/SRS.md` |
| Báo cáo hàng tuần | `Documents/Weekly_Report.md` |
| Báo cáo tổng hợp dự án | `Documents/Project_Report.md` |
| Báo cáo học phần | `Documents/Baocao_Monex.docx` |
| Slide trình bày | `Documents/Monex_Presentation.pptx` |
| Checklist yêu cầu Git | `Documents/Git_Requirement_Checklist.md` |
| Sơ đồ use case SRS | `Documents/SRS_UseCase.drawio` |
| Thiết kế kiến trúc | `Design/Architecture.md` |
| Sơ đồ kiến trúc | `Design/Architecture_Model.drawio` |
| Thiết kế chương trình | `Design/Program_Design.md` |
| Thiết kế dữ liệu | `Design/Data_Design.md` |
| Sketch giao diện | `Design/Sketches/monex_mobile_wireframe.svg` |

## Trạng Thái Hiện Tại

- App đã chạy được trên Android Emulator.
- Các chức năng chính đã hoàn thiện ở mức demo học phần.
- Source code đã được tổ chức ở thư mục gốc repository để mở trực tiếp bằng Android Studio.
- Tài liệu phân tích, kế hoạch, báo cáo và thiết kế đã được cập nhật trong repository.
- Repository đã có checklist đối chiếu yêu cầu Git, sơ đồ draw.io, sketch giao diện và slide trình bày.

## Ghi Chú

- Các thư mục build/cache như `.runtime`, `.dart_tool`, `build` không được đưa lên GitHub.
- Ứng dụng hiện lưu dữ liệu cục bộ, chưa có backend hoặc đồng bộ cloud.
- Trợ lý chi tiêu hiện dùng AI Rule/heuristic dựa trên dữ liệu trong app, chưa tích hợp API AI online.
