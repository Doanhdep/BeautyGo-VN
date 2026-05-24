# BeautyGo VN

Ứng dụng Flutter theo hướng **feature-first** cho nền tảng mạng xã hội/lifestyle về làm đẹp.

## 1) Tổng quan hiện trạng

- Trạng thái dự án: **chạy được** và **build Android debug thành công**.
- Màn hình khởi động hiện tại: **Login Screen**.
- Đã xử lý tương thích Android cho bộ Firebase/plugin (NDK + minSdk).

## 2) Công nghệ sử dụng

- Flutter (Material 3)
- Provider (state management)
- Go Router (định tuyến)
- Firebase:
  - firebase_core
  - firebase_auth
  - cloud_firestore
  - firebase_storage
  - firebase_messaging
- Dio (HTTP client)
- flutter_secure_storage (lưu trữ bảo mật)

Chi tiết dependencies: xem `pubspec.yaml`.

## 3) Điểm vào ứng dụng (App Entry)

Ứng dụng khởi chạy từ `lib/main.dart` với cấu hình:

- `MaterialApp`
- `debugShowCheckedModeBanner: false`
- `useMaterial3: true`
- `home: LoginScreen()`

Điều này đảm bảo khi chạy app sẽ lên thẳng màn hình đăng nhập.

## 4) Cấu trúc thư mục chính

```text
lib/
├── main.dart
├── firebase_options.dart
├── config/
│   └── firebase/
│       └── firebase_initializer.dart
├── core/
│   ├── constants/
│   ├── errors/
│   ├── network/
│   ├── services/
│   ├── storage/
│   ├── themes/
│   ├── utils/
│   └── widgets/
├── features/
│   ├── auth/
│   ├── booking/
│   ├── chat/
│   ├── explore/
│   ├── home_feed/
│   ├── navigation/
│   ├── notifications/
│   ├── profile/
│   └── upload/
├── pages/
│   └── Screens/
│       └── login_screen.dart
├── routes/
│   ├── app_router.dart
│   ├── guards/
│   └── route_names.dart
└── shared/
    └── providers/
```

## 5) Cấu hình Android quan trọng

Trong `android/app/build.gradle.kts` đã cập nhật:

- `ndkVersion = "27.0.12077973"`
- `minSdk = 23`

Mục đích:

- Tương thích với nhóm thư viện Firebase mới.
- Tránh lỗi merge manifest do `firebase_auth` yêu cầu minSdk >= 23.

## 6) Hướng dẫn cài đặt và chạy

### Yêu cầu môi trường

- Flutter SDK đã cài và có trong PATH
- Android SDK + Android Studio
- Thiết bị Android hoặc emulator

### Cài dependencies

```bash
flutter pub get
```

### Chạy ứng dụng

```bash
flutter run
```

## 7) Kiểm tra chất lượng mã

```bash
flutter analyze
```

Kết quả hiện tại: không có lỗi phân tích tĩnh.

## 8) Build APK debug

```bash
flutter build apk --debug
```

Output mặc định:

```text
build/app/outputs/flutter-apk/app-debug.apk
```

## 9) Firebase cấu hình

- File `lib/firebase_options.dart` đã tồn tại.
- Nếu cần cấu hình lại Firebase theo project mới, chạy:

```bash
flutterfire configure
```

## 10) Gợi ý phát triển tiếp theo

- Hoàn thiện flow đăng nhập (email/password, social login).
- Kết nối `auth_provider` với UI login.
- Chuẩn hóa `routes/app_router.dart` theo luồng auth guard.
- Bổ sung test cho các service/provider chính.
- Thiết lập flavor (dev/staging/prod) và CI build.

---

## Lệnh nhanh (copy/paste)

```bash
flutter clean
flutter pub get
flutter analyze
flutter build apk --debug
flutter run
```
