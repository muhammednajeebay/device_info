package com.example.device_info.channels

import android.content.Context
import android.os.Environment
import android.os.StatFs
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class StorageChannel(private val context: Context) {
    
    fun setupMethodChannel(channel: MethodChannel) {
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getStorageInfo" -> {
                    try {
                        val storageInfo = getStorageInfo()
                        result.success(storageInfo)
                    } catch (e: Exception) {
                        result.error("STORAGE_ERROR", e.message, null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
    
    private fun getStorageInfo(): Map<String, Any?> {
        val internalPath = Environment.getDataDirectory()
        val internalStat = StatFs(internalPath.path)
        
        val internalBlockSize = internalStat.blockSizeLong
        val internalTotalBlocks = internalStat.blockCountLong
        val internalAvailableBlocks = internalStat.availableBlocksLong
        
        val internalTotal = internalTotalBlocks * internalBlockSize
        val internalFree = internalAvailableBlocks * internalBlockSize
        val internalUsed = internalTotal - internalFree
        
        // External storage
        val externalState = Environment.getExternalStorageState()
        val hasExternal = externalState == Environment.MEDIA_MOUNTED
        
        var externalTotal: Long? = null
        var externalFree: Long? = null
        var externalUsed: Long? = null
        
        if (hasExternal) {
            try {
                val externalPath = Environment.getExternalStorageDirectory()
                val externalStat = StatFs(externalPath.path)
                
                val externalBlockSize = externalStat.blockSizeLong
                val externalTotalBlocks = externalStat.blockCountLong
                val externalAvailableBlocks = externalStat.availableBlocksLong
                
                externalTotal = externalTotalBlocks * externalBlockSize
                externalFree = externalAvailableBlocks * externalBlockSize
                externalUsed = externalTotal - externalFree
            } catch (e: Exception) {
                // External storage not available
            }
        }
        
        return mapOf(
            "totalSpace" to internalTotal,
            "freeSpace" to internalFree,
            "usedSpace" to internalUsed,
            "externalTotalSpace" to externalTotal,
            "externalFreeSpace" to externalFree,
            "externalUsedSpace" to externalUsed,
            "hasExternalStorage" to hasExternal
        )
    }
}
