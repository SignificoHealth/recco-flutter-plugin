package com.example.flutter_showcase

import androidx.annotation.NonNull
import com.shadowflight.ui.UIApi
import dev.flutter.pigeon.Book
import dev.flutter.pigeon.BookApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

private class PigeonApiImplementation : BookApi {
    override fun search(keyword: String): List<Book> {
        val result = Book(
            title = String.format("%s's Book", keyword),
            author = keyword
        )
        return listOf(result)
    }
}

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val api = PigeonApiImplementation()
        BookApi.setUp(flutterEngine.dartExecutor.binaryMessenger, api)

        UIApi.login(userId = "1")
        UIApi.navigateToFeed(this)
    }
}
