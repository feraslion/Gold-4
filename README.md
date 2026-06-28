# Gold-4 Professional Accounting Suite 💰

تطبيق محاسبي متكامل يدعم الليرة السورية والدولار الأمريكي، مبني باستخدام Flutter و NestJS.

## 🚀 التقنيات المستخدمة

- **Frontend:** Flutter (Android, Windows, iOS, Web)
- **Backend:** NestJS, Prisma ORM, PostgreSQL
- **DevOps:** GitHub Actions, Docker, Melos (Monorepo)

## 📁 هيكلية المشروع

- `mobile/`: تطبيق الجوال وسطح المكتب (Flutter).
- `backend/`: الخادم والخدمات السحابية (NestJS).
- `packages/`: الحزم المشتركة بين المنصات.
- `.github/workflows/`: أتمتة البناء والرفع (CI/CD).

## 🛠️ كيفية التشغيل

### المتطلبات
- Flutter SDK (>= 3.27.4)
- Node.js (>= 22)
- Docker & Docker Compose

### الخطوات
1. قم بتثبيت التبعيات: `melos run get`
2. تشغيل قاعدة البيانات: `docker-compose up -d`
3. تشغيل الـ Backend: `cd backend && npm run start:dev`
4. تشغيل الـ Mobile: `cd mobile && flutter run`

## 📦 البناء التلقائي (CI/CD)

يستخدم المشروع GitHub Actions لبناء النسخ التالية تلقائياً عند إضافة Tag جديد:
- **Android:** APK (split by ABI) & AAB
- **Windows:** EXE (Zipped)

### إعداد التوقيع (Android Signing)
لتفعيل توقيع التطبيق، أضف الـ Secrets التالية في GitHub:
- `KEYSTORE_BASE64`: ملف الـ jks مشفر بـ base64.
- `KEY_PASSWORD`: كلمة مرور المفتاح.
- `STORE_PASSWORD`: كلمة مرور المخزن.

## 📄 الترخيص
هذا المشروع مرخص تحت رخصة MIT.
