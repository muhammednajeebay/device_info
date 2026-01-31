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

class MainActivity : FlutterActivity() {
    private lateinit var batteryChannel: BatteryChannel
    private lateinit var deviceChannel: DeviceChannel
    private lateinit var storageChannel: StorageChannel
    private lateinit var systemChannel: SystemChannel
    private lateinit var connectivityChannel: ConnectivityChannel
    private lateinit var sensorsChannel: SensorsChannel
    private lateinit var locationChannel: LocationChannel
    
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // Initialize channels
        batteryChannel = BatteryChannel(this)
        deviceChannel = DeviceChannel(this)
        storageChannel = StorageChannel(this)
        systemChannel = SystemChannel(this)
        connectivityChannel = ConnectivityChannel(this)
        sensorsChannel = SensorsChannel(this)
        locationChannel = LocationChannel(this)
        
        // Setup Battery Channel
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
        
        // Setup Device Channel
        val deviceMethodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.device_info/device"
        )
        deviceChannel.setupMethodChannel(deviceMethodChannel)
        
        // Setup Storage Channel
        val storageMethodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.device_info/storage"
        )
        storageChannel.setupMethodChannel(storageMethodChannel)
        
        // Setup System Channel
        val systemMethodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.device_info/system"
        )
        systemChannel.setupMethodChannel(systemMethodChannel)

        // Setup Connectivity Channel
        val connectivityMethodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.device_info/connectivity"
        )
        connectivityChannel.setupMethodChannel(connectivityMethodChannel)

        // Setup Sensors Channel
        val sensorsMethodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.device_info/sensors"
        )
        sensorsChannel.setupMethodChannel(sensorsMethodChannel)

        // Setup Location Channel
        val locationMethodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.example.device_info/location"
        )
        locationChannel.setupMethodChannel(locationMethodChannel)
    }
}
