import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobHelper {
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  final int maxAttempts = 3;

  void loadAds(AdRequest request) {
    InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-7979941646606286/7055661269'
          : 'ca-app-pub-3940256099942544/4411468910',
      request: request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd?.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxAttempts) {
            loadAds(request);
          }
        },
      ),
    );
  }

  void showAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          print('Ad dismissed');
          ad.dispose();
          loadAds(const AdRequest()); // Reload the ad after dismissal
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          print('Ad failed to show: $error');
          ad.dispose();
          loadAds(const AdRequest());
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null;
    } else {
      loadAds(const AdRequest());
      print('Ad not ready');
    }
  }
}
