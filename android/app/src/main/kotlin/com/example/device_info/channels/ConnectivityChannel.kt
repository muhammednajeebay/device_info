package com.example.device_info.channels

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.net.wifi.WifiManager
import android.os.Build
import io.flutter.plugin.common.MethodChannel
import java.net.InetAddress
import java.net.NetworkInterface
import java.util.Collections

/**
 * ConnectivityChannel: Manages network connectivity data and IP address retrieval.
 * 
 * Usage:
 * - MethodChannel: Triggered when Flutter requests the current network state.
 */
class ConnectivityChannel(private val context: Context) {

    /**
     * Set up the MethodChannel handler to respond to "getConnectivityInfo" calls from Flutter.
     */
    fun setupMethodChannel(channel: MethodChannel) {
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getConnectivityInfo" -> {
                    try {
                        val info = getConnectivityInfo()
                        result.success(info)
                    } catch (e: Exception) {
                        result.error("CONNECTIVITY_ERROR", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    /**
     * Extracts structured connectivity data using Android's ConnectivityManager.
     * 
     * Output (Map returned to Flutter):
     * - "isConnected": Boolean (True if any network is active)
     * - "type": String ("wifi", "mobile", "ethernet", "none", "unknown")
     * - "ipAddress": String? (Current IPv4 address)
     * - "wifiSsid": String? (SSID if connected to Wi-Fi)
     */
    private fun getConnectivityInfo(): Map<String, Any?> {
        val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val network = connectivityManager.activeNetwork
        val capabilities = connectivityManager.getNetworkCapabilities(network)

        // Determine if connected to a valid transport
        val isConnected = capabilities != null && (
                capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) ||
                        capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) ||
                        capabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET)
                )

        // Identify the type of connection
        val type = when {
            capabilities == null -> "none"
            capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> "wifi"
            capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> "mobile"
            capabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) -> "ethernet"
            else -> "unknown"
        }

        val ipAddress = getIPAddress(true)

        // Fetch Wi-Fi specific SSID if applicable
        var wifiSsid: String? = null
        if (type == "wifi") {
            val wifiManager = context.applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
            val wifiInfo = wifiManager.connectionInfo
            wifiSsid = wifiInfo.ssid.removeSurrounding("\"")
            if (wifiSsid == "<unknown ssid>") wifiSsid = null
        }

        return mapOf(
            "isConnected" to isConnected,
            "type" to type,
            "ipAddress" to ipAddress,
            "wifiSsid" to wifiSsid
        )
    }

    /**
     * Scans network interfaces to find the current IP address.
     * @param useIPv4: True to prioritize IPv4.
     * Output: String IP address (e.g., "192.168.1.5").
     */
    private fun getIPAddress(useIPv4: Boolean): String? {
        try {
            val interfaces = Collections.list(NetworkInterface.getNetworkInterfaces())
            for (intf in interfaces) {
                val addrs = Collections.list(intf.inetAddresses)
                for (addr in addrs) {
                    if (!addr.isLoopbackAddress) {
                        val sAddr = addr.hostAddress
                        val isIPv4 = sAddr.indexOf(':') < 0
                        if (useIPv4) {
                            if (isIPv4) return sAddr
                        } else {
                            if (!isIPv4) {
                                val delim = sAddr.indexOf('%') // drop ip6 zone suffix
                                return if (delim < 0) sAddr.uppercase() else sAddr.substring(0, delim).uppercase()
                            }
                        }
                    }
                }
            }
        } catch (ignored: Exception) {
        }
        return null
    }
}
