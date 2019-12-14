//
//  ViewController.swift
//  NavigationControllerExercise
//
//  Created by Anna Niukkanen on 12/06/2019.
//  Copyright © 2019 Anna Niukkanen. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AudioToolbox
//import GADUnifiedNativeAdDelegate


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GADBannerViewDelegate, GADUnifiedNativeAdDelegate {
//    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
//        <#code#>
//    }
//
//    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADUnifiedNativeAd) {
//         // A unified native ad has loaded, and can be displayed.
//    }
//

    let countries = [
        "Spain","Germany","France","Italy","Portugal",
        "Poland","Malta","Netherlands","Slovenia","Denmark"
    ]
    
    let SegueCountryDetailViewController = "SegueCountryDetailViewController"
    
    // Ad banner and interstitial views
    var adMobBannerView = GADBannerView()
    var adLoader: GADAdLoader!
    // IMPORTANT: REPLACE THE RED STRING BELOW WITH THE AD UNIT ID YOU'VE GOT BY REGISTERING YOUR APP IN http://apps.admob.com
    let ADMOB_BANNER_UNIT_ID = "ca-app-pub-9733347540588953/7805958028"
    // "ca-app-pub-3940256099942544/3986624511"
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // our cell layout identifier
        let cellIdentifier: String = "Cell"
        // get the current row and create a reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // modify cell data
        cell.textLabel?.text = countries[indexPath.row]
        
        // return cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // perform Segue
        performSegue(withIdentifier: SegueCountryDetailViewController, sender: self)
        // remove selection from table view
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // do a preparation before navigation, pass employee name to CountryDetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // going toSegueCountryDetailViewController
        if segue.identifier == SegueCountryDetailViewController {
            // get table view selected row index
            if let indexPath = tableView.indexPathForSelectedRow {
                // downcast UIViewController to CountryDetailViewController
                let destinationViewController = segue.destination as! CountryDetailViewController
                // set countryName variable from countries collection
                destinationViewController.countryName = countries[indexPath.row]
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Countries"
        
        // Init AdMob banner
        initAdMobBanner()
//        let multipleAdsOptions = GADMultipleAdsAdLoaderOptions()
//        multipleAdsOptions.numberOfAds = 5
//
//        adLoader = GADAdLoader(adUnitID: "ca-app-pub-3940256099942544/3986624511", rootViewController: self,
//                               adTypes: [GADAdLoaderAdType.unifiedNative],
//                               options: [multipleAdsOptions])
//        adLoader.delegate = self as! GADAdLoaderDelegate
//        adLoader.load(GADRequest())
    }
    
//    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
//        // A unified native ad has loaded, and can be displayed.
//    }
    
//    func adLoader(_ adLoader: GADAdLoader){
//        // A unified native ad has loaded, and can be displayed.
//    }
//
//    func adLoaderDidFinishLoading(_ adLoader: GADAdLoader) {
//        // The adLoader has finished loading ads, and a new request can be sent.
//
//    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -  ADMOB BANNER
    func initAdMobBanner() {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            // iPhone
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 320, height: 50))
            adMobBannerView.frame = CGRect(x: 0, y: view.frame.size.height, width: 320, height: 50)
        } else  {
            // iPad
            adMobBannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 468, height: 60))
            adMobBannerView.frame = CGRect(x: 0, y: view.frame.size.height, width: 468, height: 60)
        }
        
        adMobBannerView.adUnitID = "ca-app-pub-9733347540588953/7805958028"
        adMobBannerView.rootViewController = self
        adMobBannerView.delegate = self
        view.addSubview(adMobBannerView)
        
        let request = GADRequest()
        adMobBannerView.load(request)
    }
    
    
    // Hide the banner
    func hideBanner(_ banner: UIView) {
        UIView.beginAnimations("hideBanner", context: nil)
        banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
        UIView.commitAnimations()
        banner.isHidden = true
    }
    
    // Show the banner
    func showBanner(_ banner: UIView) {
        UIView.beginAnimations("showBanner", context: nil)
        banner.frame = CGRect(x: view.frame.size.width/2 - banner.frame.size.width/2, y: view.frame.size.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
        UIView.commitAnimations()
        banner.isHidden = false
    }
    
    // AdMob banner available
    func adViewDidReceiveAd(_ view: GADBannerView) {
        showBanner(adMobBannerView)
    }
    
    // NO AdMob banner available
    func adView(_ view: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        hideBanner(adMobBannerView)
    }
}



