//
//  ViewController.swift
//  AutoLayoutExercise
//
//  Created by Anna Niukkanen on 07/06/2019.
//  Copyright © 2019 Anna Niukkanen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textLabel.text = NSLocalizedString("Text from the code", comment: "Set UILabel text from the code")
    }


}

