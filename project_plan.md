# Flutter Device Information App - BLoC + Platform Channels

## Project Overview

A comprehensive Flutter application that retrieves and displays ALL available device information using **Method Channels** and **Platform Channels** for native communication, with **BLoC pattern** for state management.

---

## 1. Project Architecture

### 1.1 Architecture Pattern
- **State Management:** BLoC (Business Logic Component)
- **Native Communication:** Method Channels & Platform Channels
- **Platform:** Android & iOS

### 1.2 Project Structure

```
lib/
├── main.dart
├── app.dart
│
├── blocs/
│   ├── battery/
│   │   ├── battery_bloc.dart
│   │   ├── battery_event.dart
│   │   └── battery_state.dart
│   ├── device/
│   │   ├── device_bloc.dart
│   │   ├── device_event.dart
│   │   └── device_state.dart
│   ├── connectivity/
│   │   ├── connectivity_bloc.dart
│   │   ├── connectivity_event.dart
│   │   └── connectivity_state.dart
│   ├── storage/
│   │   ├── storage_bloc.dart
│   │   ├── storage_event.dart
│   │   └── storage_state.dart
│   ├── sensors/
│   │   ├── sensors_bloc.dart
│   │   ├── sensors_event.dart
│   │   └── sensors_state.dart
│   ├── location/
│   │   ├── location_bloc.dart
│   │   ├── location_event.dart
│   │   └── location_state.dart
│   └── system/
│       ├── system_bloc.dart
│       ├── system_event.dart
│       └── system_state.dart
│
├── data/
│   ├── models/
│   │   ├── battery_info.dart
│   │   ├── device_info.dart
│   │   ├── connectivity_info.dart
│   │   ├── storage_info.dart
│   │   ├── sensor_info.dart
│   │   ├── location_info.dart
│   │   └── system_info.dart
│   │
│   └── repositories/
│       ├── battery_repository.dart
│       ├── device_repository.dart
│       ├── connectivity_repository.dart
│       ├── storage_repository.dart
│       ├── sensor_repository.dart
│       ├── location_repository.dart
│       └── system_repository.dart
│
├── services/
│   └── platform_channels/
│       ├── battery_channel.dart
│       ├── device_channel.dart
│       ├── connectivity_channel.dart
│       ├── storage_channel.dart
│       ├── sensor_channel.dart
│       ├── location_channel.dart
│       └── system_channel.dart
│
├── presentation/
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── battery_detail_screen.dart
│   │   ├── device_detail_screen.dart
│   │   ├── connectivity_detail_screen.dart
│   │   ├── storage_detail_screen.dart
│   │   ├── sensors_detail_screen.dart
│   │   ├── location_detail_screen.dart
│   │   └── system_detail_screen.dart
│   │
│   └── widgets/
│       ├── info_card.dart
│       ├── data_tile.dart
│       ├── battery_indicator.dart
│       ├── storage_chart.dart
│       ├── connectivity_status.dart
│       └── sensor_graph.dart
│
└── utils/
    ├── constants.dart
    └── helpers.dart
```

### 1.3 Native Code Structure

```
android/
└── app/
    └── src/
        └── main/
            ├── AndroidManifest.xml
            └── kotlin/com/example/device_info_app/
                ├── MainActivity.kt
                └── channels/
                    ├── BatteryChannel.kt
                    ├── DeviceChannel.kt
                    ├── ConnectivityChannel.kt
                    ├── StorageChannel.kt
                    ├── SensorChannel.kt
                    ├── LocationChannel.kt
                    └── SystemChannel.kt

ios/
└── Runner/
    ├── AppDelegate.swift
    ├── Info.plist
    └── Channels/
        ├── BatteryChannel.swift
        ├── DeviceChannel.swift
        ├── ConnectivityChannel.swift
        ├── StorageChannel.swift
        ├── SensorChannel.swift
        ├── LocationChannel.swift
        └── SystemChannel.swift
```

---

## 2. Dependencies Setup

### 2.1 pubspec.yaml

```yaml
name: device_info_app
description: Comprehensive device information app

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_bloc: ^8.1.3
  bloc: ^8.1.2
  equatable: ^2.0.5
  
  # UI
  cupertino_icons: ^1.0.6
  google_fonts: ^6.1.0
  flutter_screenutil: ^5.9.0
  fl_chart: ^0.66.0
  
  # Utils
  intl: ^0.19.0
  permission_handler: ^11.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  bloc_test: ^9.1.5
  mocktail: ^1.0.0
```

---

## 3. All Retrievable Native Data Points

### 3.1 Battery Information

**Android:**
- Battery level (percentage)
- Battery status (charging, discharging, not charging, full, unknown)
- Plugged status (AC, USB, Wireless, Not plugged)
- Battery health (good, overheat, dead, over voltage, unspecified failure, cold)
- Battery technology (e.g., Li-ion)
- Battery voltage (millivolts)
- Battery temperature (°C)
- Battery capacity (mAh)
- Charging time remaining
- Battery present status
- Battery scale

**iOS:**
- Battery level
- Battery state (charging, full, unplugged, unknown)
- Low power mode status

### 3.2 Device Information

**Android:**
- Device manufacturer
- Device model
- Device brand
- Device name
- Product name
- Hardware name
- Device ID
- Android ID
- Board name
- Bootloader version
- Display metrics (density, DPI, width, height)
- Fingerprint
- Host
- Build ID
- Tags
- Type
- User
- Base OS
- Security patch level
- SDK version
- Incremental version
- Codename
- Release version
- Preview SDK version
- Supported ABIs (32-bit, 64-bit)
- Serial number (with permission)
- IMEI (with permission)
- Phone number (with permission)

**iOS:**
- Device name
- Device model
- System name
- System version
- Device identifier
- Local identifier
- Machine name
- Physical memory
- User interface idiom

### 3.3 Connectivity Information

**Android:**
- Network type (WiFi, Cellular, Ethernet, Bluetooth, VPN, None)
- WiFi information:
  - SSID
  - BSSID
  - IP address (IPv4, IPv6)
  - MAC address
  - Link speed (Mbps)
  - Signal strength (RSSI)
  - Frequency (MHz)
  - Network ID
  - Hidden SSID status
  - Gateway IP
  - DNS servers
  - Subnet mask
- Mobile network:
  - Network operator name
  - Network operator code (MCC-MNC)
  - Network type (2G, 3G, 4G, 5G)
  - SIM state
  - SIM operator name
  - SIM serial number
  - Phone type
  - Data activity
  - Data state
  - Roaming status
- Bluetooth status
- Airplane mode status
- Mobile data enabled
- NFC enabled/available

**iOS:**
- Network type
- WiFi SSID
- BSSID
- IP address
- Cellular carrier name
- Cellular technology
- Allows VoIP

### 3.4 Storage Information

**Android:**
- Internal storage:
  - Total space
  - Free space
  - Available space
  - Used space
- External storage (SD card):
  - Total space
  - Free space
  - Available space
  - Used space
  - Mounted status
  - Removable status
  - Emulated status
- Cache directory size
- Data directory size
- Files directory size
- Download directory size

**iOS:**
- Total disk space
- Free disk space
- Used disk space

### 3.5 Sensor Information

**Android:**
- Accelerometer (x, y, z)
- Gyroscope (x, y, z)
- Magnetometer (x, y, z)
- Proximity sensor
- Light sensor
- Pressure sensor
- Humidity sensor
- Temperature sensor
- Gravity sensor
- Linear acceleration
- Rotation vector
- Step counter
- Step detector
- Heart rate sensor (if available)
- Available sensors list with details:
  - Sensor name
  - Sensor type
  - Vendor
  - Version
  - Power consumption
  - Maximum range
  - Resolution

**iOS:**
- Accelerometer
- Gyroscope
- Magnetometer
- Motion activity

### 3.6 Location Information

