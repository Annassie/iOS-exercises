//
//  main.swift
//  Exercise06
//
//  Created by Anna Niukkanen on 14/06/2019.
//  Copyright © 2019 Anna Niukkanen. All rights reserved.
//

import Foundation

var times = 1
//var newArray = [Int]()
var numbersArray = [Int]()

repeat{
    print("Give a number (not a number ends) ")
    times = times + 1
    if let line = readLine() {
        if let number = Int(line){
            numbersArray.append(number)
            //print(newArray)
            for (index, value) in numbersArray.enumerated() {
                print("Item \(index + 1): \(value)")
            }
            
            if times >= 6{
                print("end")
                break
            }
        }
    }
}while times <= 5
print(numbersArray)
