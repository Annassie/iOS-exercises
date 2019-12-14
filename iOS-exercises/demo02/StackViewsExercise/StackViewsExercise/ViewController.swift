//
//  ViewController.swift
//  StackViewsExercise
//
//  Created by Anna Niukkanen on 07/06/2019.
//  Copyright © 2019 Anna Niukkanen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var firstnames: [String] = ["Renato", "Rosangela", "Tim", "Bartol", "Jeannette", "Franka", "Valter", "Garnett", "Hyan", "Jasper"]
    
    var lastnames: [String] = ["Knappen", "Bartolozzi", "Gerritsma", "Chimenti", "Chivers", "Leighton", "Deshon", "Bus", "Iwanowski", "MacCurtain"]
    
    var jobtitles: [String] = ["Engineer", "Recruiting", "Manager", "Nurse", "Recruiting Manager", "Research Assistant", "Financial Analyst", "Health Coach", "Sales Representative", "Analyst Programmer"]
    
    var infotexts: [String] = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer venenatis bibendum leo, ac pulvinar massa. Vivamus vel faucibus ligula. Pellentesque congue hendrerit erat, in fringilla lacus auctor eu. Fusce eget vehicula arcu. Duis accumsan tempus tellus, scelerisque consectetur purus euismod eget. Donec imperdiet interdum leo, id lobortis nisi mollis sit amet. Interdum et malesuada fames ac ante ipsum primis in faucibus.",
        "In ac pellentesque ex. Ut consequat luctus nisl. Duis mollis euismod accumsan. Phasellus luctus metus id sem gravida consequat. Donec porta lobortis hendrerit. Sed id placerat metus, aliquet egestas enim. Praesent a nisl ac dolor luctus interdum. Vivamus dapibus fermentum accumsan. Maecenas est odio, malesuada eget arcu non, lacinia accumsan dui. Vestibulum iaculis malesuada justo sed bibendum. ",
        "Donec vehicula non ipsum at aliquam. Donec sit amet velit at ligula luctus rutrum eget in dui. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Suspendisse in porta enim. In lacinia sollicitudin lorem eu sodales. Sed eget mauris dui.",
        "Phasellus sit amet interdum nisi. Suspendisse non eleifend purus. Quisque neque massa, pretium non dolor a, semper bibendum ligula. Aliquam ut egestas ex. Etiam iaculis nisl sit amet efficitur aliquam. Aenean placerat tempus mauris, quis hendrerit velit laoreet ut. ",
        "Praesent ipsum sem, pulvinar suscipit mauris in, ultrices condimentum nunc. Aliquam convallis et ipsum in molestie. Nam porta tellus ut urna convallis porta. Aliquam blandit risus nec dui finibus cursus. Sed ligula massa, posuere in viverra consequat, suscipit vel justo.",
        "Cras tristique felis mauris, sed pellentesque urna tempus non. Fusce quis pharetra mi. Suspendisse aliquet efficitur dignissim. Phasellus non velit sit amet dolor venenatis vehicula vitae nec sapien. Quisque blandit nisi at hendrerit tincidunt. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.",
        "Nunc nec scelerisque nulla. Suspendisse sagittis nisl a ex facilisis semper. Aenean bibendum pharetra est, eget blandit arcu tempor eget. Nunc egestas mattis quam at semper. Vestibulum purus est, mollis vitae dignissim eu, consectetur nec purus. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        "Nulla justo nisi, lacinia eu viverra commodo, gravida eget augue. Nulla id ornare magna. Integer nec congue nunc, vel porta risus. Ut ac malesuada sapien. Vestibulum cursus aliquam libero, nec dictum justo. Cras congue a massa et dignissim. Quisque fermentum metus sit amet erat bibendum, sit amet ultricies justo varius. Duis vitae massa ac magna lacinia ultricies ut et nisi.",
        "Nulla hendrerit ipsum consequat libero gravida condimentum. Vestibulum sapien erat, pharetra nec tincidunt at, sagittis eget justo. Ut nisi erat, venenatis nec turpis sed, cursus sagittis odio. Ut commodo elementum sem vitae finibus. Nullam turpis lorem, vestibulum malesuada consectetur a, efficitur ut enim.",
        "Duis interdum turpis arcu, id rhoncus sapien posuere at. Pellentesque et quam vitae arcu tincidunt varius. Donec convallis convallis suscipit. In enim urna, varius eget tortor sed, tincidunt consequat eros. Suspendisse potenti. In finibus vehicula sodales. Sed laoreet viverra nisi, id congue libero convallis ut."]

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var lastname: UILabel!
    @IBOutlet weak var jobtitle: UILabel!
    @IBOutlet weak var infotext: UITextView!
    
    @IBAction func buttonClicked(_ sender: Any) {
        // get a button which has been tapped
        let button :UIButton = sender as! UIButton
        // get button title
        let buttonTitle :String = button.currentTitle!
        // get it as a number
        let buttonNumber :Int = Int(buttonTitle)!
        // show employee
        showEmployee(index: buttonNumber)
    }
    func showEmployee(index: Int) {
        // change image
        imageView.image = UIImage(named: "employee\(index)")
        // change texts
        firstname.text = firstnames[index-1]
        lastname.text = lastnames[index-1]
        jobtitle.text = jobtitles[index-1]
        infotext.text = infotexts[index-1]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showEmployee(index: 1)
    }
    


}

