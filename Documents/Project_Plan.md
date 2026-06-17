# Project Plan - Monex

## 1. Thong Tin Du An

- Ten du an: Monex - Quan ly tai chinh ca nhan
- Nen tang: Android
- Cong nghe: Flutter, Dart, Android SDK
- Luu tru du lieu: SharedPreferences cuc bo
- Doi tuong su dung: sinh vien, nguoi dung ca nhan muon theo doi thu chi hang ngay
- Muc tieu hoc phan: phan tich yeu cau, thiet ke he thong, to chuc source code va trinh bay san pham co kha nang chay thu tren Android

## 2. Muc Tieu

Monex duoc xay dung de ho tro nguoi dung quan ly tai chinh ca nhan mot cach don gian nhung day du. Ung dung tap trung vao cac bai toan thuc te: ghi nhan thu nhap, chi tieu, tiet kiem, hoa don, nhac nho va thong ke theo tung thang/nam.

Muc tieu cu the:

- Cho phep nguoi dung tao tai khoan rieng va du lieu cua moi tai khoan khong bi lan nhau.
- Ghi nhan giao dich thu nhap va chi phi theo ngay, thang, nam tuy chon.
- Ho tro danh muc linh hoat de nguoi dung co the them cac khoan phat sinh nhu tien nha, tien dien, tien nuoc, xang xe, hoc phi, y te, giai tri.
- Thong ke thu/chi dung theo moc thoi gian, tranh tinh sai du lieu cua thang truoc sang thang hien tai.
- Ho tro muc tieu tiet kiem theo kieu "bo lon": co the nap tien nhieu lan va rut tien khi can.
- Tao hoa don/loi nhac den han va xu ly trang thai da thanh toan.
- Cai tien tro ly chi tieu bang cac quy tac phan tich du lieu de canh bao thuc te hon.
- Co tai lieu bao cao, SRS, ke hoach va thiet ke ro rang de phuc vu danh gia hoc phan.

## 3. Pham Vi Du An

### 3.1 Pham Vi Da Thuc Hien

- Dang ky, dang nhap, dang xuat tai khoan.
- Luu nhieu tai khoan cuc bo, moi tai khoan co ledger rieng.
- Them thu nhap, chi phi, giao dich tong hop.
- Them danh muc thu/chi phat sinh.
- Nhap giao dich theo ngay bat ky, bao gom thang truoc va nam truoc.
- Loc va tim kiem giao dich.
- Dashboard tong quan so du, tong thu, tong chi theo thang hien tai.
- Thong ke theo thang, theo nam, theo danh muc.
- Bieu do xu huong va so sanh voi ky truoc.
- Quan ly ngan sach theo danh muc.
- De xuat ngan sach dua tren lich su thu/chi.
- Tao muc tieu tiet kiem, nap tien, rut tien.
- Tao hoa don/loi nhac, danh dau da xu ly.
- Thong bao trong app khi them thu/chi, nap tiet kiem, thanh toan hoa don.
- Tro ly chi tieu dua tren du lieu thuc: canh bao vuot ngan sach, giao dich bat thuong, xu huong tang chi.
- Xuat bao cao PDF/Excel o muc demo.
- Chay duoc tren Android Emulator va Android Studio.

### 3.2 Ngoai Pham Vi Hien Tai

- Chua co backend va dong bo cloud.
- Chua co xac thuc email/OTP that.
- Chua co ket noi ngan hang that.
- Chua co AI online su dung API ben ngoai; tro ly hien tai dung AI Rule/heuristic dua tren du lieu cuc bo.

## 4. Ke Hoach Cong Viec

| Giai doan | Noi dung | Ket qua mong doi | Trang thai |
| --- | --- | --- | --- |
| 1. Khoi tao | Tao Flutter project, cau truc thu muc, theme co ban | Project build duoc tren Android | Hoan thanh |
| 2. Phan tich yeu cau | Xac dinh tac nhan, chuc nang, luong du lieu | Tai lieu SRS ban dau | Hoan thanh |
| 3. Thiet ke UI/UX | Man dang nhap, tong quan, them giao dich, thong ke, tiet kiem | Giao dien de dung, phu hop app tai chinh | Hoan thanh |
| 4. Tai khoan | Dang ky, dang nhap, dang xuat, luu tai khoan cuc bo | Moi tai khoan co du lieu rieng | Hoan thanh |
| 5. Thu chi | Them thu nhap, chi phi, danh muc, ngay giao dich | Giao dich duoc luu va hien thi dung | Hoan thanh |
| 6. Thong ke | Tong quan, loc thang/nam, bieu do, xu huong | Nguoi dung nam duoc tinh hinh tai chinh | Hoan thanh |
| 7. Tiet kiem | Tao muc tieu, nap tien nhieu lan, rut tien | Mo phong bo lon tiet kiem | Hoan thanh |
| 8. Hoa don | Tao loi nhac, canh bao den han, xu ly thanh toan | Hoa don da xu ly khong con bao qua han | Hoan thanh |
| 9. Tro ly chi tieu | AI Rule, canh bao bat thuong, goi y ngan sach | Canh bao thuc te theo du lieu tai khoan | Hoan thanh |
| 10. Bao cao | Cap nhat report, plan, SRS, README | Repo co tai lieu nop bai | Hoan thanh |
| 11. Kiem thu | Analyze, build debug, chay tren emulator | App on dinh truoc khi nop | Hoan thanh |