**Android:**
- GPS coordinates (latitude, longitude)
- Altitude
- Accuracy
- Speed
- Bearing
- Provider (GPS, Network, Passive)
- Time of fix
- Location enabled status
- Mock location status

**iOS:**
- GPS coordinates
- Altitude
- Horizontal accuracy
- Vertical accuracy
- Speed
- Course
- Floor level
- Location authorization status

### 3.7 System Information

**Android:**
- CPU information:
  - Number of cores
  - CPU architecture
  - CPU frequency
  - Processor name
  - CPU usage (per core)
- Memory information:
  - Total RAM
  - Available RAM
  - Free RAM
  - Threshold
  - Low memory status
- Screen information:
  - Screen resolution
  - Screen density
  - Screen size (inches)
  - Refresh rate
  - Orientation
  - Brightness level
- System uptime
- Boot time
- Kernel version
- Root access status
- Developer options enabled
- USB debugging enabled
- Running processes count
- Running apps list

**iOS:**
- Processor count
- Active processor count
- Total memory
- Used memory
- Screen resolution
- Screen scale
- Screen brightness
- System uptime

### 3.8 Audio Information

**Android:**
- Volume levels (ring, media, alarm, notification, system, voice call)
- Audio mode (normal, ringtone, in call, in communication)
- Microphone available
- Speaker on status
- Wired headset connected
- Bluetooth audio connected
- Music active status

**iOS:**
- Current route (speaker, headphones, bluetooth)
- Volume level
- Input available

### 3.9 Camera Information

**Android:**
- Number of cameras
- Camera IDs
- Camera characteristics (for each):
  - Facing direction (front/back)
  - Flash available
  - Focal lengths
  - Sensor size
  - Supported resolutions
  - Supported FPS ranges

**iOS:**
- Available cameras count
- Camera positions
- Flash available

### 3.10 Display Information

**Android:**
- Display ID
- Display name
- Display state
- Display flags
- Size
- Refresh rate
- HDR capabilities
- Wide color gamut support

**iOS:**
- Main screen bounds
- Scale
- Brightness
- Native scale

### 3.11 Telephony Information (Android)

- SIM card count
- Active subscription info
- Phone number
- Voice mail number
- Device software version
- Group ID level 1
- ICC ID
- Line 1 number
- Network country ISO
- SIM country ISO

### 3.12 Additional Information

**Both Platforms:**
- Installed apps list (with permission)
- Running apps/services
- Time zone
- Locale
- Language
- Country
- Is emulator/simulator
- Screen on/off status
- Battery saver mode
- Do Not Disturb status

---

## 4. Platform Channel Implementation

### 4.1 Channel Names Constants

```dart
// lib/utils/constants.dart

class ChannelNames {
  static const String battery = 'com.example.device_info/battery';
  static const String device = 'com.example.device_info/device';
  static const String connectivity = 'com.example.device_info/connectivity';
  static const String storage = 'com.example.device_info/storage';
  static const String sensors = 'com.example.device_info/sensors';
  static const String location = 'com.example.device_info/location';
  static const String system = 'com.example.device_info/system';
  static const String audio = 'com.example.device_info/audio';
  static const String camera = 'com.example.device_info/camera';
  static const String telephony = 'com.example.device_info/telephony';
}

class MethodNames {
  // Battery
  static const String getBatteryLevel = 'getBatteryLevel';
  static const String getBatteryInfo = 'getBatteryInfo';
  
  // Device
  static const String getDeviceInfo = 'getDeviceInfo';
  static const String getDeviceId = 'getDeviceId';
  
  // Connectivity
  static const String getConnectivityInfo = 'getConnectivityInfo';
  static const String getWifiInfo = 'getWifiInfo';
  static const String getCellularInfo = 'getCellularInfo';
  
  // Storage
  static const String getStorageInfo = 'getStorageInfo';
  static const String getExternalStorageInfo = 'getExternalStorageInfo';
  
  // Sensors
  static const String getAvailableSensors = 'getAvailableSensors';
  static const String getSensorData = 'getSensorData';
  
  // Location
  static const String getCurrentLocation = 'getCurrentLocation';
  static const String getLocationInfo = 'getLocationInfo';
  
  // System
  static const String getSystemInfo = 'getSystemInfo';
  static const String getCpuInfo = 'getCpuInfo';
  static const String getMemoryInfo = 'getMemoryInfo';
  
  // Audio
  static const String getAudioInfo = 'getAudioInfo';
  
  // Camera
  static const String getCameraInfo = 'getCameraInfo';
  
  // Telephony
  static const String getTelephonyInfo = 'getTelephonyInfo';
}
```

### 4.2 Flutter Platform Channel Service Example

```dart
// lib/services/platform_channels/battery_channel.dart

import 'package:flutter/services.dart';
import '../../utils/constants.dart';

class BatteryChannel {
  static const MethodChannel _channel = MethodChannel(ChannelNames.battery);
  static const EventChannel _eventChannel = EventChannel('${ChannelNames.battery}/stream');

  // Get battery info once
  Future<Map<String, dynamic>> getBatteryInfo() async {
    try {
      final Map<dynamic, dynamic> result = 
          await _channel.invokeMethod(MethodNames.getBatteryInfo);
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      throw Exception('Failed to get battery info: ${e.message}');
    }
  }

  // Stream battery updates
  Stream<Map<String, dynamic>> get batteryStream {
    return _eventChannel.receiveBroadcastStream().map((event) {
      return Map<String, dynamic>.from(event as Map);
    });
  }
}
```

```dart
// lib/services/platform_channels/device_channel.dart

import 'package:flutter/services.dart';
import '../../utils/constants.dart';

class DeviceChannel {
  static const MethodChannel _channel = MethodChannel(ChannelNames.device);

  Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      final Map<dynamic, dynamic> result = 
          await _channel.invokeMethod(MethodNames.getDeviceInfo);
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      throw Exception('Failed to get device info: ${e.message}');
    }
  }
}
```

```dart
// lib/services/platform_channels/connectivity_channel.dart

import 'package:flutter/services.dart';
import '../../utils/constants.dart';

class ConnectivityChannel {
  static const MethodChannel _channel = MethodChannel(ChannelNames.connectivity);
  static const EventChannel _eventChannel = EventChannel('${ChannelNames.connectivity}/stream');

  Future<Map<String, dynamic>> getConnectivityInfo() async {
    try {
      final Map<dynamic, dynamic> result = 
          await _channel.invokeMethod(MethodNames.getConnectivityInfo);
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      throw Exception('Failed to get connectivity info: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> getWifiInfo() async {
    try {
      final Map<dynamic, dynamic> result = 
          await _channel.invokeMethod(MethodNames.getWifiInfo);
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      throw Exception('Failed to get WiFi info: ${e.message}');
    }
  }

  Stream<Map<String, dynamic>> get connectivityStream {
    return _eventChannel.receiveBroadcastStream().map((event) {
      return Map<String, dynamic>.from(event as Map);
    });
  }
}
```

```dart
// lib/services/platform_channels/storage_channel.dart

import 'package:flutter/services.dart';
import '../../utils/constants.dart';

class StorageChannel {
  static const MethodChannel _channel = MethodChannel(ChannelNames.storage);

  Future<Map<String, dynamic>> getStorageInfo() async {
    try {
      final Map<dynamic, dynamic> result = 
          await _channel.invokeMethod(MethodNames.getStorageInfo);
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      throw Exception('Failed to get storage info: ${e.message}');
    }
  }
}
```

