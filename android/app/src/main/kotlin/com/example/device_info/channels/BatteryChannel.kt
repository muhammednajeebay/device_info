package com.example.device_info.channels

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * BatteryChannel: Handles communication between Flutter and Android for battery-related data.
 * 
 * Usage:
 * - MethodChannel: Used for one-time battery info requests (e.g., initial app load).
 * - EventChannel: Used for real-time streaming of battery status changes.
 */
class BatteryChannel(private val context: Context) {
    
    /**
     * Set up the MethodChannel handler to respond to "getBatteryInfo" calls from Flutter.
     */
    fun setupMethodChannel(channel: MethodChannel) {
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getBatteryInfo" -> {
                    try {
                        val batteryInfo = getBatteryInfo()
                        result.success(batteryInfo)
                    } catch (e: Exception) {
                        result.error("BATTERY_ERROR", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
    
    /**
     * Set up the EventChannel stream handler for continuous battery updates.
     * Triggered by: Android System (ACTION_BATTERY_CHANGED broadcast).
     */
    fun setupEventChannel(channel: EventChannel) {
        channel.setStreamHandler(object : EventChannel.StreamHandler {
            private var batteryReceiver: BroadcastReceiver? = null
            
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                // Initialize receiver to catch system battery broadcasts
                batteryReceiver = object : BroadcastReceiver() {
                    override fun onReceive(context: Context?, intent: Intent?) {
                        // Fetch the latest info and push it to Flutter's stream
                        val batteryInfo = getBatteryInfo()
                        events?.success(batteryInfo)
                    }
                }
                
                // Register the receiver with the system
                context.registerReceiver(
                    batteryReceiver,
                    IntentFilter(Intent.ACTION_BATTERY_CHANGED)
                )
            }
            
            override fun onCancel(arguments: Any?) {
                // Clean up: unregister receiver when Flutter stops listening
                batteryReceiver?.let {
                    context.unregisterReceiver(it)
                }
                batteryReceiver = null
            }
        })
    }
    
    /**
     * Core logic to extract battery data from the system intent.
     * 
     * Output (Map returned to Flutter):
     * - "level": Int (Battery percentage 0-100)
     * - "status": String ("Charging", "Discharging", "Full", etc.)
     * - "pluggedStatus": String ("AC", "USB", "Wireless", "Not Plugged")
     * - "health": String ("Good", "Overheat", "Dead", etc.)
     * - "technology": String? (e.g., "Li-ion")
     * - "voltage": Int? (mV)
     * - "temperature": Int? (1/10th of degree C)
     * - "isPresent": Boolean (Whether battery is physically present)
     */
    private fun getBatteryInfo(): Map<String, Any?> {
        val batteryIntent = context.registerReceiver(
            null,
            IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        )
        
        // Calculate percentage
        val level = batteryIntent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
        val scale = batteryIntent?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1
        val batteryPct = if (level >= 0 && scale > 0) {
            (level * 100 / scale.toFloat()).toInt()
        } else {
            0
        }
        
        // Determine charging status
        val status = batteryIntent?.getIntExtra(BatteryManager.EXTRA_STATUS, -1) ?: -1
        val statusString = when (status) {
            BatteryManager.BATTERY_STATUS_CHARGING -> "Charging"
            BatteryManager.BATTERY_STATUS_DISCHARGING -> "Discharging"
            BatteryManager.BATTERY_STATUS_FULL -> "Full"
            BatteryManager.BATTERY_STATUS_NOT_CHARGING -> "Not Charging"
            else -> "Unknown"
        }
        
        // Determine power source
        val plugged = batteryIntent?.getIntExtra(BatteryManager.EXTRA_PLUGGED, -1) ?: -1
        val pluggedString = when (plugged) {
            BatteryManager.BATTERY_PLUGGED_AC -> "AC"
            BatteryManager.BATTERY_PLUGGED_USB -> "USB"
            BatteryManager.BATTERY_PLUGGED_WIRELESS -> "Wireless"
            else -> "Not Plugged"
        }
        
        // Determine health status
        val health = batteryIntent?.getIntExtra(BatteryManager.EXTRA_HEALTH, -1) ?: -1
        val healthString = when (health) {
            BatteryManager.BATTERY_HEALTH_GOOD -> "Good"
            BatteryManager.BATTERY_HEALTH_OVERHEAT -> "Overheat"
            BatteryManager.BATTERY_HEALTH_DEAD -> "Dead"
            BatteryManager.BATTERY_HEALTH_OVER_VOLTAGE -> "Over Voltage"
            BatteryManager.BATTERY_HEALTH_COLD -> "Cold"
            else -> "Unknown"
        }
        
        val technology = batteryIntent?.getStringExtra(BatteryManager.EXTRA_TECHNOLOGY)
        val voltage = batteryIntent?.getIntExtra(BatteryManager.EXTRA_VOLTAGE, -1)
        val temperature = batteryIntent?.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, -1)
        val present = batteryIntent?.getBooleanExtra(BatteryManager.EXTRA_PRESENT, false)
        
        return mapOf(
            "level" to batteryPct,
            "status" to statusString,
            "pluggedStatus" to pluggedString,
            "health" to healthString,
            "technology" to technology,
            "voltage" to voltage,
            "temperature" to temperature,
            "isPresent" to present
        )
    }
}
