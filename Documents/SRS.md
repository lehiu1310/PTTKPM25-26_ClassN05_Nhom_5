# SRS - Software Requirements Specification

## 1. Gioi Thieu

### 1.1 Muc Dich

Tai lieu nay mo ta yeu cau phan mem cho ung dung Monex - ung dung quan ly tai chinh ca nhan tren Android. SRS dung de thong nhat pham vi, chuc nang, du lieu, rang buoc va tieu chi kiem thu cua san pham.

### 1.2 Pham Vi San Pham

Monex ho tro nguoi dung theo doi thu nhap, chi phi, tiet kiem, hoa don va ngan sach theo tung tai khoan. Ung dung khong chi ghi chep giao dich ma con dua ra thong ke va canh bao dua tren lich su su dung.

### 1.3 Doi Tuong Su Dung

- Sinh vien can quan ly tien an, tien nha, tien hoc, tien xang, chi phi ca nhan.
- Nguoi dung ca nhan muon theo doi thu/chi hang ngay.
- Giang vien/nguoi cham bai can xem kha nang phan tich, thiet ke va hien thuc app Android.

## 2. Mo Ta Tong Quan

### 2.1 Boi Canh He Thong

Monex la ung dung mobile chay cuc bo tren Android. Du lieu duoc luu tren thiet bi bang SharedPreferences. Cac service trong app xu ly thong bao, insight, AI Rule va bao cao.

### 2.2 Tac Nhan

| Tac nhan | Vai tro |
| --- | --- |
| Nguoi dung | Tao tai khoan, nhap thu/chi, xem thong ke, quan ly tiet kiem va hoa don |
| Tai khoan khach | Dung thu app nhanh voi du lieu demo |
| He thong thong bao | Tao thong bao trong app/local notification theo su kien |
| Tro ly chi tieu | Phan tich du lieu va dua ra canh bao/goi y |

### 2.3 Rang Buoc

- App phai build va chay tren Android Studio/Android Emulator.
- Du lieu cua tai khoan phai tach rieng.
- Cac tinh nang khong duoc phu thuoc backend.
- Thong ke phai tinh dung theo ngay giao dich, khong dua vao ngay nhap du lieu.
- Cac thong bao va goi y phai dua tren du lieu that, tranh tao thong bao gia khi khong co hanh dong.

## 3. Yeu Cau Chuc Nang

### FR-01. Dang Ky Tai Khoan

Nguoi dung co the tao tai khoan moi bang ten dang nhap, email va mat khau.

Tieu chi chap nhan:

- Ten dang nhap khong duoc rong.
- Email phai co dinh dang hop le o muc co ban.
- Mat khau toi thieu 6 ky tu.
- Neu ten dang nhap/email da ton tai thi hien thong bao loi.
- Sau khi dang ky thanh cong, tai khoan duoc luu lai de dang nhap lan sau.

### FR-02. Dang Nhap Va Dang Xuat

Nguoi dung co the dang nhap bang ten dang nhap/email va mat khau, sau do dang xuat khoi app.

Tieu chi chap nhan:

- Dang nhap sai hien thong bao ro rang.
- Dang nhap dung chuyen vao man hinh tong quan.
- Dang xuat dua ve man hinh dang nhap.
- Tai khoan da tao khong bi mat khi thoat app.

### FR-03. Tach Du Lieu Theo Tai Khoan

Moi tai khoan co ledger rieng gom giao dich, tiet kiem, hoa don, danh muc va ngan sach.

Tieu chi chap nhan:

- Tai khoan A them chi tieu thi tai khoan B khong thay du lieu do.
- Tai khoan moi co du lieu ban dau rong hoac mac dinh rieng.
- Tro ly chi tieu chi phan tich du lieu cua tai khoan hien tai.

### FR-04. Quan Ly Thu Nhap

Nguoi dung co the them thu nhap voi ten, so tien, danh muc, ngay giao dich va phuong thuc nhan tien.

Tieu chi chap nhan:

- So tien phai lon hon 0.
- Ngay giao dich co the la ngay hien tai, thang truoc hoac nam truoc.
- Sau khi them, tong thu nhap cua dung thang/nam duoc cap nhat.
- App tao thong bao trong app ve khoan thu vua them.

### FR-05. Quan Ly Chi Phi

Nguoi dung co the them chi phi voi ten, so tien, danh muc, ngay giao dich va phuong thuc thanh toan.

Tieu chi chap nhan:

- So tien phai lon hon 0.
- Danh muc co the la mac dinh hoac nguoi dung tu them.
- Giao dich cua thang nao chi tinh vao thang do.
- App tao thong bao trong app ve khoan chi vua them.

### FR-06. Quan Ly Danh Muc

