package com.example.pocket_home

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import androidx.core.app.NotificationCompat

class MainActivity : FlutterActivity() {

    private val CHANNEL = "pocket_home/notification"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger!!, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "showNotification") {
                    val title = call.argument<String>("title")
                    val message = call.argument<String>("message")
                    showNotification(title, message)
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun showNotification(title: String?, message: String?) {
        // создаем канал уведомлений если ОС Android Oreo(8,0) и выше
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel("pockethome_push_channel", "PocketHome Push Channel", NotificationManager.IMPORTANCE_HIGH)
            val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }

        val notification = NotificationCompat.Builder(this, "pockethome_push_channel")
            .setContentTitle(title)
            .setContentText(message)
            .setSmallIcon(R.mipmap.launcher_icon)
            .setAutoCancel(true)
            .build()

        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.notify(0, notification)
    }
}
