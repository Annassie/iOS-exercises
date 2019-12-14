//
//  main.swift
//  Exercise02
//
//  Created by Anna Niukkanen on 02/06/2019.
//  Copyright © 2019 Anna Niukkanen. All rights reserved.
//

import Foundation

// ask a number from the user

print("Give points >")

// read line
if let line = readLine() {
    // text line is given (letters or maybe just enter is pressed)
    // try to conver to number
//    var points = Double(line)
    // if yes then number contains a number
    if let points = Int(line) {
        // we are sure that it is a number, we can use number! (forced unwrapping of the optional’s value)
        // your own code starts here...
        
//        switch (points) {
//        case 0...1:
//            print(0)
//        case 2...3:
//            print(1)
//        case 4...5:
//            print(2)
//        case 6...7:
//            print(3)
//        case 8...9:
//            print(4)
//        case 10...12:
//            print(5)
//        default:
//            print("")
//        }
        
        if points >= 0 && points <= 1{
            print(0)
        }else if points >= 2 && points <= 3{
            print(1)
        }else if points >= 4 && points <= 5{
            print(2)
        }else if points >= 6 && points <= 7{
            print(3)
        }else if points >= 8 && points <= 9{
            print(4)
        }else if points >= 10 && points <= 12{
            print(5)
        }
    } else {
        print("You don't give a number!")
    }
} else {
    // for example ctrl-d is pressed == "end of file"
    print("There is no text given!")
}