Nguoi dung co the them danh muc thu nhap va chi phi phat sinh.

Tieu chi chap nhan:

- Ten danh muc khong duoc rong.
- Danh muc moi hien trong form them giao dich.
- Khong tao trung danh muc da ton tai.
- Danh muc duoc luu theo tai khoan.

### FR-07. Tim Kiem Va Loc Giao Dich

Nguoi dung co the tim giao dich theo tu khoa, danh muc, loai giao dich va khoang thoi gian.

Tieu chi chap nhan:

- Tim theo ten giao dich.
- Loc theo thu nhap/chi phi.
- Loc theo thang, nam hoac khoang ngay tuy chon.
- Ket qua hien dung voi du lieu tai khoan hien tai.

### FR-08. Tong Quan Tai Chinh

Man hinh tong quan hien so du, tong thu, tong chi, tiet kiem, hoa don va canh bao noi bat.

Tieu chi chap nhan:

- So du thang hien tai = thu nhap thang - chi phi thang.
- Tong thu/chi khong lay nham giao dich thang khac.
- Canh bao noi bat uu tien muc quan trong nhu vuot ngan sach, hoa don qua han.

### FR-09. Thong Ke Va Bieu Do

Ung dung cung cap thong ke theo thang, nam, danh muc va xu huong.

Tieu chi chap nhan:

- Co bieu do cot/duong cho thu chi.
- Co so sanh thang hien tai voi thang truoc.
- Co so sanh nam hien tai voi nam truoc neu co du lieu.
- Co phan tram tang/giam va danh muc chi tieu lon.
- Khi nhap du lieu 12 thang, moi thang duoc tinh rieng.

### FR-10. De Xuat Ngan Sach

He thong de xuat ngan sach theo danh muc dua tren lich su thu/chi.

Tieu chi chap nhan:

- Dua vao du lieu giao dich cua tai khoan hien tai.
- Goi y cac muc nhu tien nha, tien dien, tien nuoc, xang xe, an uong, mua sam, y te, giai tri.
- Co giai thich ngan gon vi sao de xuat muc do do.
- Neu chua co du lieu, hien goi y mac dinh hop ly thay vi canh bao sai.

### FR-11. Quan Ly Tiet Kiem

Nguoi dung co the tao muc tieu tiet kiem, nap tien nhieu lan va rut tien khi can.

Tieu chi chap nhan:

- Tao muc tieu voi ten, so tien muc tieu, han hoan thanh.
- Nap tien nhieu lan vao cung mot muc tieu.
- Rut tien khong duoc vuot qua so tien da tiet kiem.
- Tien do tiet kiem cap nhat sau moi lan nap/rut.

### FR-12. Hoa Don Va Loi Nhac

Nguoi dung co the tao hoa don/loi nhac voi ngay den han va trang thai xu ly.

Tieu chi chap nhan:

- Hoa don co ten, so tien, ngay den han.
- Hoa don qua han hien canh bao.
- Khi bam xu ly/thanh toan, hoa don duoc danh dau da thanh toan.
- Hoa don da thanh toan khong tiep tuc hien trong danh sach qua han.

### FR-13. Thong Bao Trong App

Ung dung hien thong bao ngay khi nguoi dung thuc hien hanh dong quan trong.

Tieu chi chap nhan:

- Them thu nhap tao thong bao "Da them thu nhap".
- Them chi phi tao thong bao "Da them chi phi".
- Nap/rut tiet kiem tao thong bao tuong ung.
- Thanh toan hoa don tao thong bao da xu ly.
- Thong bao khong duoc tu tao lung tung khi nguoi dung khong thao tac.

### FR-14. Tro Ly Chi Tieu / AI Rule

Tro ly chi tieu phan tich du lieu tai khoan de dua ra canh bao va goi y.

Tieu chi chap nhan:

- Canh bao khi chi phi gan vuot hoac vuot thu nhap thang.
- Phat hien giao dich bat thuong lon hon 2 lan trung binh danh muc gan day.
- Du doan chi tieu thang toi dua tren lich su 3-6 thang neu co du lieu.
- Goi y cat giam khi mot danh muc tang lien tiep nhieu thang.
- Neu du lieu it, tro ly hien goi y nhe nha, khong dua ra ket luan qua manh.

### FR-15. Giao Dich Lap Lai

Nguoi dung co the dat mot so giao dich lap lai nhu luong thang, tien nha, tien dien.

Tieu chi chap nhan:

- Giao dich lap lai co loai, ten, danh muc, so tien, tan suat.
- He thong co the nhan dien va tao/bao cao giao dich den ky.
- Giao dich lap lai duoc luu theo tai khoan.

### FR-16. Bao Cao Va Chia Se

