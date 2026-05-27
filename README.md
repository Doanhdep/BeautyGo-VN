# BeautyGo VN - Tổng quan toàn bộ dự án

Tài liệu này cập nhật trạng thái **toàn bộ workspace** hiện tại, gồm:
- Ứng dụng Flutter chính: `beautygovn/`
- Ứng dụng Web (React + Vite): `view/`
- Prototype Flutter trong web module: `view/beauty_go_flutter/`

---

## 1. Kiến trúc tổng thể

Workspace đang theo hướng **đa ứng dụng (multi-app)**:

1. **Mobile/Desktop app chính** (`beautygovn`)  
   - Công nghệ: Flutter
   - Mục tiêu: app BeautyGo VN chính thức (auth, feed, chat, profile, upload...)

2. **Web app AI/Frontend** (`view`)  
   - Công nghệ: React + TypeScript + Vite
   - Có tích hợp hệ sinh thái Gemini API (qua biến môi trường)

3. **Flutter prototype phụ** (`view/beauty_go_flutter`)  
   - Công nghệ: Flutter + BLoC
   - Dùng như bản demo/prototype cho một số luồng UI/UX

---

## 2. Cấu trúc thư mục chính

```text
BeautyGo VN/
├─ beautygovn/                    # Flutter app chính
│  ├─ lib/
│  │  ├─ main.dart
│  │  ├─ config/firebase/
│  │  ├─ core/
│  │  │  ├─ constants/
│  │  │  ├─ errors/
│  │  │  ├─ network/
│  │  │  ├─ services/
│  │  │  ├─ storage/
│  │  │  ├─ themes/
│  │  │  ├─ utils/
│  │  │  └─ widgets/
│  │  ├─ features/
│  │  │  ├─ auth/
│  │  │  ├─ booking/
│  │  │  ├─ chat/
│  │  │  ├─ home_feed/
│  │  │  ├─ profile/
│  │  │  └─ upload/
│  │  ├─ routes/
│  │  └─ shared/providers/
│  ├─ android/ ios/ web/ windows/ macos/ linux/
│  ├─ pubspec.yaml
│  └─ supabase_init.sql
│
└─ view/                          # Web app React + prototype Flutter
   ├─ src/                        # React source (App.tsx, main.tsx, styles)
   ├─ package.json
   ├─ .env.example
   ├─ README.md
   └─ beauty_go_flutter/          # Flutter prototype
      ├─ lib/
      │  ├─ blocs/
      │  ├─ models/
      │  └─ pages/
      └─ pubspec.yaml
```

---

## 3. Chi tiết module `beautygovn` (Flutter app chính)

### 3.1 Công nghệ và dependencies chính
Theo `beautygovn/pubspec.yaml`:
- Flutter SDK (`>=3.7.x`)
- `provider` (state management)
- `go_router` (routing)
- Firebase stack:
  - `firebase_core`
  - `firebase_auth`
  - `cloud_firestore`
  - `firebase_storage`
  - `firebase_messaging`
- `supabase_flutter`
- `dio`
- `flutter_secure_storage`

### 3.2 App entry hiện tại
`lib/main.dart` đang:
- `WidgetsFlutterBinding.ensureInitialized()`
- `Supabase.initialize(...)`
- chạy `MaterialApp` với `home: _AuthFlowHost()`
- flow auth/splash đang điều hướng nội bộ qua state (`SplashActive` + `LoginScreen`)

### 3.3 Các feature đang có mặt trong source
Trong `lib/features/` đã có các nhóm chính:
- `auth`
- `booking`
- `chat`
- `home_feed`
- `profile`
- `upload`

Ngoài ra có:
- `core/` cho hạ tầng dùng chung (network, service, theme, storage...)
- `routes/` (đã có file router/guard, nhưng hiện một số file còn trống)

### 3.4 Hạ tầng đa nền tảng
Dự án Flutter chính đã chứa đủ target:
- Android
- iOS
- Web
- Windows
- macOS
- Linux

---

## 4. Chi tiết module `view` (React + Vite)

