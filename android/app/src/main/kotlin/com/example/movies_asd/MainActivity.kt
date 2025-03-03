package com.example.movies_asd

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.movies_asd/share"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "share") {
                val title = call.argument<String>("title") ?: "Movie Title!"
                val text = "I recommend you the movie: $title"
                val imagePath = call.argument<String>("imagePath")

                if (imagePath != null) {
                    shareMovie(text, imagePath)
                    result.success("Shared successfully")
                } else {
                    result.error("UNAVAILABLE", "Image path is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun shareMovie(text: String, imagePath: String) {
        val file = File(imagePath)
        val uri: Uri = FileProvider.getUriForFile(this, "${applicationContext.packageName}.provider", file)

        val shareIntent = Intent(Intent.ACTION_SEND).apply {
            type = "image/*"
            putExtra(Intent.EXTRA_SUBJECT, "Check out this movie!")
            putExtra(Intent.EXTRA_TEXT, text) 
            putExtra(Intent.EXTRA_STREAM, uri)
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION) 
        }

        // Grant URI permission to all apps that can handle the intent
        val resInfoList = packageManager.queryIntentActivities(shareIntent, 0)
        for (resolveInfo in resInfoList) {
            val packageName = resolveInfo.activityInfo.packageName
            grantUriPermission(packageName, uri, Intent.FLAG_GRANT_READ_URI_PERMISSION)
        }

        startActivity(Intent.createChooser(shareIntent, "Share via"))
    }
}
