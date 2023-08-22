package com.significo.recco

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.mockito.Mockito
import kotlin.test.Test

internal class ReccoPluginTest {
    private val plugin = ReccoPlugin()
    private val mockResult: MethodChannel.Result = Mockito.mock(MethodChannel.Result::class.java)

    @Test
    fun onMethodCall_login_onError() {
        val call = MethodCall("login", mapOf("userId" to "myUser"))

        plugin.onMethodCall(call, mockResult)

        Mockito.verify(mockResult).error(Mockito.any(), Mockito.any(), Mockito.any())
    }

    @Test
    fun onMethodCall_logout_onError() {
        val call = MethodCall("logout", null)

        plugin.onMethodCall(call, mockResult)

        Mockito.verify(mockResult).error(Mockito.any(), Mockito.any(), Mockito.any())
    }

    @Test
    fun onMethodCall_openRecco_onSuccess() {
        val call = MethodCall("openReccoUI", null)

        plugin.onMethodCall(call, mockResult)

        Mockito.verify(mockResult).success(null)
    }
}
