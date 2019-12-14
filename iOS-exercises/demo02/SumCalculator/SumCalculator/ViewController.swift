//
//  ViewController.swift
//  SumCalculator
//
//  Created by Anna Niukkanen on 10/06/2019.
//  Copyright © 2019 Anna Niukkanen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTextField1: UITextField!
    @IBOutlet weak var myTextField2: UITextField!
    @IBOutlet weak var myLabel1: UILabel!
    @IBOutlet weak var numbersLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myLabel1.isHidden = true
        // Do any additional setup after loading the view.
        
        // use NSLocalizedString to generate a localized string
        numbersLabel.text = NSLocalizedString("Text from the code", comment: "Set UILabel text from the code")
       // myButton1.button = NSLocalizedString("Text from the code", comment: "Set UILabel text from the code")
        
    }
    
    @IBAction func myButton1(_ sender: Any) {
        
        myLabel1.isHidden = false
        let firstValue = Double(myTextField1.text!)
        let secondValue = Double(myTextField2.text!)
        if firstValue != nil && secondValue != nil {
            let outputValue = Double(firstValue! + secondValue!)
            myLabel1.text = "The sum is \(outputValue)"
        }else{
            myLabel1.text = "Hey, enter number!"
        }
    }
    

}

