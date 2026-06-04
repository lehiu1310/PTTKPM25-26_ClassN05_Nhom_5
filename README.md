# Monex - Quan Ly Tai Chinh Ca Nhan

Monex la ung dung mobile quan ly thu nhap, chi tieu, tiet kiem, hoa don va thong bao tai chinh ca nhan. Ung dung duoc xay dung bang Flutter va chay tren Android Studio/Android Emulator.

Repo nay duoc sap xep lai theo yeu cau hoc phan Phan tich va thiet ke phan mem: co thu muc tai lieu, thiet ke, source code, README va CHANGELOG.

## Thong Tin Du An

- Ten du an: Monex - Quan ly tai chinh ca nhan
- Hoc phan: Phan tich va thiet ke phan mem
- Nen tang: Android
- Framework: Flutter
- Ngon ngu: Dart
- Luu tru du lieu: SharedPreferences
- Repository GitHub: `lehiu1310/Quan-Ly-Tai-Chinh-Monex`

Ghi chu theo yeu cau giang vien:

- Chu so huu repository se tu add giang vien vao GitHub.
- Ten repository neu can doi theo mau cua lop/nhom: `PTTKPM25-26_ClassNx_NhomY`.

## Cau Truc Repository

```text
monex/
|-- Documents/              # Ke hoach, SRS, bao cao hang tuan, bao cao du an
|-- Design/                 # Tai lieu thiet ke, kien truc, du lieu, sketch
|-- SRC/                    # Ghi chu mapping source code theo yeu cau hoc phan
|-- android/                # Cau hinh Android cua Flutter project
|-- ios/                    # Cau hinh iOS cua Flutter project
|-- lib/                    # Source code Dart/Flutter chinh
|-- linux/                  # Generated Flutter desktop target
|-- macos/                  # Generated Flutter desktop target
|-- web/                    # Generated Flutter web target
|-- windows/                # Generated Flutter desktop target
|-- reports/                # Bao cao PDF da tao truoc do
|-- test/                   # Test logic va widget
|-- tools/                  # Script ho tro format, analyze, build
|-- CHANGELOG.md            # Lich su thay doi
|-- README.md               # Thong tin du an va huong dan chay
|-- pubspec.yaml            # Khai bao package Flutter
`-- pubspec.lock            # Khoa phien ban dependency
```

Flutter project hien dang nam o root repository de Android Studio co the mo va build truc tiep. Thu muc `SRC/README.md` giai thich mapping source code theo yeu cau hoc phan.

## Chuc Nang Chinh

- Dang ky, dang nhap va dang xuat tai khoan.
- Moi tai khoan co du lieu thu chi rieng.
- Them thu nhap, chi phi va danh muc phat sinh.
- Chon ngay giao dich de nhap du lieu cua thang truoc, nam truoc.
- Thong ke theo thang va theo nam, khong cong don sai giua cac thang.
- Quan ly tiet kiem theo kieu bo tien nhieu lan vao muc tieu.
- Tao hoa don, loi nhac va thong bao cuc bo.
- Tro ly chi tieu dua tren du lieu thuc cua tai khoan hien tai.
- Bieu do thu chi, xu huong va danh muc chi phi.
- Tim kiem, loc giao dich theo ten, danh muc, thoi gian.
- Xuat bao cao PDF va Excel.
- Ho tro onboarding, dark mode, skeleton loading va home widget.

## Cong Nghe Su Dung

- Flutter
- Dart
- ChangeNotifier
- SharedPreferences
- fl_chart
- flutter_local_notifications
- home_widget
- pdf + printing
- syncfusion_flutter_xlsio
- share_plus
- Android Studio

## Mo Project Bang Android Studio

Mo dung thu muc:

```text
D:\HOC_TAP\quan_ly_tai_chinh\monex
```

Khong mo thu muc cha `D:\HOC_TAP\quan_ly_tai_chinh` vi thu muc cha khong phai Flutter project.

## Cai Dependency

```bash
flutter pub get
```

Neu dung runtime da cau hinh san tren o D, cac script trong `tools/` se giup han che ghi cache vao o C.

## Chay Ung Dung

Chay tren Android Studio bang nut Run, hoac build debug bang Gradle:

```powershell
cd D:\HOC_TAP\quan_ly_tai_chinh\monex\android
.\gradlew.bat :app:assembleDebug -Ptarget-platform=android-x64 --no-daemon
```

File APK debug sau khi build:

```text
build/app/outputs/flutter-apk/app-debug.apk
```

## Tai Khoan Demo

```text
Username: minh
Email: minh@monex.vn
Password: 123456
```

Nguoi dung cung co the tao tai khoan moi trong man hinh dang ky.

## Tai Lieu Du An

- Ke hoach du an: `Documents/Project_Plan.md`
- SRS: `Documents/SRS.md`
- Bao cao hang tuan: `Documents/Weekly_Report.md`
- Bao cao du an: `Documents/Project_Report.md`
- Bao cao PDF: `Documents/Bao_cao_Monex.pdf`
- Thiet ke kien truc: `Design/Architecture.md`
- Thiet ke chuong trinh va du lieu: `Design/Program_Design.md`, `Design/Data_Design.md`

## Kiem Tra Code

```bash
flutter analyze
```

Hoac:

```bash
tools\analyze_d.bat
```

## Ghi Chu

- Du lieu hien duoc luu cuc bo bang SharedPreferences.
- Ung dung chua dung backend/cloud, phu hop pham vi demo hoc phan.
- Cac thu muc build/cache nhu `build`, `.dart_tool`, `.runtime` khong dua len GitHub.
