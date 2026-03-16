# Maadati Admin Dashboard

لوحة تحكم احترافية لإدارة نظام توصيل الطعام **Maadati**.
تُمكّن الأدمن من إدارة السائقين والطلبات والمطاعم ومتابعة الأداء عبر تقارير يومية وشهرية.

---

## 📌 Project Overview

**Maadati Admin Dashboard** هو نظام إدارة مخصص لمنصة توصيل الطعام Maadati.
يوفر أدوات متقدمة لمتابعة السائقين والطلبات وإدارة العمليات اليومية.

### ✨ Features

* (Customer Management)إدارة العملاء
* إدارة السائقين (Drivers Management)
* متابعة الطلبات (Orders Management )
* (Advertesmsnt Management)إدارة الاعلانات
* (PromoCode Management)إدارة أكواد الخصم 
* (Fees Management)إدارة المصاريف
* (Restaurant Management)إدارة المطاعم
* (Reports Management )إدارة التقاير
* تقارير يومية وشهرية للسائقين
* مراقبة حالة السائقين
* عرض الطلبات حسب الحالة
* لوحة تحكم إحصائية (Dashboard Analytics)

---

## 🧰 Tech Stack

| Layer            | Technology   |
| ---------------- |--------------|
| Frontend         | Flutter      |
| State Management | cubit        |
| Architecture     | MVVM         |
| Backend          | Laravel API  |
| Version Control  | Git + GitHub |

---

## 🧱 Architecture Pattern (MVVM)

المشروع يعتمد على **MVVM Architecture**.

### Model

يمثل البيانات القادمة من الـ API.

أمثلة:

```
Driver
Order
Report
```

---

### View

هي واجهات المستخدم.

أمثلة:

```
DashboardPage
DriversPage
OrdersPage
ReportsPage
```

---





### إنشاء Feature Branch

```
git checkout develop
git checkout -b feature/driver-report
```

---

### رفع التعديلات

```
git add .
git commit -m "Add driver monthly report"
git push origin feature/driver-report
```

بعدها يتم إنشاء **Pull Request** ودمجها مع `develop`.



## 🎯 Icons

الأيقونات المستخدمة:

* Flutter Material Icons


---

## 🧪 Dummy Data

المشروع يحتوي على بيانات تجريبية لتجربة الواجهات قبل ربط الـ API.

الموقع:

```
lib/core/utils/dummy_data.dart
```

البيانات المتوفرة:

* Drivers
* Orders
* Reports
* Cities



---

## 🔌 API Integration

المشروع يعتمد على **Laravel API**.

### Drivers

```
GET /api/admin/driver
```

---

### Current Driver Turn

```
GET /api/admin/driver/getCurrentDriverInTurn/{city}
```

---

### Pending Orders

```
GET /api/admin/driver/today-pendingorders/{driver_id}
```

---

### On Delivery Orders

```
GET /api/admin/driver/today-ondeleveryorders/{driver_id}
```

---

### Daily Driver Report

```
GET /api/admin/driver/getDriverDailyReport/{driver_id}/{year}/{month}/{day}
```

---

### Monthly Driver Report

```
GET /api/admin/driver/getDriverMonthlyReport/{driver_id}/{year}/{month}
```

---

## 📏 Coding Guidelines

للحفاظ على جودة الكود يجب الالتزام بما يلي:

* استخدام **MVVM Architecture**
* عدم كتابة API calls داخل الواجهة
* استخدام Widgets قابلة لإعادة الاستخدام
* تسمية الملفات باستخدام **snake_case**
* تسمية الكلاسات باستخدام **PascalCase**

---



### 2️⃣ Install Dependencies

```
flutter pub get
```

---

### 3️⃣ Run Project

```
## How to run:
flutter pub get
flutter run

```

---

## 🚀 Future Improvements

* إضافة Charts للتقارير
* نظام صلاحيات المستخدمين
* إشعارات لحالة الطلبات
* تحسين الأداء

---

## 👨‍💻 Contributors

Maadati Development Team

