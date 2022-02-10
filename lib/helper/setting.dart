import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:ebooks/helper/colors_res.dart';
import 'package:ebooks/helper/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_options.dart';

class Setting {
  static late String data, html_privacy, html_condition;
  static late int opsi_ad;
  static late String iosNativeFacebook, iosInterstitialFacebook, androidNativeFacebook, androidInterstitialFacebook;
  static late String iosNativeAdmob, iosInterstitialAdmob, androidNativeAdmob, androidInterstitialAdmob;
  static late AdmobInterstitial _interstitialAd;
  static late int interstitialInterval, nativeInterval;
  static bool adReady = false;
  static int ix = 1;

  Setting.getConfigure(Config configure) {
    iosInterstitialAdmob = configure.ios_interstitial_admob;
    iosNativeAdmob = configure.ios_native_admob;
    androidInterstitialAdmob = configure.android_interstitial_admob;
    androidNativeAdmob = configure.android_native_admob;

    interstitialInterval = configure.interstitial_interval;
    nativeInterval = configure.list_native_interval;

    html_privacy = configure.html_privacy;
    html_condition = configure.html_condition;

    opsi_ad = configure.opsi_ad;
    data = configure.data;
  }

  //========= Setting Admob =========//

  static NativeAdmob createNativeAdmob() {
    return NativeAdmob(
      adUnitID: (Platform.isIOS)
          ? iosNativeAdmob
          : androidNativeAdmob,
      loading: Center(
        child: Text('loading...'),
      ),
      type: NativeAdmobType.full,
      options: NativeAdmobOptions(
        ratingColor: ColorsRes.appColor,
        showMediaContent: true,
        headlineTextStyle: NativeTextStyle(
          color: ColorsRes.textcolor,
        )
      ),
    );
  }

  static createInterstitialAdmob() {
    _interstitialAd = AdmobInterstitial(
      adUnitId: (Platform.isIOS)
          ? iosInterstitialAdmob
          : androidInterstitialAdmob,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        print("Ads Created admob");
        switch (event) {
          case AdmobAdEvent.loaded:
            print("yay ad getLoaded");
            adReady = true;
            break;

          case AdmobAdEvent.closed:
            _interstitialAd.dispose();
            createInterstitialAdmob();
            break;

          case AdmobAdEvent.leftApplication:
            _interstitialAd.dispose();
            break;

          default:
        }
      }
    );
    _interstitialAd.load();
  }

  static showInterstitial() {
    // Normal
    // if (adReady == true) {
    //   print('interstitial show');
    //   _interstitialAd.show();
    // }

    //Interval Interstitial
    if (ix == interstitialInterval) {
      if (adReady == true) {
        _interstitialAd.show();
        ix = 0;
      }
    } else {
      ix += 1;
      print('interval = $ix');
    }
  }
}