Theo `view/package.json`:
- React 19 + ReactDOM 19
- TypeScript
- Vite
- `@google/genai`
- `lucide-react`, `motion`
- có `express` + `dotenv`

Scripts chính:
- `npm run dev`
- `npm run build`
- `npm run preview`
- `npm run lint` (`tsc --noEmit`)

Lưu ý: có `.env.example`, cần tạo file môi trường thực tế trước khi chạy tính năng phụ thuộc API key.

---

## 5. Chi tiết module `view/beauty_go_flutter` (Flutter prototype)

Theo `view/beauty_go_flutter/pubspec.yaml`:
- Flutter
- `flutter_bloc`, `bloc`, `equatable`
- `google_fonts`
- `cached_network_image`
- `intl`

Cấu trúc code cho thấy dự án theo hướng:
- `blocs/` cho state management
- `models/`
- `pages/`

Đây là module prototype độc lập với app Flutter chính trong `beautygovn`.

---

## 6. Cách chạy từng module

## 6.1 Chạy Flutter app chính (`beautygovn`)
```bash
cd beautygovn
flutter pub get
flutter run
```

Kiểm tra chất lượng mã:
```bash
cd beautygovn
flutter analyze
```

Build APK debug:
```bash
cd beautygovn
flutter build apk --debug
```

## 6.2 Chạy Web app React (`view`)
```bash
cd view
npm install
npm run dev
```

Build production:
```bash
cd view
npm run build
```

## 6.3 Chạy Flutter prototype (`view/beauty_go_flutter`)
```bash
cd view/beauty_go_flutter
flutter pub get
flutter run
```

---

## 7. Biến môi trường và bảo mật

- Module web dùng file mẫu: `view/.env.example`
- Không commit secrets thực tế vào Git.
- Với Flutter app chính, nên chuyển các thông tin cấu hình nhạy cảm sang cơ chế cấu hình môi trường/build-time an toàn hơn khi chuẩn bị release.

---

## 8. Trạng thái hiện tại và ghi chú kỹ thuật

1. **App Flutter chính đang có luồng splash/login nội bộ** trong `main.dart`.
2. **Router/provider trung tâm** đã có cấu trúc file nhưng một số file có thể chưa hoàn thiện nội dung (ví dụ file rỗng).
3. Workspace đang có **2 hướng Flutter song song** (`beautygovn` và `view/beauty_go_flutter`) nên cần thống nhất roadmap để tránh trùng lặp tính năng.
4. Thư mục `build/` bên trong `view/beauty_go_flutter` đã xuất hiện artifact build cục bộ.

---

## 9. Đề xuất chuẩn hóa tiếp theo

1. Chọn **1 nguồn chính cho mobile Flutter** (khuyến nghị `beautygovn`) và quy định rõ vai trò của `view/beauty_go_flutter` là prototype.
2. Hoàn thiện `routes/` + `shared/providers/` trong `beautygovn` để đồng bộ kiến trúc feature-first.
3. Đồng bộ tài liệu README giữa các module, thêm sơ đồ luồng đăng nhập và phân quyền.
4. Thiết lập CI cơ bản:
   - Flutter analyze/test cho `beautygovn`
   - Type-check/build cho `view`
5. Tách secret và cấu hình môi trường theo từng stage (dev/staging/prod).

---

## 10. Lệnh nhanh

### Flutter app chính
```bash
cd beautygovn
flutter clean
flutter pub get
flutter analyze
flutter run
```

### Web app
```bash
cd view
npm install
npm run dev
```

### Flutter prototype
```bash
cd view/beauty_go_flutter
flutter pub get
flutter run
```

---

## 11. Tóm tắt

Workspace BeautyGo VN hiện là mô hình đa module gồm:
- 01 Flutter app chính production-oriented (`beautygovn`)
- 01 web app React (`view`)
- 01 Flutter prototype (`view/beauty_go_flutter`)

README này đã được cập nhật để phản ánh đúng hiện trạng cấu trúc, stack công nghệ, cách chạy và các hướng chuẩn hóa kỹ thuật tiếp theo.