## 5. Phan Cong Va Quan Ly Tien Do

Du an duoc to chuc theo cac nhom cong viec:

- Nhom phan tich: viet SRS, xac dinh yeu cau chuc nang va phi chuc nang.
- Nhom thiet ke: thiet ke cau truc du lieu, kien truc ung dung, giao dien chinh.
- Nhom lap trinh: cai dat Flutter UI, state, service, logic thong ke va thong bao.
- Nhom kiem thu: kiem tra dang ky/dang nhap, them thu chi, thong ke theo thang/nam, tiet kiem va hoa don.
- Nhom tai lieu: cap nhat bao cao, project plan, weekly report, README.

## 6. Moc Kiem Thu Chinh

| Ma | Hang muc kiem thu | Tieu chi dat |
| --- | --- | --- |
| TC-01 | Dang ky tai khoan moi | Tai khoan duoc luu va co ledger rong rieng |
| TC-02 | Dang nhap lai tai khoan | Tai khoan van con sau khi thoat app |
| TC-03 | Tach du lieu tai khoan | Tai khoan A khong thay thu/chi cua tai khoan B |
| TC-04 | Them thu nhap | So du va thong ke thu nhap cap nhat dung |
| TC-05 | Them chi phi | So du va thong ke chi phi cap nhat dung |
| TC-06 | Giao dich thang truoc | Chi tinh vao thang duoc chon, khong cong nham sang thang hien tai |
| TC-07 | Them danh muc | Danh muc moi hien trong form va duoc dung cho giao dich |
| TC-08 | Nap tiet kiem | Tien da tiet kiem tang theo tung lan nap |
| TC-09 | Rut tiet kiem | So tien muc tieu giam dung va khong am |
| TC-10 | Thanh toan hoa don | Hoa don da xu ly khong con hien la qua han |
| TC-11 | Thong bao trong app | Khi them thu/chi co thong bao ngay trong app |
| TC-12 | Tro ly chi tieu | Goi y/canh bao dua tren du lieu thuc, khong bao lung tung khi chua co du lieu |

## 7. Quan Ly Rui Ro

| Rui ro | Anh huong | Cach xu ly |
| --- | --- | --- |
| Du lieu chi luu cuc bo | Mat du lieu neu xoa app/thiet bi | Ghi ro gioi han, de xuat cloud sync o huong phat trien |
| Nhieu kich thuoc man hinh Android | UI co the bi tran/noi dung kho bam | Dung scroll view, nut lon, test tren emulator |
| Thong ke sai moc thoi gian | Lam nguoi dung hieu sai tinh hinh tai chinh | Tach logic theo thang/nam va dung ngay giao dich |
| Thong bao qua nhieu | Trai nghiem bi phien | Chi tao canh bao khi co dieu kien ro rang |
| AI Rule bi xem la "lam cho co" | Giam gia tri san pham | Dua ra goi y theo lich su thu/chi, ngan sach, bat thuong va xu huong |
| Repo qua nhieu file khong can thiet | GitHub roi mat | Loai build/cache, chi giu source va tai lieu quan trong |

## 8. Tieu Chi Hoan Thanh

Du an duoc xem la hoan thanh khi:

- App build duoc tren Android Studio.
- Dang ky, dang nhap, dang xuat hoat dong.
- Tai khoan moi khong bi dung chung thu/chi voi tai khoan cu.
- Them thu nhap, chi phi, danh muc, tiet kiem, hoa don deu su dung duoc.
- Thong ke theo thang/nam khong bi cong don sai.
- Tro ly chi tieu va thong bao trong app dua tren du lieu that.
- Repo GitHub co source code, README, Project Plan, SRS, bao cao va thiet ke.
- `flutter analyze` khong co loi.

## 9. Huong Phat Trien

- Dong bo cloud de dang nhap nhieu thiet bi.
- Them backend API va database rieng.
- Them xac thuc email/OTP.
- Tich hop OCR hoa don de tu dong doc so tien.
- Them export bao cao sau hon voi bieu do va bang tong hop theo nam.
- Them AI online de hoi dap bang ngon ngu tu nhien neu co dieu kien API.
- Them widget Android hien so du nhanh ngoai man hinh chinh.
