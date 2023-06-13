package com.example.flutter_showcase

import com.shadowflight.core.model.SDKConfig
import com.shadowflight.ui.UIApi
import dagger.hilt.android.HiltAndroidApp
import io.flutter.app.FlutterApplication

@HiltAndroidApp
class ShowcaseApp : FlutterApplication() {
    override fun onCreate() {
        super.onCreate()

        UIApi.init(
            sdkConfig = SDKConfig(
                appName = "Showcase",
                apiSecret = "YuJi02IHzJDxe-oiqT1QOptnh9mGMnulPPx5C3xoyBSe0dNha-m1qOjG9DopeSspqR9d6-Y",
                isDebug = false
            ),
            application = this
        )
    }
}
