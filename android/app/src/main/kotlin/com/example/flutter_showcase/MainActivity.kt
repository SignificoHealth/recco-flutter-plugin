package com.example.flutter_showcase

import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.shadowflight.ui.UIApi
import dev.flutter.pigeon.ShadowflightApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

private const val TAG = "Shadowflight Android"

private class PigeonApiImplementation(private val context: Context) : ShadowflightApi {

    override fun login(userId: String) {
        UIApi.login(userId = userId)
        Log.d(TAG, "Login into the SDK: userId=$userId")
    }

    override fun logout() {
        UIApi.logout()
        Log.d(TAG, "Logout from the SDK")
    }

    override fun navigateToDashboard() {
        UIApi.navigateToDashboard(context)
        Log.d(TAG, "Navigate to the SDK Dashboard")
    }
}

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val api = PigeonApiImplementation(this)
        ShadowflightApi.setUp(flutterEngine.dartExecutor.binaryMessenger, api)
    }
}
