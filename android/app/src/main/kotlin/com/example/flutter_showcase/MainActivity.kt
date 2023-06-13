package com.example.flutter_showcase

import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.shadowflight.ui.UIApi
import dev.flutter.pigeon.Message
import dev.flutter.pigeon.ShadowflightApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

private const val TAG = "Shadowflight"

private class PigeonApiImplementation(private val context: Context) : ShadowflightApi {
    override fun replyBackTest(text: String): Message {
        return Message(
            title = "Message returned from Android",
            text = text
        )
    }

    override fun openShadowflightSDK(userId: String) {
        UIApi.login(userId = userId)
        UIApi.navigateToFeed(context)
        Log.d(TAG, "Open SDK from Android: userId=$userId")
    }
}

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val api = PigeonApiImplementation(this)
        ShadowflightApi.setUp(flutterEngine.dartExecutor.binaryMessenger, api)
    }
}
