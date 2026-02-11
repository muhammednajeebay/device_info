package com.example.device_info

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import com.example.device_info.channels.BatteryChannel
import com.example.device_info.channels.DeviceChannel
import com.example.device_info.channels.StorageChannel
import com.example.device_info.channels.SystemChannel
import com.example.device_info.channels.ConnectivityChannel
import com.example.device_info.channels.SensorsChannel
import com.example.device_info.channels.LocationChannel

/**
 * MainActivity: The entry point of the Android application.
 * This class orchestrates the initialization and mapping of all Native -> Flutter communication channels.
 */
class MainActivity : FlutterActivity() {
    private lateinit var batteryChannel: BatteryChannel
    private lateinit var deviceChannel: DeviceChannel
    private lateinit var storageChannel: StorageChannel
    private lateinit var systemChannel: SystemChannel
    private lateinit var connectivityChannel: ConnectivityChannel
    private lateinit var sensorsChannel: SensorsChannel
    private lateinit var locationChannel: LocationChannel
    
    /**
     * configureFlutterEngine: Lifecycle hook where we register our platform channels.
     * Logic:
     * 1. Initialize channel logic classes with context.
     * 2. Define MethodChannels (Request-Response) and EventChannels (Streams).
     * 3. Attach handlers to bridge custom logic to Flutter.
     */
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // 1. Initialize logic controllers
        batteryChannel = BatteryChannel(this)
        deviceChannel = DeviceChannel(this)
        storageChannel = StorageChannel(this)
        systemChannel = SystemChannel(this)
        connectivityChannel = ConnectivityChannel(this)
        sensorsChannel = SensorsChannel(this)
        locationChannel = LocationChannel(this)
        
        // 2. Setup Battery Channels (Method & Event)
        val batteryMethodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.device_info/battery"
        )
        batteryChannel.setupMethodChannel(batteryMethodChannel)
        
        val batteryEventChannel = EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.device_info/battery/stream"
        )
        batteryChannel.setupEventChannel(batteryEventChannel)
        
        // 3. Setup Device Identity Channel
        val deviceMethodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.device_info/device"
        )
        deviceChannel.setupMethodChannel(deviceMethodChannel)
        
        // 4. Setup Storage Statistics Channel
        val storageMethodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.device_info/storage"
        )
        storageChannel.setupMethodChannel(storageMethodChannel)
        
        // 5. Setup CPU/RAM System Channel
        val systemMethodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.device_info/system"
        )
        systemChannel.setupMethodChannel(systemMethodChannel)

        // 6. Setup Network Connectivity Channel
        val connectivityMethodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.device_info/connectivity"
        )
        connectivityChannel.setupMethodChannel(connectivityMethodChannel)

        // 7. Setup Sensor Hardware Channel
        val sensorsMethodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.device_info/sensors"
        )
        sensorsChannel.setupMethodChannel(sensorsMethodChannel)

        // 8. Setup GPS Location Channel
        val locationMethodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.device_info/location"
        )
        locationChannel.setupMethodChannel(locationMethodChannel)
    }
}
