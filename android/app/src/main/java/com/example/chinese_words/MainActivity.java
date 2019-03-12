package com.example.chinese_words;

import android.os.Bundle;

import com.microsoft.appcenter.AppCenter;
import com.microsoft.appcenter.analytics.Analytics;
import com.microsoft.appcenter.crashes.Crashes;

import java.util.Map;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String ANALYTICS_EVENTS_CHANNEL = "com.example.chinese_words/events";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    GeneratedPluginRegistrant.registerWith(this);
    AppCenter.start(getApplication(), "eaee694a-dc40-4073-a33b-75c84a2342ab", Analytics.class, Crashes.class);

    registerAnalyticsMethodChannel();
  }

  private void registerAnalyticsMethodChannel() {
    new MethodChannel(getFlutterView(), ANALYTICS_EVENTS_CHANNEL).setMethodCallHandler(
            (call, result) -> {
                if (call.method.equals("trackEvent")) {
                    Map<String, String> props = call.arguments();
                    String eventName = props.remove("eventName");
                    Analytics.trackEvent(eventName, props);
                } else {
                    result.notImplemented();
                }
            });
  }
}
