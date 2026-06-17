# Checklist Đối Chiếu Yêu Cầu Git Và Tổ Chức BTL

Tài liệu này đối chiếu repository Monex với file yêu cầu Git của học phần Phân tích và Thiết kế Phần mềm.

## 1. Thông Tin Git

| Yêu cầu | Trạng thái | Minh chứng |
| --- | --- | --- |
| Mỗi nhóm có 01 tài khoản GitHub/GitLab | Đã có | Repository GitHub của nhóm |
| Tên Git theo mẫu `PTTKPM25-26_ClassNx_Nhom` | Đã có | `PTTKPM25-26_ClassN05_Nhom_5` |
| Source code và tài liệu liên quan đưa lên Git | Đã có | Source Flutter + `Documents/` + `Design/` |
| Add giảng viên vào Git | Sinh viên tự thực hiện | Tài khoản chủ repo sẽ add giảng viên theo email yêu cầu |

## 2. Tài Liệu Bắt Buộc

| Yêu cầu trong PDF | Trạng thái | File/thư mục trong repo |
| --- | --- | --- |
| Plan dự án | Đã có | `Documents/Project_Plan.md` |
| Báo cáo hàng tuần | Đã có | `Documents/Weekly_Report.md` |
| SRS: phân tích yêu cầu và đặc tả | Đã có | `Documents/SRS.md` |
| SRS/draw.io | Đã bổ sung | `Documents/SRS_UseCase.drawio` |
| Thiết kế kiến trúc, mô hình hóa | Đã có | `Design/Architecture.md`, `Design/Architecture_Model.drawio` |
| Thiết kế chương trình | Đã có | `Design/Program_Design.md` |
| Thiết kế dữ liệu/CSDL | Đã có | `Design/Data_Design.md` |
| Báo cáo dự án dạng doc | Đã có | `Documents/Baocao_Monex.docx` |
| Slide trình bày | Đã bổ sung | `Documents/Monex_Presentation.pptx` |
| README note thông tin dự án | Đã có | `README.md` |
| CHANGELOG các thay đổi | Đã có | `CHANGELOG.md` |

## 3. Thư Mục Bắt Buộc

| Yêu cầu trong PDF | Trạng thái | Ghi chú |
| --- | --- | --- |
| `Documents` | Đã có | Chứa kế hoạch, SRS, weekly report, report, slide |
| `Design` | Đã có | Chứa kiến trúc, chương trình, dữ liệu, sketch, draw.io |
| `SRC` | Đã có | Có mục lục source code; source Flutter đặt ở root để Android Studio mở trực tiếp |
| Sketch/ảnh thiết kế | Đã bổ sung | `Design/Sketches/monex_mobile_wireframe.svg` |

## 4. Ghi Chú Về Thư Mục Source

Theo yêu cầu học phần cần có thư mục `SRC`. Với Monex, để app chạy thuận tiện bằng Android Studio, source Flutter được đặt trực tiếp ở root repository:

- `lib/`: source Dart/Flutter.
- `android/`: cấu hình Android.
- `pubspec.yaml`: package Flutter.
- `test/`: kiểm thử.

Thư mục `SRC/README.md` đóng vai trò mục lục source code, tránh tạo thêm một bản source trùng lặp gây lệch code.

## 5. Kết Luận

Repository hiện đã có đủ các nhóm tài liệu, source code, README, changelog, báo cáo, slide, sketch và sơ đồ theo yêu cầu Git của học phần. Phần duy nhất sinh viên cần tự thao tác trên GitHub là add email giảng viên vào repository.
