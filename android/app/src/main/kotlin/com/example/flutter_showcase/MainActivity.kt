package com.example.flutter_showcase

import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.recco.api.ui.ReccoApiUI
import dev.flutter.pigeon.ReccoApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

private const val TAG = "Recco Android"

private class PigeonApiImplementation(private val context: Context) : ReccoApi {

    override fun login(userId: String) {
        ReccoApiUI.login(userId = userId)
        Log.d(TAG, "Login into the SDK: userId=$userId")
    }

    override fun logout() {
        ReccoApiUI.logout()
        Log.d(TAG, "Logout from the SDK")
    }

    override fun navigateToDashboard() {
        ReccoApiUI.navigateToDashboard(context)
        Log.d(TAG, "Navigate to the SDK Dashboard")
    }
}

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val api = PigeonApiImplementation(this)
        ReccoApi.setUp(flutterEngine.dartExecutor.binaryMessenger, api)
    }
}
