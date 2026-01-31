package com.example.device_info.channels

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorManager
import io.flutter.plugin.common.MethodChannel

class SensorsChannel(private val context: Context) {

    fun setupMethodChannel(channel: MethodChannel) {
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getAvailableSensors" -> {
                    try {
                        val sensors = getAvailableSensors()
                        result.success(sensors)
                    } catch (e: Exception) {
                        result.error("SENSORS_ERROR", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getAvailableSensors(): Map<String, Any?> {
        val sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
        val sensorList = sensorManager.getSensorList(Sensor.TYPE_ALL)

        val sensors = sensorList.map { sensor ->
            mapOf(
                "name" to sensor.name,
                "type" to getSensorTypeString(sensor.type),
                "vendor" to sensor.vendor,
                "version" to sensor.version,
                "power" to sensor.power,
                "resolution" to sensor.resolution,
                "maximumRange" to sensor.maximumRange
            )
        }

        return mapOf(
            "availableSensors" to sensors
        )
    }

    private fun getSensorTypeString(type: Int): String {
        return when (type) {
            Sensor.TYPE_ACCELEROMETER -> "Accelerometer"
            Sensor.TYPE_GYROSCOPE -> "Gyroscope"
            Sensor.TYPE_LIGHT -> "Light"
            Sensor.TYPE_MAGNETIC_FIELD -> "Magnetic Field"
            Sensor.TYPE_PROXIMITY -> "Proximity"
            Sensor.TYPE_PRESSURE -> "Pressure"
            Sensor.TYPE_RELATIVE_HUMIDITY -> "Humidity"
            Sensor.TYPE_AMBIENT_TEMPERATURE -> "Temperature"
            Sensor.TYPE_GRAVITY -> "Gravity"
            Sensor.TYPE_LINEAR_ACCELERATION -> "Linear Acceleration"
            Sensor.TYPE_ROTATION_VECTOR -> "Rotation Vector"
            Sensor.TYPE_STEP_COUNTER -> "Step Counter"
            Sensor.TYPE_STEP_DETECTOR -> "Step Detector"
            Sensor.TYPE_HEART_RATE -> "Heart Rate"
            else -> "Unknown ($type)"
        }
    }
}
