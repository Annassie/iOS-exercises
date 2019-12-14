//
//  CountryDetailViewController.swift
//  NavigationControllerExercise
//
//  Created by Anna Niukkanen on 12/06/2019.
//  Copyright © 2019 Anna Niukkanen. All rights reserved.
//

import UIKit
    
class CountryDetailViewController : UIViewController {
    struct Country: Codable {
        var id: Int
        var info: String
        var image: String
    }
    
    // connection to UIImage and UILabel
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryLabel_2: UILabel!
    
    @IBAction func infoButton(_ sender: Any) {
        print("Button pressed")
        self.performSegue(withIdentifier: "SegueCheckInfoViewController", sender: self)
    }
    
    // variable to hold country name
    var countryName: String = ""
    //var countryFlag: String = ""
    
    //var countries: [Country] = []
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // return employee's count in collecion
//        return countries.count
//    }
//
//    // method will be called every time a table row is displayed
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // our cell layout identifier
//        let cellIdentifier: String = "Cell"
//        // get the current row and create a reusable cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CountryDetailViewController
//        //cell.countryLabel.text = countries[indexPath.row].name
//        //cell.countryLabel_2 = countries[indexPath.row].info
//
//
//        // load image from url
//        let url = URL(string: countries[indexPath.row].image)
//        let imageData = try? Data(contentsOf: url!)
//        if imageData != nil {
//            countryImage.image = UIImage(data: imageData!)
//        }
//
//            // make an image rounded
//            //cell.employeeImage.makeRounded()
//
//         //   return cell
//
//        }
//
//        func loadAndParseJson() {
//            let urlString = "https://student.labranet.jamk.fi/~mapas/data/employees.json"
//            guard let url = URL(string: urlString) else {
//                print("Error: URL error")
//                return
//            }
//
//            URLSession.shared.dataTask(with: url) { (data, response, error) in
//                // do we have any errors
//                if error != nil {
//                    print(error!.localizedDescription)
//                }
//                // check that we actually have data
//                guard data != nil else {
//                    print("Error: did not receive data")
//                    return
//                }
//                // JSON decoding and parsing
//                _ = JSONDecoder()
//                do {
//                    // decode retrived data with JSONDecoder and assing type of Employee object
//                    //_ = JSONDecoder()
//                    //self.countryFlag = try JSONDecoder.decode([Country], from: data)
//                    //self.countryImageView.reloadData()
////                    // get back to the main queue and assing data to TableView
////                    DispatchQueue.main.async {
////                        print(employeesData)
////                        self.employees = employeesData
////                        self.employeeTableView.reloadData()
////                        //self.activityIndicator.stopAnimating()
////                        self.employeeTableView.isHidden = false
////                    }
//                }
////                } catch let jsonError {
////                    print("Failed to decode",jsonError)
////                }
//            }.resume() // start task
//        }
    
    // viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // show employee name
        countryLabel.text = countryName;
        
        // load image from url - randomize one image from https://randomuser.me
        var imageString = "https://randomuser.me/api/portraits/";
        let random = arc4random_uniform(2) // 0 or 1
        if (random == 1) {
            imageString += "women/"
        } else {
            imageString += "men/"
        }
        imageString += String(arc4random_uniform(99) + 1) // "1" to "100"
        imageString += ".jpg"
        // create image URL
        let url = URL(string: imageString)
        // load image data
        let imageData = try? Data(contentsOf: url!)
        // show image
        if imageData != nil {
            countryImage.image = UIImage(data: imageData!)
            countryImage.layer.shadowOpacity = 0.7
            countryImage.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
