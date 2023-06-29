package com.example.flutter_showcase

import com.recco.api.model.SDKConfig
import com.recco.api.ui.ReccoApiUI
import dagger.hilt.android.HiltAndroidApp
import io.flutter.app.FlutterApplication

@HiltAndroidApp
class ShowcaseApp : FlutterApplication() {
    override fun onCreate() {
        super.onCreate()

        ReccoApiUI.init(
            sdkConfig = SDKConfig(
                appName = "Flutter Android Showcase",
                apiSecret = "YuJi02IHzJDxe-oiqT1QOptnh9mGMnulPPx5C3xoyBSe0dNha-m1qOjG9DopeSspqR9d6-Y",
            ),
            application = this
        )
    }
}
