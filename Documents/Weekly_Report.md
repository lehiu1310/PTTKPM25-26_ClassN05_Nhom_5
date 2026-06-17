# Weekly Report - Monex

## Tuần 1 - Khởi Tạo Và Xác Định Bài Toán

**Mục tiêu:** xây dựng nền tảng ban đầu cho ứng dụng quản lý tài chính cá nhân.

**Công việc đã thực hiện:**

- Khởi tạo project Flutter cho nền tảng Android.
- Xác định nhóm chức năng chính: tài khoản, thu nhập, chi phí, tiết kiệm, hóa đơn, thống kê.
- Tạo cấu trúc màn hình ban đầu gồm đăng nhập, đăng ký và tổng quan.
- Tạo model dữ liệu sơ bộ cho tài khoản và giao dịch.

**Kết quả:** app có khung giao diện và có thể chạy thử trên Android Emulator.

## Tuần 2 - Tài Khoản Và Thu Chi

**Mục tiêu:** hoàn thiện luồng nhập dữ liệu tài chính cơ bản.

**Công việc đã thực hiện:**

- Bổ sung đăng ký, đăng nhập, đăng xuất.
- Lưu tài khoản cục bộ bằng SharedPreferences.
- Tách dữ liệu theo từng tài khoản để tránh lẫn thu chi.
- Thêm chức năng nhập thu nhập, chi phí và danh mục.
- Cho phép chọn ngày giao dịch để nhập dữ liệu của tháng trước hoặc năm trước.

**Kết quả:** người dùng có thể tạo tài khoản riêng và ghi nhận giao dịch cơ bản.

## Tuần 3 - Giao Diện, Tiết Kiệm Và Hóa Đơn

**Mục tiêu:** cải thiện trải nghiệm sử dụng và mở rộng chức năng quản lý tài chính.

**Công việc đã thực hiện:**

- Thiết kế lại giao diện dashboard, bottom navigation và background.
- Bổ sung skeleton/empty state để màn hình không bị trắng khi load dữ liệu.
- Thêm chức năng mục tiêu tiết kiệm.
- Cho phép nạp tiền nhiều lần và rút tiền khỏi mục tiêu tiết kiệm.
- Thêm hóa đơn/lời nhắc với ngày đến hạn.

**Kết quả:** app có trải nghiệm đầy đủ hơn, không chỉ ghi thu chi mà còn quản lý mục tiêu và nghĩa vụ thanh toán.

## Tuần 4 - Thống Kê Và Trợ Lý Chi Tiêu

**Mục tiêu:** giúp người dùng hiểu dữ liệu tài chính thay vì chỉ lưu giao dịch.

**Công việc đã thực hiện:**

- Bổ sung thống kê theo tháng, năm và danh mục.
- Sửa logic để giao dịch của tháng nào chỉ tính vào đúng tháng đó.
- Thêm so sánh kỳ trước, xu hướng chi tiêu và danh mục nổi bật.
- Bổ sung trợ lý chi tiêu dựa trên AI Rule.
- Cải thiện thông báo trong app khi thêm thu nhập, chi phí, tiết kiệm hoặc hóa đơn.

**Kết quả:** app có khả năng phân tích dữ liệu thực tế và cảnh báo có ngữ cảnh hơn.

## Tuần 5 - Báo Cáo, Tài Liệu Và GitHub

**Mục tiêu:** hoàn thiện repository theo yêu cầu học phần.

**Công việc đã thực hiện:**

- Sắp xếp repository theo các thư mục `Documents`, `Design`, `SRC`.
- Bổ sung README, CHANGELOG, Project Plan, SRS, Project Report.
- Cập nhật báo cáo học phần dạng `.docx`.
- Bổ sung tài liệu thiết kế kiến trúc, thiết kế chương trình, thiết kế dữ liệu.
- Đẩy source code và tài liệu lên GitHub.

**Kết quả:** repository có đủ source code, tài liệu và lịch sử thay đổi để giảng viên kiểm tra.

## Tuần 6 - Rà Soát Theo Yêu Cầu Git

**Mục tiêu:** đối chiếu repository với file yêu cầu Git của học phần.

**Công việc đã thực hiện:**

- Kiểm tra các thư mục bắt buộc: `Documents`, `Design`, `SRC`.
- Bổ sung checklist đối chiếu yêu cầu.
- Bổ sung sơ đồ draw.io cho SRS và kiến trúc.
- Bổ sung sketch giao diện trong thư mục `Design/Sketches`.
- Bổ sung slide trình bày dự án.

**Kết quả:** repository được hoàn thiện hơn, dễ kiểm tra và phù hợp hơn với yêu cầu bài tập lớn.
