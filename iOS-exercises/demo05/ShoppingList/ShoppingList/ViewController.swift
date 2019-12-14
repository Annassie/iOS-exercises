//
//  ViewController.swift
//  ShoppingList
//
//  Created by Anna Niukkanen on 13/06/2019.
//  Copyright © 2019 Anna Niukkanen. All rights reserved.
//

import UIKit
import CoreData

class Item: NSObject {
    var name: String?
    var count: Float?
    var price: Float?
    
}

class ShoppingListTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //var listItems = [NSManagedObject]()
    //let listItems = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var listItems = [Item]()
    
    var names: [NameToAdd] = []
    var totalCounts: [CountToAdd] = []
    var totalPrices: [PriceToAdd] = []
    
//    init(_name: String, _totalCount: Int, _totalPrice: Float = 0) {
//        name = _name
//        totalCount = 0
//        totalPrice = _totalPrice
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
        return listItems.count
//        return totalCounts.count
  //      return totalPrices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt cellForRowAtIndexPath: IndexPath) -> UITableViewCell {
//        let cellIndentifier: String = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell
        
//        // modify cell data
//        cell.nameLabel?.text = names[indexPath.row]
//        cell.countLabel?.text = totalCounts[indexPath.row]
//        cell.priceLabel?.text = totalPrices[indexPath.row]

//        let cell = UITableViewCell()
//
//        let name = names[indexPath.row]
//        let count = totalCounts[indexPath.row]
//        let price = totalPrices[indexPath.row]
        
//        cell.nameLabel?.text = name.text
//        cell.countLabel?.text = count.text
//        cell.priceLabel?.text = price.text
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let name = names[indexPath.row]
//            context.delete(name)
//            (UIApplication.shared.delegate as! AppDelegate).saveContext()
//            getData()
//        }
//        tableView.reloadData()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Shopping List"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addItem))
            
            
         //   title: "Add", style: .plain, target: self, action: #selector(addTapped))
        
        //tableView.delegate = self
        //tableView.dataSource = self
    }
    
    @objc func addItem(){
        performSegue(withIdentifier: "AddItemViewController", sender: self)
//        let confirmAction = UIAlertAction(title: "Add a new item to Shopping list", style: UIAlertViewStyle.default, handler: ({
//            (_) in
//        }))
    }
    
    func saveItem(itemToSave : String) {
      //  let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
     //   let manageContext = appDelegate.managedObjectContext
        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        // get Core Data
//        getData()
//        // show in tableView
//        tableView.reloadData()
//    }
    
//    func getData() {
//        do {
//            names = try context.fetch(NameToAdd.fetchRequest())
//        } catch {
//            print("Fetching Core Data failed!")
//        }
//    }
//
//    override func didReceiveMemoryWarning() {
//            super.didReceiveMemoryWarning()
//    }
//



}

