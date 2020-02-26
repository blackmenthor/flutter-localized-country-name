package com.mozio.flutter_localized_country_name

import android.util.Log
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.util.*

/** FlutterLocalizedCountryNamePlugin */
public class FlutterLocalizedCountryNamePlugin(private val registrar: Registrar? = null): FlutterPlugin, MethodCallHandler {
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), Constants.CHANNEL_NAME)
    channel.setMethodCallHandler(FlutterLocalizedCountryNamePlugin());
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      registrar.context().resources.configuration.locale
      val channel = MethodChannel(registrar.messenger(), Constants.CHANNEL_NAME)
      channel.setMethodCallHandler(FlutterLocalizedCountryNamePlugin())
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == Constants.METHOD_LOCALIZED_COUNTRY_NAME) {
      getCountryCode(call, result)
    } else {
      result.notImplemented()
    }
  }

  private fun getCountryCode(@NonNull call: MethodCall, @NonNull result: Result) {
    val countryCode = call.argument<String>(Constants.ARGUMENT_COUNTRY_CODE)
    if (countryCode == null) result.error("0", "Country code is null, cannot proceed", "")

    val forcedLocale = call.argument<String>(Constants.ARGUMENT_LOCALE)

    // basically change the name of the country to localized version if possible
    val locale = if (forcedLocale != null) {
      Locale(forcedLocale)
    } else {
      Locale("")
    }
    result.success(Locale("", countryCode).getDisplayCountry(locale))
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
  }
}
