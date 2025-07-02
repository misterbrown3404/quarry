# 🪨 Quarry App

The Quarry App is an end-to-end mobile solution designed to help quarry businesses efficiently manage their operations, track sales, and maintain customer relationships. Built with **Flutter** and **Firebase**, the app provides a modern, intuitive interface with real-time data capabilities.

---

## 🚀 Features

✅ **Customer Management**
- Create, edit, and delete customer profiles
- View customer transaction history

✅ **Sales Tracking**
- Record and manage sales transactions
- Generate and view sales reports
- Filter transactions by date and customer

✅ **Real-Time Updates**
- Live synchronization with Firebase Firestore
- Instant data reflection across devices

✅ **User Authentication**
- Secure sign-in and sign-out
- Role-based access (e.g., Admin, Staff)

✅ **Reporting**
- View and export daily, weekly, or monthly sales data

✅ **Responsive UI**
- Modern, clean interface built with Flutter
- Works across Android devices

---

## 🛠️ Tech Stack

- **Flutter:** Cross-platform mobile app framework
- **Firebase Auth:** Secure user authentication
- **Cloud Firestore:** Real-time NoSQL database
- **Firebase Storage:** Handling image and file uploads
- **GetX:** State management and navigation

---

## 📂 Project Structure

```plaintext
lib/
 ├── common/           # Reusable widgets and styles
 ├── features/
 │   ├── auth/         # Authentication screens & controllers
 │   ├── customer/     # Customer management screens & logic
 │   ├── sales/        # Sales recording and reports
 │   └── transaction/  # Transaction history and filters
 ├── models/           # Data models
 ├── services/         # Firebase services and helpers
 └── main.dart         # App entry point