```dart
// lib/services/platform_channels/sensor_channel.dart

import 'package:flutter/services.dart';
import '../../utils/constants.dart';

class SensorChannel {
  static const MethodChannel _channel = MethodChannel(ChannelNames.sensors);
  static const EventChannel _accelerometerChannel = 
      EventChannel('${ChannelNames.sensors}/accelerometer');
  static const EventChannel _gyroscopeChannel = 
      EventChannel('${ChannelNames.sensors}/gyroscope');

  Future<List<Map<String, dynamic>>> getAvailableSensors() async {
    try {
      final List<dynamic> result = 
          await _channel.invokeMethod(MethodNames.getAvailableSensors);
      return result.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } on PlatformException catch (e) {
      throw Exception('Failed to get sensors: ${e.message}');
    }
  }

  Stream<Map<String, dynamic>> get accelerometerStream {
    return _accelerometerChannel.receiveBroadcastStream().map((event) {
      return Map<String, dynamic>.from(event as Map);
    });
  }

  Stream<Map<String, dynamic>> get gyroscopeStream {
    return _gyroscopeChannel.receiveBroadcastStream().map((event) {
      return Map<String, dynamic>.from(event as Map);
    });
  }
}
```

```dart
// lib/services/platform_channels/system_channel.dart

import 'package:flutter/services.dart';
import '../../utils/constants.dart';

class SystemChannel {
  static const MethodChannel _channel = MethodChannel(ChannelNames.system);

  Future<Map<String, dynamic>> getSystemInfo() async {
    try {
      final Map<dynamic, dynamic> result = 
          await _channel.invokeMethod(MethodNames.getSystemInfo);
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      throw Exception('Failed to get system info: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> getCpuInfo() async {
    try {
      final Map<dynamic, dynamic> result = 
          await _channel.invokeMethod(MethodNames.getCpuInfo);
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      throw Exception('Failed to get CPU info: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> getMemoryInfo() async {
    try {
      final Map<dynamic, dynamic> result = 
          await _channel.invokeMethod(MethodNames.getMemoryInfo);
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      throw Exception('Failed to get memory info: ${e.message}');
    }
  }
}
```

---

## 5. Android Native Implementation

### 5.1 AndroidManifest.xml

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    
    <!-- Battery -->
    <uses-permission android:name="android.permission.BATTERY_STATS"/>
    
    <!-- Network & Connectivity -->
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
    <uses-permission android:name="android.permission.CHANGE_WIFI_STATE"/>
    
    <!-- Location -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
    
    <!-- Phone State -->
    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
    <uses-permission android:name="android.permission.READ_PHONE_NUMBERS"/>
    
    <!-- Bluetooth -->
    <uses-permission android:name="android.permission.BLUETOOTH"/>
    <uses-permission android:name="android.permission.BLUETOOTH_ADMIN"/>
    <uses-permission android:name="android.permission.BLUETOOTH_CONNECT"/>
    <uses-permission android:name="android.permission.BLUETOOTH_SCAN"/>
    
    <!-- Storage -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
    
    <!-- Camera -->
    <uses-permission android:name="android.permission.CAMERA"/>
    
    <!-- System -->
    <uses-permission android:name="android.permission.GET_PACKAGE_SIZE"/>
    <uses-permission android:name="android.permission.PACKAGE_USAGE_STATS"/>
    
    <application
        android:label="device_info_app"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true">
        </activity>
    </application>
</manifest>
```

### 5.2 MainActivity.kt

```kotlin
// android/app/src/main/kotlin/com/example/device_info_app/MainActivity.kt

package com.example.device_info_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import com.example.device_info_app.channels.*

class MainActivity: FlutterActivity() {
    private lateinit var batteryChannel: BatteryChannel
    private lateinit var deviceChannel: DeviceChannel
    private lateinit var connectivityChannel: ConnectivityChannel
    private lateinit var storageChannel: StorageChannel
    private lateinit var sensorChannel: SensorChannel
    private lateinit var systemChannel: SystemChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        batteryChannel = BatteryChannel(this, flutterEngine.dartExecutor.binaryMessenger)
        deviceChannel = DeviceChannel(this, flutterEngine.dartExecutor.binaryMessenger)
        connectivityChannel = ConnectivityChannel(this, flutterEngine.dartExecutor.binaryMessenger)
        storageChannel = StorageChannel(this, flutterEngine.dartExecutor.binaryMessenger)
        sensorChannel = SensorChannel(this, flutterEngine.dartExecutor.binaryMessenger)
        systemChannel = SystemChannel(this, flutterEngine.dartExecutor.binaryMessenger)
    }

    override fun onDestroy() {
        batteryChannel.onDestroy()
        connectivityChannel.onDestroy()
        sensorChannel.onDestroy()
        super.onDestroy()
    }
}
```

### 5.3 BatteryChannel.kt

```kotlin
// android/app/src/main/kotlin/com/example/device_info_app/channels/BatteryChannel.kt

package com.example.device_info_app.channels

import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.content.BroadcastReceiver
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel

class BatteryChannel(
    private val context: Context,
    messenger: BinaryMessenger
) {
    private val methodChannel = MethodChannel(messenger, "com.example.device_info/battery")
    private val eventChannel = EventChannel(messenger, "com.example.device_info/battery/stream")
    private var batteryReceiver: BroadcastReceiver? = null

    init {
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getBatteryInfo" -> {
                    result.success(getBatteryInfo())
                }
                else -> result.notImplemented()
            }
        }

        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                batteryReceiver = createBatteryReceiver(events)
                context.registerReceiver(
                    batteryReceiver,
                    IntentFilter(Intent.ACTION_BATTERY_CHANGED)
                )
            }

            override fun onCancel(arguments: Any?) {
                context.unregisterReceiver(batteryReceiver)
                batteryReceiver = null
            }
        })
    }

    private fun getBatteryInfo(): Map<String, Any?> {
        val batteryStatus: Intent? = IntentFilter(Intent.ACTION_BATTERY_CHANGED).let { filter ->
            context.registerReceiver(null, filter)
        }

        val batteryManager = context.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        
        val level = batteryStatus?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
        val scale = batteryStatus?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1
        val batteryPct = if (level != -1 && scale != -1) {
            (level * 100 / scale.toFloat()).toInt()
        } else {
            -1
        }

        val status = batteryStatus?.getIntExtra(BatteryManager.EXTRA_STATUS, -1) ?: -1
        val statusString = when (status) {
            BatteryManager.BATTERY_STATUS_CHARGING -> "charging"
            BatteryManager.BATTERY_STATUS_DISCHARGING -> "discharging"
            BatteryManager.BATTERY_STATUS_FULL -> "full"
            BatteryManager.BATTERY_STATUS_NOT_CHARGING -> "not_charging"
            else -> "unknown"
        }

        val plugged = batteryStatus?.getIntExtra(BatteryManager.EXTRA_PLUGGED, -1) ?: -1
        val pluggedString = when (plugged) {
            BatteryManager.BATTERY_PLUGGED_AC -> "ac"
            BatteryManager.BATTERY_PLUGGED_USB -> "usb"
            BatteryManager.BATTERY_PLUGGED_WIRELESS -> "wireless"
            else -> "not_plugged"
        }

        val health = batteryStatus?.getIntExtra(BatteryManager.EXTRA_HEALTH, -1) ?: -1
        val healthString = when (health) {
            BatteryManager.BATTERY_HEALTH_GOOD -> "good"
            BatteryManager.BATTERY_HEALTH_OVERHEAT -> "overheat"
            BatteryManager.BATTERY_HEALTH_DEAD -> "dead"
            BatteryManager.BATTERY_HEALTH_OVER_VOLTAGE -> "over_voltage"
            BatteryManager.BATTERY_HEALTH_UNSPECIFIED_FAILURE -> "unspecified_failure"
            BatteryManager.BATTERY_HEALTH_COLD -> "cold"
            else -> "unknown"
        }

        val voltage = batteryStatus?.getIntExtra(BatteryManager.EXTRA_VOLTAGE, -1) ?: -1
        val temperature = batteryStatus?.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, -1) ?: -1
        val technology = batteryStatus?.getStringExtra(BatteryManager.EXTRA_TECHNOLOGY)
        
        val capacity = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        val chargeCounter = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CHARGE_COUNTER)
        val currentNow = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CURRENT_NOW)
        val currentAverage = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CURRENT_AVERAGE)
        val energyCounter = batteryManager.getLongProperty(BatteryManager.BATTERY_PROPERTY_ENERGY_COUNTER)

        return mapOf(
            "level" to batteryPct,
            "status" to statusString,
            "plugged" to pluggedString,
            "health" to healthString,
            "voltage" to voltage,
            "temperature" to (temperature / 10.0),
            "technology" to technology,
            "capacity" to capacity,
            "chargeCounter" to chargeCounter,
            "currentNow" to currentNow,
            "currentAverage" to currentAverage,
            "energyCounter" to energyCounter,
            "present" to (batteryStatus?.getBooleanExtra(BatteryManager.EXTRA_PRESENT, false) ?: false)
        )
    }

    private fun createBatteryReceiver(events: EventChannel.EventSink?): BroadcastReceiver {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                events?.success(getBatteryInfo())
            }
        }
    }

    fun onDestroy() {
        batteryReceiver?.let {
            context.unregisterReceiver(it)
        }
    }
}
```

### 5.4 DeviceChannel.kt

```kotlin
// android/app/src/main/kotlin/com/example/device_info_app/channels/DeviceChannel.kt