Ung dung ho tro xuat bao cao PDF/Excel va luu tai lieu bao cao du an trong repo.

Tieu chi chap nhan:

- Co chuc nang xuat PDF/Excel o muc demo.
- Bao cao tong hop gom thu, chi, danh muc va thong ke.
- Repository co file bao cao hoc phan, Project Plan va SRS.

## 4. Yeu Cau Phi Chuc Nang

### NFR-01. Hieu Nang

- Man hinh chinh phai phan hoi nhanh voi du lieu demo/cuc bo.
- Cac phep thong ke thang/nam duoc tinh tren danh sach giao dich hien co.
- App khong duoc treo khi nhap du lieu nhieu thang.

### NFR-02. Kha Dung

- Giao dien de dung tren man hinh Android Emulator.
- Nut hanh dong chinh phai ro rang, de bam.
- Form nhap lieu co validation va thong bao loi de hieu.

### NFR-03. Bao Tri

- Source code chia theo `data`, `screens`, `services`, `theme`.
- Logic phan tich/tro ly dat trong service rieng.
- Tai lieu README, SRS, Project Plan phai cap nhat theo chuc nang.

### NFR-04. Tin Cay

- Du lieu tai khoan duoc luu cuc bo va doc lai khi mo app.
- Thao tac them/sua trang thai phai cap nhat giao dien ngay.
- Analyze khong co loi truoc khi nop.

### NFR-05. Bao Mat O Muc Demo

- Mat khau duoc luu phuc vu demo cuc bo.
- Du lieu khong gui ra ngoai vi chua co backend.
- Gioi han bao mat that duoc ghi ro trong tai lieu huong phat trien.

## 5. Mo Hinh Du Lieu Chinh

| Thuc the | Mo ta |
| --- | --- |
| UserAccount | Tai khoan nguoi dung gom username, email, password |
| AccountLedger | Vung du lieu rieng cua tung tai khoan |
| TransactionEntry | Giao dich thu/chi gom loai, ten, danh muc, so tien, ngay giao dich |
| SavingsGoal | Muc tieu tiet kiem, so tien muc tieu, so tien da nap |
| ReminderEntry | Hoa don/loi nhac, ngay den han, trang thai da thanh toan |
| RecurringTransactionRule | Quy tac giao dich lap lai |
| BudgetInfo | Ngan sach theo danh muc |
| SmartNotification | Thong bao/canh bao trong app |

## 6. Luong Nghiep Vu Chinh

### 6.1 Luong Dang Ky

1. Nguoi dung bam "Tao tai khoan moi".
2. Nhap username, email, mat khau, xac nhan mat khau.
3. He thong kiem tra hop le.
4. He thong tao tai khoan va ledger rieng.
5. Nguoi dung quay lai dang nhap/vao app.

### 6.2 Luong Them Chi Phi

1. Nguoi dung bam nut them.
2. Chon loai chi phi.
3. Nhap ten, so tien, danh muc, ngay giao dich.
4. He thong luu giao dich vao ledger cua tai khoan hien tai.
5. Dashboard, thong ke, ngan sach va thong bao duoc cap nhat.

### 6.3 Luong Thanh Toan Hoa Don

1. He thong hien hoa don qua han/sap den han.
2. Nguoi dung bam xu ly/thanh toan.
3. He thong danh dau hoa don da thanh toan.
4. Hoa don khong con hien trong danh sach canh bao qua han.
5. App tao thong bao da xu ly hoa don.

## 7. Tieu Chi Kiem Thu Tong Hop

- App build thanh cong tren Android.
- Dang ky tai khoan moi va dang nhap lai duoc.
- Tai khoan moi khong thay du lieu tai khoan cu.
- Them thu/chi voi ngay thang cu van thong ke dung.
- Them danh muc moi khong bi loi.
- Tiet kiem co the nap/rut nhieu lan.
- Hoa don qua han co the xu ly xong.
- Tro ly chi tieu dua ra canh bao theo du lieu thuc.
- Thong bao trong app xuat hien khi co hanh dong them thu/chi.
- GitHub co day du source code va tai lieu can thiet.

## 8. Gioi Han Va Huong Phat Trien

### 8.1 Gioi Han

- Chua co server/backend.
- Chua dong bo cloud.
- Chua co xac thuc email/OTP that.
- Tro ly chi tieu hien tai la AI Rule, chua dung mo hinh AI online.

### 8.2 Huong Phat Trien

- Xay dung backend API va database.
- Dang nhap bang email/Google that.
- Dong bo nhieu thiet bi.
- Tich hop thong bao lich he thong sau hon.
- Them AI online de hoi dap tai chinh bang ngon ngu tu nhien.
- Them bao cao PDF/Excel co bieu do chi tiet hon.
