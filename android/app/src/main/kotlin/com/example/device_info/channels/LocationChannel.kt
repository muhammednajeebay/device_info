package com.example.device_info.channels

import android.Manifest
import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.os.Build
import android.os.Bundle
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.plugin.common.MethodChannel

/**
 * LocationChannel: Handles geographic location fetching and permission management.
 * 
 * Usage:
 * - MethodChannel: Triggered on user request or map view initialization.
 */
class LocationChannel(private val activity: Activity) {
    private val locationManager = activity.getSystemService(Context.LOCATION_SERVICE) as LocationManager
    private val REQ_LOCATION = 1001

    /**
     * Set up the MethodChannel handler for "getCurrentLocation".
     */
    fun setupMethodChannel(channel: MethodChannel) {
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getCurrentLocation" -> {
                    handleLocationRequest(result)
                }
                else -> result.notImplemented()
            }
        }
    }

    /**
     * Orchestrates the location request: checks permissions, looks for last known location,
     * or requests a fresh update if needed.
     */
    private fun handleLocationRequest(result: MethodChannel.Result) {
        if (!hasPermissions()) {
            requestPermissions()
            result.error("PERMISSION_DENIED", "Location permissions not granted. Requesting now.", null)
            return
        }

        try {
            // Optimization: Try to get the last known location quickly
            val lastKnown = getCurrentLocationFromLastKnown()
            if (lastKnown != null) {
                result.success(lastKnown)
            } else {
                // If no last known, trigger a fresh GPS/Network scan
                requestFreshLocation(result)
            }
        } catch (e: Exception) {
            result.error("LOCATION_ERROR", e.message, null)
        }
    }

    /** Checks if the app has GPS or Network location permissions. */
    private fun hasPermissions(): Boolean {
        return ContextCompat.checkSelfPermission(activity, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED ||
               ContextCompat.checkSelfPermission(activity, Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED
    }

    /** Prompts the user for location permissions at runtime. */
    private fun requestPermissions() {
        ActivityCompat.requestPermissions(
            activity,
            arrayOf(Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION),
            REQ_LOCATION
        )
    }

    /** Attempts to get the last cached location from any available provider (GPS, Network). */
    @SuppressLint("MissingPermission")
    private fun getCurrentLocationFromLastKnown(): Map<String, Any?>? {
        val providers = locationManager.getProviders(true)
        var bestLocation: Location? = null
        
        for (provider in providers) {
            val l = locationManager.getLastKnownLocation(provider) ?: continue
            // Use the most accurate location available
            if (bestLocation == null || l.accuracy < bestLocation!!.accuracy) {
                bestLocation = l
            }
        }

        return bestLocation?.let { locationToMap(it) }
    }

    /** 
     * Requests a single high-accuracy location update from the OS. 
     * Triggered when last known location is unavailable.
     */
    @SuppressLint("MissingPermission")
    private fun requestFreshLocation(result: MethodChannel.Result) {
        val provider = if (locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
            LocationManager.GPS_PROVIDER
        } else if (locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER)) {
            LocationManager.NETWORK_PROVIDER
        } else {
            null
        }

        if (provider == null) {
            result.success(emptyMap<String, Any?>())
            return
        }

        val listener = object : LocationListener {
            override fun onLocationChanged(location: Location) {
                locationManager.removeUpdates(this) // Unsubscribe once we get a result
                result.success(locationToMap(location))
            }
            @Deprecated("Deprecated in Java")
            override fun onStatusChanged(provider: String?, status: Int, extras: Bundle?) {}
            override fun onProviderEnabled(provider: String) {}
            override fun onProviderDisabled(provider: String) {}
        }

        locationManager.requestSingleUpdate(provider, listener, null)
    }

    /**
     * Converts an Android Location object to a Dart-friendly Map.
     * 
     * Output (Map returned to Flutter):
     * - "latitude": Double
     * - "longitude": Double
     * - "altitude": Double
     * - "accuracy": Float (meters)
     * - "speed": Float (m/s)
     * - "heading": Double (bearing in degrees)
     * - "provider": String ("gps", "network")
     * - "isMock": Boolean (If location is spoofed)
     */
    private fun locationToMap(location: Location): Map<String, Any?> {
        return mapOf(
            "latitude" to location.latitude,
            "longitude" to location.longitude,
            "altitude" to location.altitude,
            "accuracy" to location.accuracy,
            "speed" to location.speed,
            "heading" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) location.bearing else 0.0,
            "provider" to location.provider,
            "isMock" to if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) location.isMock else location.isFromMockProvider
        )
    }
}