package com.example.device_info_app.channels

import android.content.Context
import android.os.Build
import android.provider.Settings
import android.util.DisplayMetrics
import android.view.WindowManager
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

class DeviceChannel(
    private val context: Context,
    messenger: BinaryMessenger
) {
    private val methodChannel = MethodChannel(messenger, "com.example.device_info/device")

    init {
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getDeviceInfo" -> {
                    result.success(getDeviceInfo())
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getDeviceInfo(): Map<String, Any?> {
        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val displayMetrics = DisplayMetrics()
        windowManager.defaultDisplay.getMetrics(displayMetrics)

        return mapOf(
            // Device Info
            "manufacturer" to Build.MANUFACTURER,
            "model" to Build.MODEL,
            "brand" to Build.BRAND,
            "device" to Build.DEVICE,
            "product" to Build.PRODUCT,
            "hardware" to Build.HARDWARE,
            "board" to Build.BOARD,
            "bootloader" to Build.BOOTLOADER,
            "display" to Build.DISPLAY,
            "fingerprint" to Build.FINGERPRINT,
            "host" to Build.HOST,
            "id" to Build.ID,
            "tags" to Build.TAGS,
            "type" to Build.TYPE,
            "user" to Build.USER,
            
            // Android Version Info
            "baseOS" to Build.VERSION.BASE_OS,
            "securityPatch" to Build.VERSION.SECURITY_PATCH,
            "sdkInt" to Build.VERSION.SDK_INT,
            "release" to Build.VERSION.RELEASE,
            "codename" to Build.VERSION.CODENAME,
            "incremental" to Build.VERSION.INCREMENTAL,
            "previewSdkInt" to Build.VERSION.PREVIEW_SDK_INT,
            
            // Supported ABIs
            "supportedAbis" to Build.SUPPORTED_ABIS.toList(),
            "supported32BitAbis" to Build.SUPPORTED_32_BIT_ABIS.toList(),
            "supported64BitAbis" to Build.SUPPORTED_64_BIT_ABIS.toList(),
            
            // IDs
            "androidId" to Settings.Secure.getString(
                context.contentResolver,
                Settings.Secure.ANDROID_ID
            ),
            
            // Display
            "displayWidth" to displayMetrics.widthPixels,
            "displayHeight" to displayMetrics.heightPixels,
            "displayDensity" to displayMetrics.density,
            "displayDpi" to displayMetrics.densityDpi,
            "displayXdpi" to displayMetrics.xdpi,
            "displayYdpi" to displayMetrics.ydpi
        )
    }
}
```

### 5.5 ConnectivityChannel.kt

```kotlin
// android/app/src/main/kotlin/com/example/device_info_app/channels/ConnectivityChannel.kt

package com.example.device_info_app.channels

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.net.wifi.WifiManager
import android.net.wifi.WifiInfo
import android.telephony.TelephonyManager
import android.text.format.Formatter
import android.os.Build
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import android.content.BroadcastReceiver
import android.content.Intent
import android.content.IntentFilter
import android.net.Network
import android.net.NetworkRequest

class ConnectivityChannel(
    private val context: Context,
    messenger: BinaryMessenger
) {
    private val methodChannel = MethodChannel(messenger, "com.example.device_info/connectivity")
    private val eventChannel = EventChannel(messenger, "com.example.device_info/connectivity/stream")
    private var networkCallback: ConnectivityManager.NetworkCallback? = null

    init {
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getConnectivityInfo" -> {
                    result.success(getConnectivityInfo())
                }
                "getWifiInfo" -> {
                    result.success(getWifiInfo())
                }
                "getCellularInfo" -> {
                    result.success(getCellularInfo())
                }
                else -> result.notImplemented()
            }
        }

        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                registerNetworkCallback(events)
            }

            override fun onCancel(arguments: Any?) {
                unregisterNetworkCallback()
            }
        })
    }

    private fun getConnectivityInfo(): Map<String, Any?> {
        val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val network = connectivityManager.activeNetwork
            val capabilities = connectivityManager.getNetworkCapabilities(network)
            
            val type = when {
                capabilities?.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) == true -> "wifi"
                capabilities?.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) == true -> "cellular"
                capabilities?.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) == true -> "ethernet"
                capabilities?.hasTransport(NetworkCapabilities.TRANSPORT_BLUETOOTH) == true -> "bluetooth"
                capabilities?.hasTransport(NetworkCapabilities.TRANSPORT_VPN) == true -> "vpn"
                else -> "none"
            }
            
            return mapOf(
                "type" to type,
                "isConnected" to (network != null),
                "linkDownstreamBandwidthKbps" to capabilities?.linkDownstreamBandwidthKbps,
                "linkUpstreamBandwidthKbps" to capabilities?.linkUpstreamBandwidthKbps
            )
        } else {
            @Suppress("DEPRECATION")
            val networkInfo = connectivityManager.activeNetworkInfo
            return mapOf(
                "type" to networkInfo?.typeName?.lowercase(),
                "isConnected" to (networkInfo?.isConnected == true)
            )
        }
    }

    private fun getWifiInfo(): Map<String, Any?> {
        val wifiManager = context.applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
        val wifiInfo: WifiInfo = wifiManager.connectionInfo
        
        @Suppress("DEPRECATION")
        val ipAddress = Formatter.formatIpAddress(wifiInfo.ipAddress)
        
        return mapOf(
            "ssid" to wifiInfo.ssid.replace("\"", ""),
            "bssid" to wifiInfo.bssid,
            "ipAddress" to ipAddress,
            "macAddress" to wifiInfo.macAddress,
            "linkSpeed" to wifiInfo.linkSpeed,
            "rssi" to wifiInfo.rssi,
            "frequency" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) wifiInfo.frequency else null,
            "networkId" to wifiInfo.networkId,
            "hiddenSSID" to wifiInfo.hiddenSSID,
            "isWifiEnabled" to wifiManager.isWifiEnabled
        )
    }

    private fun getCellularInfo(): Map<String, Any?> {
        val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
        
        val networkType = when (telephonyManager.networkType) {
            TelephonyManager.NETWORK_TYPE_GPRS,
            TelephonyManager.NETWORK_TYPE_EDGE,
            TelephonyManager.NETWORK_TYPE_CDMA,
            TelephonyManager.NETWORK_TYPE_1xRTT,
            TelephonyManager.NETWORK_TYPE_IDEN -> "2G"
            
            TelephonyManager.NETWORK_TYPE_UMTS,
            TelephonyManager.NETWORK_TYPE_EVDO_0,
            TelephonyManager.NETWORK_TYPE_EVDO_A,
            TelephonyManager.NETWORK_TYPE_HSDPA,
            TelephonyManager.NETWORK_TYPE_HSUPA,
            TelephonyManager.NETWORK_TYPE_HSPA,
            TelephonyManager.NETWORK_TYPE_EVDO_B,
            TelephonyManager.NETWORK_TYPE_EHRPD,
            TelephonyManager.NETWORK_TYPE_HSPAP -> "3G"
            
            TelephonyManager.NETWORK_TYPE_LTE -> "4G"
            
            TelephonyManager.NETWORK_TYPE_NR -> "5G"
            
            else -> "Unknown"
        }
        
        return mapOf(
            "networkOperatorName" to telephonyManager.networkOperatorName,
            "networkOperator" to telephonyManager.networkOperator,
            "networkType" to networkType,
            "simState" to telephonyManager.simState,
            "simOperatorName" to telephonyManager.simOperatorName,
            "simOperator" to telephonyManager.simOperator,
            "phoneType" to telephonyManager.phoneType,
            "dataActivity" to telephonyManager.dataActivity,
            "dataState" to telephonyManager.dataState,
            "isNetworkRoaming" to telephonyManager.isNetworkRoaming
        )
    }

    private fun registerNetworkCallback(events: EventChannel.EventSink?) {
        val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            networkCallback = object : ConnectivityManager.NetworkCallback() {
                override fun onAvailable(network: Network) {
                    events?.success(getConnectivityInfo())
                }

                override fun onLost(network: Network) {
                    events?.success(getConnectivityInfo())
                }

                override fun onCapabilitiesChanged(
                    network: Network,
                    networkCapabilities: NetworkCapabilities
                ) {
                    events?.success(getConnectivityInfo())
                }
            }
            
            connectivityManager.registerDefaultNetworkCallback(networkCallback!!)
        }
    }

    private fun unregisterNetworkCallback() {
        networkCallback?.let {
            val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            connectivityManager.unregisterNetworkCallback(it)
        }
    }

    fun onDestroy() {
        unregisterNetworkCallback()
    }
}
```

### 5.6 StorageChannel.kt

```kotlin
// android/app/src/main/kotlin/com/example/device_info_app/channels/StorageChannel.kt

