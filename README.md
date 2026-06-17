# Monex - Quan Ly Tai Chinh Ca Nhan

Repository bai tap lon hoc phan Phan tich va thiet ke phan mem.

## Cau Truc Theo Yeu Cau

```text
Quan-Ly-Tai-Chinh-Monex/
|-- Documents/      # Ke hoach, SRS, bao cao hang tuan, bao cao du an
|-- Design/         # Thiet ke kien truc, chuong trinh, du lieu, sketch
|-- android/        # Cau hinh Android
|-- lib/            # Source Dart/Flutter
|-- test/           # Kiem thu
|-- CHANGELOG.md    # Lich su thay doi
`-- README.md       # Thong tin du an
```

## Thong Tin Du An

- Ten du an: Monex - Quan ly tai chinh ca nhan
- Nen tang: Android
- Framework: Flutter
- Ngon ngu: Dart
- Luu tru du lieu: SharedPreferences
- IDE: Android Studio

## Chuc Nang Chinh

- Dang ky, dang nhap, dang xuat tai khoan.
- Tach du lieu thu chi theo tung tai khoan.
- Them thu nhap, chi phi, danh muc va ngay giao dich.
- Nhap giao dich cua thang truoc/nam truoc.
- Thong ke theo thang va nam, khong cong don sai giua cac thang.
- Quan ly tiet kiem theo muc tieu, nap/rut tien nhieu lan.
- Tao hoa don, loi nhac va thong bao cuc bo.
- Tro ly chi tieu dua tren du lieu thuc va AI Rule.
- Goi y ngan sach theo lich su thu chi.
- Xuat bao cao PDF/Excel o muc demo.

## Source Code

Source Flutter nam tai thu muc goc repository:

```text
D:\HOC_TAP\quan_ly_tai_chinh\monex
```

Mo project bang Android Studio tai thu muc:

```text
D:\HOC_TAP\quan_ly_tai_chinh\monex
```

Day la thu muc app Flutter truc tiep, co `pubspec.yaml`, `lib/` va `android/`.

## Chay App

Trong Android Studio:

1. File -> Open.
2. Chon `D:\HOC_TAP\quan_ly_tai_chinh\monex`.
3. Chon Android Emulator.
4. Bam Run.

Hoac build debug bang Gradle:

```powershell
cd D:\HOC_TAP\quan_ly_tai_chinh\monex\android
.\gradlew.bat :app:assembleDebug -Ptarget-platform=android-x64 --no-daemon
```

APK debug sau khi build:

```text
build/app/outputs/flutter-apk/app-debug.apk
```

## Tai Khoan Demo

```text
Username: minh
Email: minh@monex.vn
Password: 123456
```

## Tai Lieu

- Ke hoach du an: `Documents/Project_Plan.md`
- SRS: `Documents/SRS.md`
- Bao cao hang tuan: `Documents/Weekly_Report.md`
- Bao cao du an: `Documents/Project_Report.md`
- Bao cao hoc phan: `Documents/Baocao_Monex.docx`
- Thiet ke kien truc: `Design/Architecture.md`
- Thiet ke chuong trinh: `Design/Program_Design.md`
- Thiet ke du lieu: `Design/Data_Design.md`

## Ghi Chu Git

- Cac thu muc build/cache nhu `.runtime`, `.dart_tool`, `build` khong dua len GitHub.
- File/thu muc khong phuc vu yeu cau hoc phan da duoc loai khoi Git de repository gon hon.
- Giang vien se duoc chu repository add vao GitHub theo yeu cau rieng.
