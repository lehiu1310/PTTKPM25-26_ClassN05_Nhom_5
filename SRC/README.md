# SRC - Mục Lục Source Code

Theo yêu cầu học phần, repository cần có thư mục `SRC` để chỉ rõ phần mã nguồn chương trình.

Với Monex, mã nguồn Flutter/Android được đặt trực tiếp tại thư mục gốc repository để Android Studio có thể mở và chạy app ngay, không phải đi thêm một tầng thư mục. Vì vậy thư mục `SRC` đóng vai trò mục lục source code, còn các thành phần source thật nằm ở các đường dẫn sau:

| Thành phần | Đường dẫn | Vai trò |
| --- | --- | --- |
| Source giao diện và logic Flutter | `lib/` | Màn hình, state, service, theme |
| Cấu hình Android | `android/` | Gradle, manifest, launcher icon, home widget |
| Khai báo package | `pubspec.yaml` | Dependency Flutter/Dart |
| Kiểm thử | `test/` | Test logic và widget |
| Script hỗ trợ | `tools/` | Analyze, format, build, chạy emulator trên ổ D |

## Cách Mở Source

Mở trực tiếp thư mục gốc repository trong Android Studio:

```text
D:\HOC_TAP\quan_ly_tai_chinh\monex
```

Thư mục này có đầy đủ `pubspec.yaml`, `lib/`, `android/` và có thể bấm Run trực tiếp trên Android Emulator.

## Ghi Chú

Không đặt thêm một bản source trùng lặp vào `SRC/monex` để tránh sai lệch giữa hai bản code. Source chính thức của app là các thư mục ở root được liệt kê ở bảng trên.