package com.example.device_info_app.channels

import android.content.Context
import android.os.Environment
import android.os.StatFs
import android.os.Build
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import java.io.File

class StorageChannel(
    private val context: Context,
    messenger: BinaryMessenger
) {
    private val methodChannel = MethodChannel(messenger, "com.example.device_info/storage")

    init {
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getStorageInfo" -> {
                    result.success(getStorageInfo())
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getStorageInfo(): Map<String, Any?> {
        val internalPath = Environment.getDataDirectory()
        val internalStat = StatFs(internalPath.path)
        
        val internalTotal = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
            internalStat.blockSizeLong * internalStat.blockCountLong
        } else {
            @Suppress("DEPRECATION")
            internalStat.blockSize.toLong() * internalStat.blockCount.toLong()
        }
        
        val internalFree = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
            internalStat.blockSizeLong * internalStat.availableBlocksLong
        } else {
            @Suppress("DEPRECATION")
            internalStat.blockSize.toLong() * internalStat.availableBlocks.toLong()
        }
        
        // External storage
        val externalPath = Environment.getExternalStorageDirectory()
        val externalStat = StatFs(externalPath.path)
        
        val externalTotal = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
            externalStat.blockSizeLong * externalStat.blockCountLong
        } else {
            @Suppress("DEPRECATION")
            externalStat.blockSize.toLong() * externalStat.blockCount.toLong()
        }
        
        val externalFree = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR2) {
            externalStat.blockSizeLong * externalStat.availableBlocksLong
        } else {
            @Suppress("DEPRECATION")
            externalStat.blockSize.toLong() * externalStat.availableBlocks.toLong()
        }
        
        return mapOf(
            "internal" to mapOf(
                "total" to internalTotal,
                "free" to internalFree,
                "used" to (internalTotal - internalFree)
            ),
            "external" to mapOf(
                "total" to externalTotal,
                "free" to externalFree,
                "used" to (externalTotal - externalFree),
                "isMounted" to (Environment.getExternalStorageState() == Environment.MEDIA_MOUNTED),
                "isRemovable" to Environment.isExternalStorageRemovable(),
                "isEmulated" to Environment.isExternalStorageEmulated()
            ),
            "cacheDir" to context.cacheDir.absolutePath,
            "dataDir" to context.dataDir?.absolutePath,
            "filesDir" to context.filesDir.absolutePath
        )
    }
}
```

### 5.7 SensorChannel.kt

```kotlin
// android/app/src/main/kotlin/com/example/device_info_app/channels/SensorChannel.kt

package com.example.device_info_app.channels

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel

class SensorChannel(
    private val context: Context,
    messenger: BinaryMessenger
) : SensorEventListener {
    private val methodChannel = MethodChannel(messenger, "com.example.device_info/sensors")
    private val accelerometerChannel = EventChannel(messenger, "com.example.device_info/sensors/accelerometer")
    private val gyroscopeChannel = EventChannel(messenger, "com.example.device_info/sensors/gyroscope")
    
    private val sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
    private var accelerometerSink: EventChannel.EventSink? = null
    private var gyroscopeSink: EventChannel.EventSink? = null

    init {
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getAvailableSensors" -> {
                    result.success(getAvailableSensors())
                }
                else -> result.notImplemented()
            }
        }

        accelerometerChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                accelerometerSink = events
                val sensor = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
                sensorManager.registerListener(
                    this@SensorChannel,
                    sensor,
                    SensorManager.SENSOR_DELAY_NORMAL
                )
            }

            override fun onCancel(arguments: Any?) {
                accelerometerSink = null
                sensorManager.unregisterListener(this@SensorChannel)
            }
        })

        gyroscopeChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                gyroscopeSink = events
                val sensor = sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE)
                sensorManager.registerListener(
                    this@SensorChannel,
                    sensor,
                    SensorManager.SENSOR_DELAY_NORMAL
                )
            }

            override fun onCancel(arguments: Any?) {
                gyroscopeSink = null
                sensorManager.unregisterListener(this@SensorChannel)
            }
        })
    }

    private fun getAvailableSensors(): List<Map<String, Any?>> {
        val sensors = sensorManager.getSensorList(Sensor.TYPE_ALL)
        return sensors.map { sensor ->
            mapOf(
                "name" to sensor.name,
                "type" to sensor.type,
                "vendor" to sensor.vendor,
                "version" to sensor.version,
                "power" to sensor.power,
                "maxRange" to sensor.maximumRange,
                "resolution" to sensor.resolution
            )
        }
    }

    override fun onSensorChanged(event: SensorEvent?) {
        event?.let {
            when (it.sensor.type) {
                Sensor.TYPE_ACCELEROMETER -> {
                    accelerometerSink?.success(mapOf(
                        "x" to it.values[0],
                        "y" to it.values[1],
                        "z" to it.values[2],
                        "timestamp" to it.timestamp
                    ))
                }
                Sensor.TYPE_GYROSCOPE -> {
                    gyroscopeSink?.success(mapOf(
                        "x" to it.values[0],
                        "y" to it.values[1],
                        "z" to it.values[2],
                        "timestamp" to it.timestamp
                    ))
                }
            }
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
        // Handle accuracy changes if needed
    }

    fun onDestroy() {
        sensorManager.unregisterListener(this)
    }
}
```

### 5.8 SystemChannel.kt

```kotlin
// android/app/src/main/kotlin/com/example/device_info_app/channels/SystemChannel.kt

package com.example.device_info_app.channels

import android.app.ActivityManager
import android.content.Context
import android.os.Build
import android.os.SystemClock
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import java.io.RandomAccessFile

