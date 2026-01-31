# 📱 Device Info: Premium Information Dashboard

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Architecture: BLoC](https://img.shields.io/badge/Architecture-BLoC-blue.svg?style=for-the-badge)](https://pub.dev/packages/flutter_bloc)
[![Design: Glassmorphism](https://img.shields.io/badge/Design-Glassmorphism-purple.svg?style=for-the-badge)](#-design-vision)

Transform your mobile experience with **Device Info**, a premium, visually stunning dashboard that provides deep, real-time insights into your hardware. Built with a focus on performance, accuracy, and high-end aesthetics.

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
- **Data Layer**: Robust models and repositories handling native data acquisition via custom platform channels.
- **Business Logic Layer**: BLoCs managing state transitions, stream processing, and performance optimizations.
- **Presentation Layer**: Premium UI components utilizing `CustomPaint` and advanced animation controllers.

---

## 🛠️ Technical Deep Dive

### 🔌 Platform Channels: The Native Bridge
Device Info bypasses high-level plugins to communicate directly with the underlying OS for maximum accuracy and minimal latency.
- **Method Channels**: Used for discrete, request-response data fetching such as device hardware specifications, OS versions, and initial storage metrics.
- **Event Channels**: Leveraged for continuous, real-time data streams. This includes live tracking of battery percentage changes, thermal states, and high-frequency sensor telemetry (Accelerometer, Gyroscope).

### 🎨 CustomPaint: Kinetic Visualizations
To achieve the "premium" visual fidelity without sacrificing performance, the dashboard utilizes the `CustomPaint` widget and `CustomPainter` classes.
- **Direct Canvas Drawing**: Visualizations like the **Radar Sweep**, **Liquid Battery Waves**, and **Signal Propagation** are drawn directly on the canvas. This avoids the overhead of complex widget trees.
- **Mathematical Rendering**: Uses trigonometric functions (Sine/Cosine) for wave oscillations and geometric calculations for radar positioning and holographic scanlines.
- **Glow & Shaders**: Implements `MaskFilter.blur` and `RadialGradient` shaders to create futuristic lighting effects that react to real-time data.

### 🎭 Animation Orchestration
Animations in Device Info are treated as a first-class citizen, strictly controlled for both aesthetics and battery efficiency.
- **AnimationController**: Every kinetic widget (e.g., `LiquidWaveIcon`, `SystemPulseFlow`) uses a dedicated `AnimationController` for precise pixel-level control over its state.
- **Tween Chaining**: Complex sequences, like the holographic flicker or the radar echo fade, are achieved by chaining multiple `Tween` objects.
- **Declarative Intro Sequences**: Powered by `flutter_animate`, the splash screen and detail entry transitions use a declarative syntax for choreographed fades, scales, and blurs.

### 🔋 Performance & Optimization
- **Reactive Throttling**: The BLoC layer automatically throttles incoming native events during heavy UI transitions to maintain a smooth 60/120 FPS.
- **Smart Rendering**: Components detect "Reduced Motion" and "Low Power" states via the `SettingsBloc`, dynamically switching between complex `CustomPaint` loops and optimized static representations.

---

## 🎨 Design Vision & Visual Identity

**Device Info** is built as a living energy system, where hardware metrics are transformed into immersive visual stories.

### 🔋 Battery: Liquid Energy System
- **Visual Identity**: Concept of a living energy container.
- **Primary Widget**: Vertical battery outline with a dynamic liquid fill and wavy surface.
- **Animations**: 
  - **Liquid Oscillations**: Oscillates slowly based on current percentage.
  - **Micro Bubbles**: Floating upward continuously.
  - **Charging**: Lightning pulse inside the liquid with intensifying glow.
  - **Low Battery**: Subtle red pulse emanating from the bottom.
- **Interaction**: Tap to expand into full-screen visualization; device tilt influences liquid physics.

### 📱 Device: Holographic Identity
- **Visual Identity**: Projected hologram silhouette.
- **Primary Widget**: Semi-transparent iridescent outline with floating particles.
- **Animations**: 
  - **Hologram Feel**: Slow Y-axis rotation and vertical scanline passes.
  - **Glitch Flicker**: Occasional subtle glitch effects for futuristic aesthetic.
- **Data Display**: Model, Manufacturer, Android/SDK versions, and ABIs shown as interactive pills.
- **Interaction**: Tap for rapid rotation; long press for visual exploded view concept.

### 💾 Storage: Data Mass Visualization
- **Visual Identity**: Storage represented as weight and distribution.
- **Primary Widget**: Large circular donut chart with clockwise segment drawing.
- **Segments**: Color-coded and icon-labeled categories (Apps, Media, System, Other).
- **Animations**: Used portions subtly pulse; background file icons drift slowly.
- **Interaction**: Tap segments to isolate; swipe up for detailed category breakdown.

### 🧠 System (RAM + CPU): Pulse & Flow
- **RAM - Memory Flow**: 
  - **Widget**: Horizontal flow bar with particle density representing usage.
  - **Animation**: Smooth particle stream that speeds up and changes color (Green → Red) based on load.
- **CPU - Core Waveform**: 
  - **Widget**: Independent vertical bars per core using audio-wave style motion.
  - **Animation**: Real-time load reflection through bar height and active core glows.
- **Interaction**: Tap to freeze waveform and view peak markers.

### 📶 Connectivity: Signal Propagation
- **Visual Identity**: Radio waves and data travel patterns.
- **Primary Widget**: Central signal icon with expanding concentric waves.
- **Animations**: Waves expand and fade with speed tied to signal strength; curved data packet paths.
- **Interaction**: Tap for a "ping" wave burst; long press for connection test animation.

### 🎯 Sensors: Radar Infoligence
- **Visual Identity**: Active radar scanning system.
- **Primary Widget**: Grid-based radar with a rotating sweep line.
- **Animations**: Sensors appear as dots (Cyan for Accelerometer, Purple for Gyro, etc.) as the sweep passes.
- **Interaction**: Tap dots for sensor details; pinch to zoom the radar grid.

### 📍 Location: Living Map Marker
- **Visual Identity**: Real-world dark-theme positioning.
- **Primary Widget**: Animated pin drop with expanding pulse rings.
- **Animations**: Pin bounce on update; accuracy circle "breathes" around the coordinates.
- **Interaction**: Tap for full map view; swipe for location history timeline.

---

## 🔄 Navigation & Transitions
- **Home → Detail**: Shared-element animations where cards expand into full-screen views with background color morphing.
- **Back Navigation**: Content collapses gracefully back into the source card with fade and scale-down effects.

---

## ⚙️ Accessibility & Performance
- **Reduced Motion Mode**: Replaces complex animations with simple fades and disables particle systems.
- **Battery Saver Mode**: Lowers animation FPS and pauses non-essential background loops.
- **Touch Targets**: Minimized to 48dp with clear haptic and visual feedback.

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

