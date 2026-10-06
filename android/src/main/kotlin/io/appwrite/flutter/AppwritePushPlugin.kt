package io.appwrite.flutter

import android.os.Handler
import android.os.Looper
import io.appwrite.services.PushBridge
import io.appwrite.services.PushMessage
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * The Flutter side of [PushBridge]: the SDK's `Push` hosts its background subscriptions here on
 * Android over a method channel, and receives their messages and errors over an event channel.
 */
class AppwritePushPlugin :
    FlutterPlugin,
    MethodChannel.MethodCallHandler,
    EventChannel.StreamHandler {
    private val main = Handler(Looper.getMainLooper())
    private var methods: MethodChannel? = null
    private var events: EventChannel? = null
    private var sink: EventChannel.EventSink? = null
    private var bridge: PushBridge? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        bridge = PushBridge(
            binding.applicationContext,
            object : PushBridge.Events {
                override fun onMessage(subscriptionId: String, message: PushMessage, ackToken: String) = send(
                    mapOf(
                        "type" to "message",
                        "id" to subscriptionId,
                        "topic" to message.topic,
                        "payload" to message.payload,
                        "qos" to message.qos,
                        "ackToken" to ackToken,
                    ),
                )

                override fun onError(message: String) = send(mapOf("type" to "error", "message" to message))
            },
        )
        methods = MethodChannel(binding.binaryMessenger, METHOD_CHANNEL).also { it.setMethodCallHandler(this) }
        events = EventChannel(binding.binaryMessenger, EVENT_CHANNEL).also { it.setStreamHandler(this) }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methods?.setMethodCallHandler(null)
        events?.setStreamHandler(null)
        methods = null
        events = null
        sink = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val bridge = bridge ?: return result.error(ERROR_CODE, "Push plugin is not attached", null)
        try {
            if (call.method == "host") {
                // Replies once the connection is up and every filter is subscribed, or with why not.
                bridge.host(call.argument<String>("config")!!, call.argument<String>("subscriptions")!!) { error ->
                    main.post {
                        if (error == null) {
                            result.success(null)
                        } else {
                            result.error(ERROR_CODE, error, null)
                        }
                    }
                }
                return
            }
            result.success(
                when (call.method) {
                    "ack" -> bridge.ack(call.argument<String>("token")!!).let { null }
                    "release" -> bridge.release().let { null }
                    "stop" -> bridge.stop().let { null }
                    "setForeground" -> bridge.setForeground(call.argument<Boolean>("enabled") == true).let { null }
                    "hasSaved" -> bridge.hasSaved()
                    "resume" -> bridge.resume().let { null }
                    "setErrorCallback" -> bridge.setErrorCallback(call.argument<Boolean>("registered") == true)
                    "defaultClientId" -> bridge.defaultClientId(call.argument<String>("authMethod")!!, call.argument<String>("credential")!!)
                    else -> return result.notImplemented()
                },
            )
        } catch (e: Exception) {
            result.error(ERROR_CODE, e.message, null)
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events
    }

    override fun onCancel(arguments: Any?) {
        sink = null
    }

    // The bridge calls back on background threads; event sinks must be used on the main thread.
    private fun send(event: Map<String, Any?>) {
        main.post { sink?.success(event) }
    }

    private companion object {
        const val METHOD_CHANNEL = "appwrite.push"
        const val EVENT_CHANNEL = "appwrite.push/events"
        const val ERROR_CODE = "appwrite_push"
    }
}
