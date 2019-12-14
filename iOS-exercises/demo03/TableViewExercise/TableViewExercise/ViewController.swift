//
//  ViewController.swift
//  TableViewExercise
//
//  Created by Anna Niukkanen on 11/06/2019.
//  Copyright © 2019 Anna Niukkanen. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AudioToolbox

class EmployeeTableViewCell: UITableViewCell {
    @IBOutlet weak var employeeImage: UIImageView!
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var employeeTitle: UILabel!
    @IBOutlet weak var employeeDepartment: UILabel!
    
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GADBannerViewDelegate {
    
    let ADMOB_BANNER_UNIT_ID = "ca-app-pub-9733347540588953/7805958028"
    
    var employees = ["Renato Knappen", "Rosangela Bartolozzi", "Tim Gerritsma", "Bartol Chimenti", "Jeannette  Leighton", "Franka Deshon", "Valter MacCurtain", "Garnett Chivers", "Hyan Bus", "Jasper Iwanowski"]
    
    var titles = ["Engineer", "Recruiting", "Manager", "Nurse", "Recruiting Manager", "Research Assistant", "Financial Analyst", "Health Coach", "Sales Representative", "Analyst Programmer"]
    
    var departments = ["Engineering", "Human Resources", "Services", "Research", "Sales", "Research and Developmnet", "Legal", "Training", "Sales", "Support"]
    
    var phones = ["587-675-8141","887-451-1741","712-915-2597","468-594-8478","162-892-4315",
                  "889-843-1785","232-979-3191","993-828-7705","565-655-0804","174-964-0802"
    ]
    
    var emails = ["Blisse.Mingasson@company.com","Huey.Ranns@company.com","Verge.Burfield@company.com","Francklyn.Marquet@company.com",
                  "Pamela.Sansun@company.com","Clemmie.Craghead@company.com","Gunther.Kenchington@company.com","Faina.Rawet@company.com",
                  "Sosanna.Hayworth@company.com","Dyana.Deedes@company.com"
    ]
    
    // return number of rows in a collection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    // return a new cell to TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // indentifier
        let cellIndentifier: String = "Cell"
        // get a custom cell layout
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath) as! EmployeeTableViewCell
        
        // modify cell data
        cell.employeeName?.text = employees[indexPath.row]
        cell.employeeTitle?.text = titles[indexPath.row]
        cell.employeeDepartment?.text = departments[indexPath.row]
        cell.employeeImage?.image = UIImage(named: "employee\(indexPath.row+1)")
        
        // return cell
        return cell
    }
    
    // handle cell selection, open an options menu
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // add a new option menu
        let optionMenu = UIAlertController(title: nil, message:"What do you want to do?", preferredStyle: .actionSheet)
        
        // create callActionHandler object
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            if let url = URL(string: "tel://\(self.phones[indexPath.row])") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
        // add actions to menu
        let callAction = UIAlertAction(title: "Call", style: .default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        
        
        // create emailActionHandler object
        let emailActionHandler = { (action:UIAlertAction!) -> Void in
            if let url = URL(string: "mailto:\(self.emails[indexPath.row])") {
                print("url=\(url)")
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        // add action to menu
        let emailAction = UIAlertAction(title: "Email", style: .default, handler: emailActionHandler)
        optionMenu.addAction(emailAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
        optionMenu.addAction(cancelAction)
        
        // create webActionHandler object
        let webActionHandler = { (action:UIAlertAction!) -> Void in
            if let url = URL(string: "http://company.com") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
        // add action to menu
        let webAction = UIAlertAction(title: "Web", style: .default, handler: webActionHandler)
        optionMenu.addAction(webAction)
        
        //_ = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
        //optionMenu.addAction(callAction)
        
        // show menu
        present(optionMenu, animated: true, completion: nil)
    }
    
    // handle cell deletion when swiped left
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            employees.remove(at: indexPath.row)
            titles.remove(at: indexPath.row)
            departments.remove(at: indexPath.row)
            phones.remove(at: indexPath.row)
            emails.remove(at: indexPath.row)
            //images.remove(at: indexPath.row)
        }
        // refresh TableView data
        tableView.deleteRows(at: [indexPath], with: .fade) // .right, .left or .top
    }

    var adMobBannerView = GADBannerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        // Init AdMob banner
        initAdMobBanner()
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

