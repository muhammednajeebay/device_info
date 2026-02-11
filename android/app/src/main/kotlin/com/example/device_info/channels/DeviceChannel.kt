package com.example.device_info.channels

import android.content.Context
import android.os.Build
import android.provider.Settings
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * DeviceChannel: Fetches static hardware and OS information from the Android device.
 * 
 * Usage:
 * - MethodChannel: Triggered during app initialization to populate device identity details.
 */
class DeviceChannel(private val context: Context) {
    
    /**
     * Set up the MethodChannel handler to respond to "getDeviceInfo" calls from Flutter.
     */
    fun setupMethodChannel(channel: MethodChannel) {
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getDeviceInfo" -> {
                    try {
                        val deviceInfo = getDeviceInfo()
                        result.success(deviceInfo)
                    } catch (e: Exception) {
                        result.error("DEVICE_ERROR", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
    
    /**
     * Gathers all relevant hardware constants from the Android Build class.
     * 
     * Output (Map returned to Flutter):
     * - "manufacturer": String (e.g., "Google")
     * - "model": String (e.g., "Pixel 7")
     * - "brand": String (e.g., "google")
     * - "device": String (e.g., "panther")
     * - "hardware": String (e.g., "cheetah")
     * - "androidId": String? (Unique device ID)
     * - "fingerprint": String (Unique build identifier)
     * - "buildId": String (OS build version)
     * - "sdkVersion": String (API level)
     * - "releaseVersion": String (Android version)
     * - "supportedAbis": List<String> (Processor architectures)
     */
    private fun getDeviceInfo(): Map<String, Any?> {
        val androidId = Settings.Secure.getString(
            context.contentResolver,
            Settings.Secure.ANDROID_ID
        )
        
        return mapOf(
            "manufacturer" to Build.MANUFACTURER,
            "model" to Build.MODEL,
            "brand" to Build.BRAND,
            "device" to Build.DEVICE,
            "hardware" to Build.HARDWARE,
            "androidId" to androidId,
            "fingerprint" to Build.FINGERPRINT,
            "buildId" to Build.ID,
            "sdkVersion" to Build.VERSION.SDK_INT.toString(),
            "releaseVersion" to Build.VERSION.RELEASE,
            "supportedAbis" to Build.SUPPORTED_ABIS.toList()
        )
    }
}
