# 📱 Device Intel: Premium Information Dashboard

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Architecture: BLoC](https://img.shields.io/badge/Architecture-BLoC-blue.svg?style=for-the-badge)](https://pub.dev/packages/flutter_bloc)
[![Design: Glassmorphism](https://img.shields.io/badge/Design-Glassmorphism-purple.svg?style=for-the-badge)](#-design-vision)

Transform your mobile experience with **Device Intel**, a premium, visually stunning dashboard that provides deep, real-time insights into your hardware. Built with a focus on performance, accuracy, and high-end aesthetics.

---

## 🚀 Key Features

- **🛡️ Hero Health Ring**: A 3D-effect central indicator for overall system health.
- **🔋 Battery Lab**: Real-time liquid-wave animations visualizing charge level, health, and temperature.
- **💾 Storage Insights**: Detailed breakdown of storage categories with animated bar charts.
- **⚙️ Processor Pulse**: Real-time core activity visualization using audio-style waveforms.
- **📶 Network Shield**: Signal propagation animations for WiFi and Cellular connectivity.
- **🎯 Sensor Radar**: A futuristic radar-sweep interface displaying all available hardware sensors.
- **📍 Precision Location**: Real-time geographic data with pulsing location markers.

---

## 🏗️ Architecture & Technology

### State Management: BLoC
Utilizes the **BLoC (Business Logic Component)** pattern to ensure a highly scalable, testable, and maintainable codebase. Each hardware component (Battery, Sensors, etc.) operates within its own dedicated BLoC.

### Native Communication: Method Channels
Leverages **Platform Channels** and **Method Channels** for efficient, low-latency communication with native Android (Kotlin) and iOS (Swift) APIs, ensuring the most accurate data points directly from the OS.

### Clean Architecture
- **Data Layer**: Robust models and repositories handling native data acquisition.
- **Business Logic Layer**: BLoCs managing state transitions and stream processing.
- **Presentation Layer**: Premium UI components with custom shaders and animations.

---

## 🎨 Design Vision

**Device Intel** is not just an app; it's a visual experience.
- **Glassmorphism**: Semi-transparent surfaces with high-end blur effects.
- **Deep Space Aesthetics**: A curated dark-mode palette (#0A0E27 → #1A1F3A).
- **Iconic Animations**: Category-specific animations like liquid wave fills, holographic shimmers, and radar sweeps.
- **Responsive Layout**: Fluid design optimized for phones and tablets.

---

## 🛠️ Installation & Setup

### Prerequisites
- Flutter SDK (v3.10.4 or higher)
- Android Studio / Xcode for native builds

### Quick Start
1. **Clone the repository**
   ```bash
   git clone https://github.com/muhammednajeebay/device_info.git
   cd device_info
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

---

## 📦 Dependencies

- `flutter_bloc`: Advanced state management.
- `flutter_screenutil`: Responsive UI scaling.
- `fl_chart`: High-performance data visualization.
- `google_fonts`: Premium typography (Inter & Poppins).
- `permission_handler`: Granular hardware permission management.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

