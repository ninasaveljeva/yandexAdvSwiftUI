//
//  AdvertsView.swift
//  giphyApp
//
//  Created by Nina Saveljeva on 1/7/2024.
//

import SwiftUI
import YandexMobileAds


struct AdvertView: UIViewControllerRepresentable {
    typealias UIViewControllerType = InlineBannerViewController
    
    func makeUIViewController(context: Context) -> InlineBannerViewController {
        let vc = InlineBannerViewController()
        return vc
    }

    func updateUIViewController(_ uiViewController: InlineBannerViewController, context: Context) {
        
    }
}

final class InlineBannerViewController: UIViewController {
    
    func getAdView(width: Float, height: Float) -> AdView {
        let adSize = BannerAdSize.inlineSize(withWidth: CGFloat(width), maxHeight: CGFloat(height))
        let adView = AdView(adUnitID: "demo-banner-yandex", adSize: adSize)
        adView.delegate = self
        adView.translatesAutoresizingMaskIntoConstraints = false
        return adView
    }
    
    func loadBannerAdFor(view: AdView) {
        DispatchQueue.global(qos: .background).async {
            view.loadAd()
        }
    }
    
//    private lazy var adView: AdView = {
//        let adSize = BannerAdSize.inlineSize(withWidth: self.view.frame.size.width - 20, maxHeight: CGFloat(AppConfiguration.kYANDEX_BANNER_HEIGHT))
//
//        let adView = AdView(adUnitID: AppConfiguration.kYANDEX_BANNER_UNIT_ID, adSize: adSize)
//        adView.delegate = self
//        adView.translatesAutoresizingMaskIntoConstraints = false
//        return adView
//    }()

    var adView: AdView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.adView = getAdView(width: Float(self.view.frame.size.width) - 20, height: 80)
        self.loadAd()
    }
    
    func loadAd() {
        if let adView = self.adView {
            DispatchQueue.global(qos: .background).async {
                adView.loadAd()
            }
        }
    }
    
    func showAd() {
        if let inView = self.view, let adView = adView {
            inView.subviews.forEach { $0.removeFromSuperview() }
            inView.addSubview(adView)
            
            let bottom =  adView.bottomAnchor.constraint(equalTo: inView.bottomAnchor)
            bottom.priority = .defaultHigh
            
            NSLayoutConstraint.activate([
                adView.leadingAnchor.constraint(equalTo: inView.leadingAnchor),
                adView.trailingAnchor.constraint(equalTo: inView.trailingAnchor),
                bottom,
                adView.topAnchor.constraint(equalTo: inView.topAnchor),
            ])
        }
    }
}

extension InlineBannerViewController: AdViewDelegate {
    func adViewDidLoad(_ adView: AdView) {
        // This method will call after successfully loading
        print("loaded!")
        self.showAd()
    }

    func adViewDidFailLoading(_ adView: AdView, error: Error) {
        // This method will call after getting any error while loading the ad
        print(error.localizedDescription)
    }
}


struct AdvertIntertestialView: UIViewControllerRepresentable {
    typealias UIViewControllerType = InterstitialViewController
    
    func makeUIViewController(context: Context) -> InterstitialViewController {
        let vc = InterstitialViewController()
        return vc
    }

    func updateUIViewController(_ uiViewController: InterstitialViewController, context: Context) {
        
    }
}

class InterstitialViewController: UIViewController {
    var interstitialAd: InterstitialAd?

    private lazy var interstitialAdLoader: InterstitialAdLoader = {
        let loader = InterstitialAdLoader()
        loader.delegate = self
        return loader
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadAd()
    }
    
    func loadAd() {
        let configuration = AdRequestConfiguration(adUnitID: "demo-interstitial-yandex")
        DispatchQueue.global(qos: .background).async {
            self.interstitialAdLoader.loadAd(with: configuration)
        }
    }
}

extension InterstitialViewController: InterstitialAdLoaderDelegate {
    private func makeMessageDescription(_ interstitialAd: InterstitialAd) -> String {
        "Interstitial Ad with Unit ID: \(String(describing: interstitialAd.adInfo?.adUnitId))"
    }
    
    func interstitialAdLoader(_ adLoader: InterstitialAdLoader, didLoad interstitialAd: InterstitialAd) {
        self.interstitialAd = interstitialAd
        print("\(makeMessageDescription(interstitialAd)) loaded")
        self.interstitialAd?.show(from: self)
    }

    func interstitialAdLoader(_ adLoader: InterstitialAdLoader, didFailToLoadWithError error: AdRequestError) {
        let id = error.adUnitId
        let error = error.error
        print("Loading failed for Ad with Unit ID: \(String(describing: id)). Error: \(String(describing: error))")
    }
}

extension InterstitialViewController: InterstitialAdDelegate {
    func interstitialAd(_ interstitialAd: InterstitialAd, didFailToShowWithError error: Error) {
        print("\(makeMessageDescription(interstitialAd)) failed to show. Error: \(error)")
    }

    func interstitialAdDidShow(_ interstitialAd: InterstitialAd) {
        print("\(makeMessageDescription(interstitialAd)) did show")
        
    }

    func interstitialAdDidDismiss(_ interstitialAd: InterstitialAd) {
        print("\(makeMessageDescription(interstitialAd)) did dismiss")
        self.dismiss(animated: true) {
            self.interstitialAd = nil
        }
    }

    func interstitialAdDidClick(_ interstitialAd: InterstitialAd) {
        print("\(makeMessageDescription(interstitialAd)) did click")
    }

    func interstitialAd(_ interstitialAd: InterstitialAd, didTrackImpressionWith impressionData: ImpressionData?) {
        print("\(makeMessageDescription(interstitialAd)) did track impression")
    }
    

}



struct AdvertsView: View {
    var body: some View {
        AdvertView()
        //AdvertIntertestialView()
            .background(Color("BgColor"))
            .foregroundColor(Color("FgColor"))
    }
}

#Preview {
    AdvertsView()
}
