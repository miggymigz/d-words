package com.example.chinese_words;

import com.microsoft.appcenter.AppCenter;
import com.microsoft.appcenter.analytics.Analytics;
import com.microsoft.appcenter.crashes.Crashes;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    AppCenter.start(getApplication(), "eaee694a-dc40-4073-a33b-75c84a2342ab", Analytics.class, Crashes.class);

    GeneratedPluginRegistrant.registerWith(this);
  }
}
