package com.example.flutter_showcase

import com.recco.api.model.ReccoConfig
import com.recco.api.ui.ReccoApiUI
import dagger.hilt.android.HiltAndroidApp
import io.flutter.app.FlutterApplication

@HiltAndroidApp
class ShowcaseApp : FlutterApplication() {
    override fun onCreate() {
        super.onCreate()

        ReccoApiUI.init(
            sdkConfig = ReccoConfig(
                appName = "Flutter Android Showcase",
                apiSecret = "yvU5m39iXgVtOOKSQqz8neU5mP5HkOamKKMhcX5FDdBE6s6lmrdkC87XQr5dApi5r-vVOFo",
            ),
            application = this
        )
    }
}
