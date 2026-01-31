package com.example.device_info.channels

import android.app.ActivityManager
import android.content.Context
import android.os.Build
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.RandomAccessFile

class SystemChannel(private val context: Context) {
    
    fun setupMethodChannel(channel: MethodChannel) {
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getSystemInfo" -> {
                    try {
                        val systemInfo = getSystemInfo()
                        result.success(systemInfo)
                    } catch (e: Exception) {
                        result.error("SYSTEM_ERROR", e.message, null)
                    }
                }
                "getCpuInfo" -> {
                    try {
                        val cpuInfo = getCpuInfo()
                        result.success(cpuInfo)
                    } catch (e: Exception) {
                        result.error("CPU_ERROR", e.message, null)
                    }
                }
                "getMemoryInfo" -> {
                    try {
                        val memoryInfo = getMemoryInfo()
                        result.success(memoryInfo)
                    } catch (e: Exception) {
                        result.error("MEMORY_ERROR", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
    
    private fun getSystemInfo(): Map<String, Any?> {
        val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        val memoryInfo = ActivityManager.MemoryInfo()
        activityManager.getMemoryInfo(memoryInfo)
        
        val displayMetrics = context.resources.displayMetrics
        val screenResolution = "${displayMetrics.widthPixels}x${displayMetrics.heightPixels}"
        val screenDensity = displayMetrics.density.toDouble()
        
        return mapOf(
            "cpuCores" to Runtime.getRuntime().availableProcessors(),
            "cpuArchitecture" to Build.SUPPORTED_ABIS[0],
            "totalRam" to memoryInfo.totalMem,
            "availableRam" to memoryInfo.availMem,
            "screenResolution" to screenResolution,
            "screenDensity" to screenDensity
        )
    }
    
    private fun getCpuInfo(): Map<String, Any?> {
        val cores = Runtime.getRuntime().availableProcessors()
        val architecture = Build.SUPPORTED_ABIS[0]
        
        return mapOf(
            "cpuCores" to cores,
            "cpuArchitecture" to architecture
        )
    }
    
    private fun getMemoryInfo(): Map<String, Any?> {
        val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        val memoryInfo = ActivityManager.MemoryInfo()
        activityManager.getMemoryInfo(memoryInfo)
        
        return mapOf(
            "totalRam" to memoryInfo.totalMem,
            "availableRam" to memoryInfo.availMem,
            "freeRam" to memoryInfo.availMem,
            "lowMemory" to memoryInfo.lowMemory
        )
    }
}
