package com.significo.recco

import android.content.Context
import com.recco.api.ui.ReccoApiUI
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/**
 * ReccoPlugin
 */
class ReccoPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private var context: Context? = null

    /**
     * FlutterPlugin
     */
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "recco")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    /**
     * MethodCallHandler
     */
    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            LOGIN_METHOD -> {
                call.argument<String>(LOGIN_USER_ARG)?.let {
                    executeMethod(error = LOGIN_ERROR, result = result) {
                        ReccoApiUI.login(it)
                    }
                }
            }

            LOGOUT_METHOD -> {
                executeMethod(error = LOGOUT_ERROR, result = result) {
                    ReccoApiUI.logout()
                }
            }

            OPEN_RECCO_METHOD -> {
                executeMethod(error = OPEN_RECCO_ERROR, result = result) {
                    context?.let { ReccoApiUI.navigateToDashboard(it) }
                }
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    /**
     * ActivityAware
     */
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        context = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        context = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        context = binding.activity
    }

    override fun onDetachedFromActivity() {
        context = null
    }


    /**
     * Private
     */
    private fun executeMethod(
        error: String,
        result: Result,
        block: () -> Unit
    ) {
        try {
            block()
            result.success(null)
        } catch (e: Exception) {
            result.error(error, e.localizedMessage ?: DEFAULT_ERROR, e)
        }
    }

    companion object {
        private const val LOGIN_METHOD = "login"
        private const val LOGIN_USER_ARG = "userId"
        private const val LOGIN_ERROR = "loginError"

        private const val LOGOUT_METHOD = "logout"
        private const val LOGOUT_ERROR = "logoutError"

        private const val OPEN_RECCO_METHOD = "openReccoUI"
        private const val OPEN_RECCO_ERROR = "openReccoUIError"

        private const val DEFAULT_ERROR = "Error"
    }
}
