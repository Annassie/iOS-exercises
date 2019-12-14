//
//  ViewController.swift
//  Notification
//
//  Created by Anna Niukkanen on 14/06/2019.
//  Copyright © 2019 Anna Niukkanen. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {

    let locationManager = CLLocationManager()
    
    @IBAction func launchTimedNotification(_ sender: Any) {
        // create notification content object
        let content = UNMutableNotificationContent()
        content.title = "This is a notification title"
        content.subtitle = "This is a notification subtitle"
        content.body = "This is is notification content text and there can be a multiple lines."
        content.sound = UNNotificationSound.default
        
        // deliver notification in 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        // schedule the notification
        let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError)
            }
        }
    }
    
    @IBAction func launchCalendarNotification(_ sender: Any) {
        // deliver notification every day at 9:45
        var date = DateComponents()
        date.hour = 23
        date.minute = 23
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        // create notification content object
        let content = UNMutableNotificationContent()
        content.title = "This is a Calendar Notification"
        content.subtitle = "This is a notification subtitle"
        content.body = "Time is now: \(date.hour!) : \(date.minute!)."
        content.sound = UNNotificationSound.default
        
        // schedule the notification
        let request = UNNotificationRequest(identifier: "CalendarNotification", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError)
            }
        }
    }
    
    
    @IBAction func launchLocationNotification(_ sender: Any) {
        // create location trigger - JAMK University of Applied Sciences / Dynamo Building
        let locationCenter = CLLocationCoordinate2D(latitude: 62.2416223, longitude: 25.7597309)
        // set region, radius are in meters
        let locationRegion = CLCircularRegion(center: locationCenter, radius: 50.0, identifier: "JAMK Dynamo")
        locationRegion.notifyOnEntry = true
        locationRegion.notifyOnExit = false
        let trigger = UNLocationNotificationTrigger(region: locationRegion, repeats: true)
        
        // create notification content object
        let content = UNMutableNotificationContent()
        content.title = "This is a Location Notification"
        content.subtitle = "JAMK University of Applied Science"
        content.body = "You have arrived to Dynamo Building!"
        content.sound = UNNotificationSound.default
        
        // create notification
        let request = UNNotificationRequest(identifier: "LocationNotification", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests() // just remove all to get this fired
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError)
            } else {
                print("Notification set successfully")
            }
        }
    }
    
    @IBAction func launchActionNotification(_ sender: Any) {
        // create notification content object
        let content = UNMutableNotificationContent()
        content.title = "THis is a Times Notification with Action"
        content.subtitle = "This is a notification subtitle"
        content.body = "This is notification content text ana there can be a multiple line"
        content.sound = UNNotificationSound.default
        
        // create notification action category
        let categoryIdentifer = "notificationexample.justaindetifier"
        // create notification action object, action brings app to the front
        let justATestAction = UNNotificationAction(identifier: "notificationexample.justaaction", title: "Just a Action", options: [.foreground])
        // just a cancel notification
        let cancelAction = UNNotificationAction(identifier: "notificationexample.cancel", title: "Cancel", options: [.foreground])
        // create catogory object and associate action objects to it
        let category = UNNotificationCategory(identifier: categoryIdentifer, actions: [justATestAction, cancelAction], intentIdentifiers: [], options: [])
        // register catefory
        UNUserNotificationCenter.current().setNotificationCategories([category])
        // associate actions to notifier
        content.categoryIdentifier = categoryIdentifer
        
        // deliver notification in 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        // schedule the notification
        let request = UNNotificationRequest(identifier: "notificationexample", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //create location manager object and request authorizatio for location updates
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self as CLLocationManagerDelegate
        locationManager.startUpdatingLocation()
        // request user notifications
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
//            if granted {
//                print("User allowed notifications")
//            } else {
//                print("User doesn not allowed notifications")
//            }
//        }
        // set the delegate of the notification center to this class
        UNUserNotificationCenter.current().delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latestLocation: CLLocation = locations[locations.count - 1]
        let latitude = String(latestLocation.coordinate.latitude)
        let longitude = String(latestLocation.coordinate.longitude)
        print("\(latitude) \(longitude)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        // check action identifier
        if response.actionIdentifier == "notification.justaction"{
            // just print a action
            print("Just a Action")
            // let the system know that we are done
            completionHandler()
        }
    }


}

