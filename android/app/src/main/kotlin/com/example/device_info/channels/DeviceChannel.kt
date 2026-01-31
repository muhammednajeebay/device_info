package com.example.device_info.channels

import android.content.Context
import android.os.Build
import android.provider.Settings
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class DeviceChannel(private val context: Context) {
    
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
