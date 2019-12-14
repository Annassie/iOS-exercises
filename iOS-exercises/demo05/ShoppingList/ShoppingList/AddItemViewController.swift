//
//  AddItemViewController.swift
//  ShoppingList
//
//  Created by Anna Niukkanen on 13/06/2019.
//  Copyright © 2019 Anna Niukkanen. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController{
    @IBOutlet weak var newNameTextField: UITextField!
    @IBOutlet weak var newCountTextField: UITextField!
    @IBOutlet weak var newPriceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func AddNewItem(_ sender: Any) {
        // get Core Data context
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // Link Todo & Core Data Context / create a new ToD object
        let name = NameToAdd(context: context)
        //let count = CountToAdd(context: context)
        //let price = PriceToAdd(context: context)
        // get a new todo text from UI
        name.text = newNameTextField.text!
        //count.text = newCountTextField.text!
        //price.text = newPriceTextField.text!
        // save data to Core Data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        // pop this view -> go back to tableview
        navigationController?.popViewController(animated: true)
    }

}
