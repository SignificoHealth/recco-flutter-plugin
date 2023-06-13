package com.example.flutter_showcase

import android.content.Context
import android.content.Intent
import android.os.Build.VERSION.SDK
import android.util.Log
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat.startActivity
import com.shadowflight.ui.UIApi
import dev.flutter.pigeon.Book
import dev.flutter.pigeon.BookApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

private const val TAG = "Shadowflight"

private class PigeonApiImplementation(private val context: Context) : BookApi {
    override fun search(keyword: String): List<Book> {
        val result = Book(
            title = "Message returned from Android",
            author = keyword
        )
        return listOf(result)
    }

    override fun openShadowflightUI(userId: String) {
        UIApi.login(userId = userId)
        UIApi.navigateToFeed(context)
        Log.d(TAG, "Open SDK from Android: userId=$userId")
    }
}

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val api = PigeonApiImplementation(this)
        BookApi.setUp(flutterEngine.dartExecutor.binaryMessenger, api)
    }
}