class SystemChannel(
    private val context: Context,
    messenger: BinaryMessenger
) {
    private val methodChannel = MethodChannel(messenger, "com.example.device_info/system")

    init {
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getSystemInfo" -> {
                    result.success(getSystemInfo())
                }
                "getCpuInfo" -> {
                    result.success(getCpuInfo())
                }
                "getMemoryInfo" -> {
                    result.success(getMemoryInfo())
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getSystemInfo(): Map<String, Any?> {
        val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        
        return mapOf(
            "uptime" to SystemClock.elapsedRealtime(),
            "bootTime" to (System.currentTimeMillis() - SystemClock.elapsedRealtime()),
            "kernelVersion" to System.getProperty("os.version"),
            "kernelArchitecture" to System.getProperty("os.arch")
        )
    }

    private fun getCpuInfo(): Map<String, Any?> {
        val cores = Runtime.getRuntime().availableProcessors()
        
        // Read CPU info from /proc/cpuinfo
        val cpuInfo = mutableMapOf<String, String>()
        try {
            RandomAccessFile("/proc/cpuinfo", "r").use { reader ->
                var line: String?
                while (reader.readLine().also { line = it } != null) {
                    val parts = line!!.split(":")
                    if (parts.size == 2) {
                        val key = parts[0].trim()
                        val value = parts[1].trim()
                        if (key.isNotEmpty() && !cpuInfo.containsKey(key)) {
                            cpuInfo[key] = value
                        }
                    }
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
        
        return mapOf(
            "cores" to cores,
            "processor" to cpuInfo.getOrDefault("Processor", "Unknown"),
            "hardware" to cpuInfo.getOrDefault("Hardware", "Unknown"),
            "architecture" to System.getProperty("os.arch")
        )
    }

    private fun getMemoryInfo(): Map<String, Any?> {
        val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        val memoryInfo = ActivityManager.MemoryInfo()
        activityManager.getMemoryInfo(memoryInfo)
        
        return mapOf(
            "totalMemory" to memoryInfo.totalMem,
            "availableMemory" to memoryInfo.availMem,
            "threshold" to memoryInfo.threshold,
            "lowMemory" to memoryInfo.lowMemory,
            "usedMemory" to (memoryInfo.totalMem - memoryInfo.availMem)
        )
    }
}
```

---

## 6. iOS Native Implementation

### 6.1 Info.plist

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <!-- Location -->
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>We need location access to show device location information</string>
    <key>NSLocationAlwaysUsageDescription</key>
    <string>We need location access to show device location information</string>
    
    <!-- Camera -->
    <key>NSCameraUsageDescription</key>
    <string>We need camera access to show camera information</string>
    
    <!-- Motion -->
    <key>NSMotionUsageDescription</key>
    <string>We need motion access to show sensor information</string>
    
    <!-- Bluetooth -->
    <key>NSBluetoothAlwaysUsageDescription</key>
    <string>We need bluetooth access to show connectivity information</string>
</dict>
</plist>
```

### 6.2 AppDelegate.swift

```swift
// ios/Runner/AppDelegate.swift

import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private var batteryChannel: BatteryChannel?
    private var deviceChannel: DeviceChannel?
    private var connectivityChannel: ConnectivityChannel?
    private var storageChannel: StorageChannel?
    private var sensorChannel: SensorChannel?
    private var systemChannel: SystemChannel?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        
        batteryChannel = BatteryChannel(messenger: controller.binaryMessenger)
        deviceChannel = DeviceChannel(messenger: controller.binaryMessenger)
        connectivityChannel = ConnectivityChannel(messenger: controller.binaryMessenger)
        storageChannel = StorageChannel(messenger: controller.binaryMessenger)
        sensorChannel = SensorChannel(messenger: controller.binaryMessenger)
        systemChannel = SystemChannel(messenger: controller.binaryMessenger)
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
```

### 6.3 BatteryChannel.swift

```swift
// ios/Runner/Channels/BatteryChannel.swift

import Flutter
import UIKit

class BatteryChannel {
    private let methodChannel: FlutterMethodChannel
    private let eventChannel: FlutterEventChannel
    private var eventSink: FlutterEventSink?
    
    init(messenger: FlutterBinaryMessenger) {
        methodChannel = FlutterMethodChannel(
            name: "com.example.device_info/battery",
            binaryMessenger: messenger
        )
        
        eventChannel = FlutterEventChannel(
            name: "com.example.device_info/battery/stream",
            binaryMessenger: messenger
        )
        
        setupMethodChannel()
        setupEventChannel()
        setupBatteryMonitoring()
    }
    
    private func setupMethodChannel() {
        methodChannel.setMethodCallHandler { [weak self] (call, result) in
            switch call.method {
            case "getBatteryInfo":
                result(self?.getBatteryInfo())
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }
    
    private func setupEventChannel() {
        eventChannel.setStreamHandler(self)
    }
    
    private func setupBatteryMonitoring() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(batteryLevelChanged),
            name: UIDevice.batteryLevelDidChangeNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(batteryStateChanged),
            name: UIDevice.batteryStateDidChangeNotification,
            object: nil
        )
    }
    
    @objc private func batteryLevelChanged() {
        eventSink?(getBatteryInfo())
    }
    
    @objc private func batteryStateChanged() {
        eventSink?(getBatteryInfo())
    }
    
    private func getBatteryInfo() -> [String: Any] {
        let device = UIDevice.current
        let level = Int(device.batteryLevel * 100)
        
        let state: String
        switch device.batteryState {
        case .charging:
            state = "charging"
        case .full:
            state = "full"
        case .unplugged:
            state = "unplugged"
        default:
            state = "unknown"
        }
        
        let lowPowerMode = ProcessInfo.processInfo.isLowPowerModeEnabled
        
        return [
            "level": level,
            "status": state,
            "lowPowerMode": lowPowerMode
        ]
    }
}

extension BatteryChannel: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        events(getBatteryInfo())
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
}
```

### 6.4 DeviceChannel.swift

```swift
// ios/Runner/Channels/DeviceChannel.swift

import Flutter
import UIKit

class DeviceChannel {
    private let methodChannel: FlutterMethodChannel
    
    init(messenger: FlutterBinaryMessenger) {
        methodChannel = FlutterMethodChannel(
            name: "com.example.device_info/device",
            binaryMessenger: messenger
        )
        
        setupMethodChannel()
    }
    
    private func setupMethodChannel() {
        methodChannel.setMethodCallHandler { [weak self] (call, result) in
            switch call.method {
            case "getDeviceInfo":
                result(self?.getDeviceInfo())
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }
    
    private func getDeviceInfo() -> [String: Any] {
        let device = UIDevice.current
        
        return [
            "name": device.name,
            "model": device.model,
            "systemName": device.systemName,
            "systemVersion": device.systemVersion,
            "localizedModel": device.localizedModel,
            "identifierForVendor": device.identifierForVendor?.uuidString ?? "Unknown",
            "isPhysicalDevice": TARGET_OS_SIMULATOR == 0
        ]
    }
}
```

---

## 7. Data Models

### 7.1 Battery Info Model

```dart
// lib/data/models/battery_info.dart

import 'package:equatable/equatable.dart';

class BatteryInfo extends Equatable {
  final int level;
  final String status;
  final String? plugged;
  final String? health;
  final int? voltage;
  final double? temperature;
  final String? technology;
  final bool? present;
  final int? capacity;
  final int? chargeCounter;
  final int? currentNow;
  final int? currentAverage;
  final int? energyCounter;
  final bool? lowPowerMode; // iOS

  const BatteryInfo({
    required this.level,
    required this.status,
    this.plugged,
    this.health,
    this.voltage,
    this.temperature,
    this.technology,
    this.present,
    this.capacity,
    this.chargeCounter,
    this.currentNow,
    this.currentAverage,
    this.energyCounter,
    this.lowPowerMode,
  });

  factory BatteryInfo.fromMap(Map<String, dynamic> map) {
    return BatteryInfo(
      level: map['level'] ?? 0,
      status: map['status'] ?? 'unknown',
      plugged: map['plugged'],
      health: map['health'],
      voltage: map['voltage'],
      temperature: map['temperature']?.toDouble(),
      technology: map['technology'],
      present: map['present'],
      capacity: map['capacity'],
      chargeCounter: map['chargeCounter'],
      currentNow: map['currentNow'],
      currentAverage: map['currentAverage'],
      energyCounter: map['energyCounter'],
      lowPowerMode: map['lowPowerMode'],
    );
  }

  @override
  List<Object?> get props => [
        level,
        status,
        plugged,
        health,
        voltage,
        temperature,
        technology,
        present,
        capacity,
        chargeCounter,
        currentNow,
        currentAverage,
        energyCounter,
        lowPowerMode,
      ];
}
```

### 7.2 Device Info Model

```dart
// lib/data/models/device_info.dart

import 'package:equatable/equatable.dart';

class DeviceInfo extends Equatable {
  final String manufacturer;
  final String model;
  final String brand;
  final String device;
  final String osVersion;
  final int? sdkInt;
  final String? androidId;
  final Map<String, dynamic> additionalInfo;

  const DeviceInfo({
    required this.manufacturer,
    required this.model,
    required this.brand,
    required this.device,
    required this.osVersion,
    this.sdkInt,
    this.androidId,
    this.additionalInfo = const {},
  });

  factory DeviceInfo.fromMap(Map<String, dynamic> map) {
    return DeviceInfo(
      manufacturer: map['manufacturer'] ?? map['name'] ?? 'Unknown',
      model: map['model'] ?? 'Unknown',
      brand: map['brand'] ?? map['systemName'] ?? 'Unknown',
      device: map['device'] ?? map['model'] ?? 'Unknown',
      osVersion: map['release'] ?? map['systemVersion'] ?? 'Unknown',
      sdkInt: map['sdkInt'],
      androidId: map['androidId'] ?? map['identifierForVendor'],
      additionalInfo: Map<String, dynamic>.from(map),
    );
  }

  @override
  List<Object?> get props => [
        manufacturer,
        model,
        brand,
        device,
        osVersion,
        sdkInt,
        androidId,
        additionalInfo,
      ];
}
```

---

## 8. BLoC Implementation

### 8.1 Battery BLoC

```dart
// lib/blocs/battery/battery_event.dart

import 'package:equatable/equatable.dart';

abstract class BatteryEvent extends Equatable {
  const BatteryEvent();

  @override
  List<Object> get props => [];
}

class LoadBatteryInfo extends BatteryEvent {}

class BatteryInfoUpdated extends BatteryEvent {
  final Map<String, dynamic> info;

  const BatteryInfoUpdated(this.info);

  @override
  List<Object> get props => [info];
}

class RefreshBatteryInfo extends BatteryEvent {}
```

```dart
// lib/blocs/battery/battery_state.dart

import 'package:equatable/equatable.dart';
import '../../data/models/battery_info.dart';

abstract class BatteryState extends Equatable {
  const BatteryState();

  @override
  List<Object?> get props => [];
}

class BatteryInitial extends BatteryState {}

class BatteryLoading extends BatteryState {}

class BatteryLoaded extends BatteryState {
  final BatteryInfo batteryInfo;

  const BatteryLoaded(this.batteryInfo);

  @override
  List<Object?> get props => [batteryInfo];
}

class BatteryError extends BatteryState {
  final String message;

  const BatteryError(this.message);

  @override
  List<Object?> get props => [message];
}
```

```dart
// lib/blocs/battery/battery_bloc.dart

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/battery_repository.dart';
import 'battery_event.dart';
import 'battery_state.dart';

class BatteryBloc extends Bloc<BatteryEvent, BatteryState> {
  final BatteryRepository repository;
  StreamSubscription? _batterySubscription;

  BatteryBloc({required this.repository}) : super(BatteryInitial()) {
    on<LoadBatteryInfo>(_onLoadBatteryInfo);
    on<BatteryInfoUpdated>(_onBatteryInfoUpdated);
    on<RefreshBatteryInfo>(_onRefreshBatteryInfo);
  }

  Future<void> _onLoadBatteryInfo(
    LoadBatteryInfo event,
    Emitter<BatteryState> emit,
  ) async {
    emit(BatteryLoading());
    try {
      final batteryInfo = await repository.getBatteryInfo();
      emit(BatteryLoaded(batteryInfo));

      // Subscribe to battery updates
      _batterySubscription?.cancel();
      _batterySubscription = repository.batteryStream.listen((info) {
        add(BatteryInfoUpdated(info));
      });
    } catch (e) {
      emit(BatteryError(e.toString()));
    }
  }

  void _onBatteryInfoUpdated(
    BatteryInfoUpdated event,
    Emitter<BatteryState> emit,
  ) {
    try {
      final batteryInfo = repository.parseBatteryInfo(event.info);
      emit(BatteryLoaded(batteryInfo));
    } catch (e) {
      emit(BatteryError(e.toString()));
    }
  }

  Future<void> _onRefreshBatteryInfo(
    RefreshBatteryInfo event,
    Emitter<BatteryState> emit,
  ) async {
    try {
      final batteryInfo = await repository.getBatteryInfo();
      emit(BatteryLoaded(batteryInfo));
    } catch (e) {
      emit(BatteryError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _batterySubscription?.cancel();
    return super.close();
  }
}
```

### 8.2 Device BLoC

```dart
// lib/blocs/device/device_event.dart

import 'package:equatable/equatable.dart';

abstract class DeviceEvent extends Equatable {
  const DeviceEvent();

  @override
  List<Object> get props => [];
}

class LoadDeviceInfo extends DeviceEvent {}

class RefreshDeviceInfo extends DeviceEvent {}
```

```dart
// lib/blocs/device/device_state.dart

import 'package:equatable/equatable.dart';
import '../../data/models/device_info.dart';

abstract class DeviceState extends Equatable {
  const DeviceState();

  @override
  List<Object?> get props => [];
}

class DeviceInitial extends DeviceState {}

class DeviceLoading extends DeviceState {}

class DeviceLoaded extends DeviceState {
  final DeviceInfo deviceInfo;

  const DeviceLoaded(this.deviceInfo);

  @override
  List<Object?> get props => [deviceInfo];
}

class DeviceError extends DeviceState {
  final String message;

  const DeviceError(this.message);

  @override
  List<Object?> get props => [message];
}
```

```dart
// lib/blocs/device/device_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/device_repository.dart';
import 'device_event.dart';
import 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceRepository repository;

  DeviceBloc({required this.repository}) : super(DeviceInitial()) {
    on<LoadDeviceInfo>(_onLoadDeviceInfo);
    on<RefreshDeviceInfo>(_onRefreshDeviceInfo);
  }

  Future<void> _onLoadDeviceInfo(
    LoadDeviceInfo event,
    Emitter<DeviceState> emit,
  ) async {
    emit(DeviceLoading());
    try {
      final deviceInfo = await repository.getDeviceInfo();
      emit(DeviceLoaded(deviceInfo));
    } catch (e) {
      emit(DeviceError(e.toString()));
    }
  }

  Future<void> _onRefreshDeviceInfo(
    RefreshDeviceInfo event,
    Emitter<DeviceState> emit,
  ) async {
    try {
      final deviceInfo = await repository.getDeviceInfo();
      emit(DeviceLoaded(deviceInfo));
    } catch (e) {
      emit(DeviceError(e.toString()));
    }
  }
}
```

---

## 9. Repository Layer

### 9.1 Battery Repository

```dart
// lib/data/repositories/battery_repository.dart

import '../models/battery_info.dart';
import '../../services/platform_channels/battery_channel.dart';

class BatteryRepository {
  final BatteryChannel _channel;

  BatteryRepository(this._channel);

  Future<BatteryInfo> getBatteryInfo() async {
    final data = await _channel.getBatteryInfo();
    return BatteryInfo.fromMap(data);
  }

  Stream<Map<String, dynamic>> get batteryStream => _channel.batteryStream;

  BatteryInfo parseBatteryInfo(Map<String, dynamic> data) {
    return BatteryInfo.fromMap(data);
  }
}
```

### 9.2 Device Repository

```dart
// lib/data/repositories/device_repository.dart

import '../models/device_info.dart';
import '../../services/platform_channels/device_channel.dart';

class DeviceRepository {
  final DeviceChannel _channel;

  DeviceRepository(this._channel);

  Future<DeviceInfo> getDeviceInfo() async {
    final data = await _channel.getDeviceInfo();
    return DeviceInfo.fromMap(data);
  }
}
```

---

## 10. UI Implementation

### 10.1 Main App

```dart
// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'services/platform_channels/battery_channel.dart';
import 'services/platform_channels/device_channel.dart';
import 'services/platform_channels/connectivity_channel.dart';
import 'services/platform_channels/storage_channel.dart';
import 'services/platform_channels/sensor_channel.dart';
import 'services/platform_channels/system_channel.dart';
import 'data/repositories/battery_repository.dart';
import 'data/repositories/device_repository.dart';
import 'blocs/battery/battery_bloc.dart';
import 'blocs/device/device_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => BatteryRepository(BatteryChannel())),
        RepositoryProvider(create: (_) => DeviceRepository(DeviceChannel())),
        // Add other repositories
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BatteryBloc(
              repository: context.read<BatteryRepository>(),
            )..add(LoadBatteryInfo()),
          ),
          BlocProvider(
            create: (context) => DeviceBloc(
              repository: context.read<DeviceRepository>(),
            )..add(LoadDeviceInfo()),
          ),
          // Add other BLoCs
        ],
        child: const DeviceInfoApp(),
      ),
    );
  }
}
```

```dart
// lib/app.dart

import 'package:flutter/material.dart';
import 'presentation/screens/home_screen.dart';

class DeviceInfoApp extends StatelessWidget {
  const DeviceInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Device Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
```

### 10.2 Home Screen

```dart
// lib/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/battery/battery_bloc.dart';
import '../../blocs/battery/battery_state.dart';
import '../../blocs/device/device_bloc.dart';
import '../../blocs/device/device_state.dart';
import '../widgets/info_card.dart';
import 'battery_detail_screen.dart';
import 'device_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Information'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<BatteryBloc>().add(RefreshBatteryInfo());
          context.read<DeviceBloc>().add(RefreshDeviceInfo());
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Battery Card
            BlocBuilder<BatteryBloc, BatteryState>(
              builder: (context, state) {
                if (state is BatteryLoaded) {
                  return InfoCard(
                    title: 'Battery',
                    icon: Icons.battery_charging_full,
                    value: '${state.batteryInfo.level}%',
                    subtitle: state.batteryInfo.status,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BatteryDetailScreen(),
                      ),
                    ),
                  );
                }
                return const InfoCard(
                  title: 'Battery',
                  icon: Icons.battery_charging_full,
                  value: 'Loading...',
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Device Card
            BlocBuilder<DeviceBloc, DeviceState>(
              builder: (context, state) {
                if (state is DeviceLoaded) {
                  return InfoCard(
                    title: 'Device',
                    icon: Icons.phone_android,
                    value: state.deviceInfo.model,
                    subtitle: state.deviceInfo.manufacturer,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DeviceDetailScreen(),
                      ),
                    ),
                  );
                }
                return const InfoCard(
                  title: 'Device',
                  icon: Icons.phone_android,
                  value: 'Loading...',
                );
              },
            ),
            
            // Add more cards for other categories
          ],
        ),
      ),
    );
  }
}
```

### 10.3 Info Card Widget

```dart
// lib/presentation/widgets/info_card.dart

import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String value;
  final String? subtitle;
  final VoidCallback? onTap;

  const InfoCard({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              if (onTap != null)
                const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 11. Development Timeline

### Week 1: Setup & Infrastructure
- Day 1-2: Project setup, dependencies
- Day 3-4: Platform channel structure setup
- Day 5-7: Basic BLoC architecture implementation

### Week 2: Android Native Implementation
- Day 1-2: Battery & Device channels
- Day 3-4: Connectivity & Storage channels
- Day 5-6: Sensor & System channels
- Day 7: Testing Android channels

### Week 3: iOS Native Implementation
- Day 1-2: Battery & Device channels
- Day 3-4: Connectivity & Storage channels
- Day 5-6: Sensor & System channels
- Day 7: Testing iOS channels

### Week 4: Flutter Layer
- Day 1-2: Models & Repositories
- Day 3-5: All BLoCs implementation
- Day 6-7: Testing state management

### Week 5: UI Development
- Day 1-2: Home screen & navigation
- Day 3-5: Detail screens for all categories
- Day 6-7: Widgets & polish

### Week 6: Testing & Polish
- Day 1-3: Unit & integration tests
- Day 4-5: UI/UX refinements
- Day 6-7: Final testing & bug fixes

---

## 12. Testing Strategy

### 12.1 Unit Tests

```dart
// test/blocs/battery_bloc_test.dart

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBatteryRepository extends Mock implements BatteryRepository {}

void main() {
  group('BatteryBloc', () {
    late MockBatteryRepository repository;

    setUp(() {
      repository = MockBatteryRepository();
    });

    test('initial state is BatteryInitial', () {
      final bloc = BatteryBloc(repository: repository);
      expect(bloc.state, BatteryInitial());
    });

    blocTest<BatteryBloc, BatteryState>(
      'emits [BatteryLoading, BatteryLoaded] when LoadBatteryInfo is added',
      build: () {
        when(() => repository.getBatteryInfo()).thenAnswer(
          (_) async => const BatteryInfo(level: 75, status: 'charging'),
        );
        return BatteryBloc(repository: repository);
      },
      act: (bloc) => bloc.add(LoadBatteryInfo()),
      expect: () => [
        BatteryLoading(),
        const BatteryLoaded(BatteryInfo(level: 75, status: 'charging')),
      ],
    );
  });
}
```

### 12.2 Widget Tests

```dart
// test/widgets/info_card_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('InfoCard displays correct information', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InfoCard(
            title: 'Battery',
            icon: Icons.battery_charging_full,
            value: '75%',
            subtitle: 'Charging',
          ),
        ),
      ),
    );

    expect(find.text('Battery'), findsOneWidget);
    expect(find.text('75%'), findsOneWidget);
    expect(find.text('Charging'), findsOneWidget);
    expect(find.byIcon(Icons.battery_charging_full), findsOneWidget);
  });
}
```

---

## 13. Build & Deploy

### 13.1 Android Build

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# App Bundle (for Play Store)
flutter build appbundle --release
```

### 13.2 iOS Build

```bash
# Debug
flutter build ios --debug

# Release
flutter build ios --release
```

---

## 14. Key Features Summary

✅ **Battery Information** - Level, status, health, temperature, voltage
✅ **Device Details** - Model, manufacturer, OS version, hardware info
✅ **Connectivity** - WiFi, cellular, network details
✅ **Storage** - Internal/external storage usage
✅ **Sensors** - Accelerometer, gyroscope, all available sensors
✅ **System Info** - CPU, memory, uptime
✅ **Real-time Updates** - Event channels for live data
✅ **BLoC State Management** - Clean architecture
✅ **Platform Channels** - Native Android/iOS integration
✅ **Responsive UI** - Material Design with dark mode

This comprehensive plan provides everything needed to build a full-featured device information app using Flutter with BLoC and platform channels!