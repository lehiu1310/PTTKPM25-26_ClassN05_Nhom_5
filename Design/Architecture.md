# Architecture Design

## 1. Kien Truc Tong Quan

Monex su dung kien truc Flutter app cuc bo:

```text
UI Layer -> AppState -> Local Storage/Services
```

## 2. Thanh Phan Chinh

- UI Layer: cac man hinh trong `lib/screens`.
- State Layer: `MonexAppState` trong `lib/data/app_state.dart`.
- Service Layer: notification, report, insight, home widget.
- Storage: SharedPreferences.

## 3. Luong Du Lieu

1. Nguoi dung thao tac tren UI.
2. UI goi ham trong `MonexAppState`.
3. AppState cap nhat ledger cua tai khoan hien tai.
4. AppState luu JSON vao SharedPreferences.
5. UI lang nghe ChangeNotifier va tu cap nhat.

## 4. Uu Diem

- Don gian, phu hop demo hoc phan.
- Khong can backend.
- De chay tren Android Studio.
- Du lieu tung tai khoan duoc tach bang ledger rieng.

## 5. Han Che

- Chua co sync cloud.
- Chua co database quan he.
- Chua co xac thuc that qua server.

