//
//  ViewController.swift
//  MapExercise
//
//  Created by Anna Niukkanen on 12/06/2019.
//  Copyright © 2019 Anna Niukkanen. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class CourseMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            // get course
            guard let course = newValue as? Course else { return }
           // show callout
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            markerTintColor = course.markerTintColor
            glyphText = String(course.course)
        }
    }
}

// create extension for Codable
extension CLLocationCoordinate2D: Codable {
    // encode
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(latitude)
        try container.encode(longitude)
    }
    // decode
    public init(from decoder: Decoder) throws {
        self.init()
        var container = try decoder.unkeyedContainer()
        latitude = try container.decode(Double.self)
        longitude = try container.decode(Double.self)
    }
}

class Course: NSObject, MKAnnotation, Codable {
    // for annotation
    let coordinate: CLLocationCoordinate2D
    var title: String? { return course }
    var subtitle: String? { return (address + phone + email + web + text) }

    // for course
    let type: String
    let course: String
    let address: String
    let phone: String
    let email: String
    let web: String
    let image: String
    let text: String
    
    public init(coordinate: CLLocationCoordinate2D, course: String, type: String, address: String, phone: String, email: String, web: String, image: String, text: String) {
        self.course = course
        self.coordinate = coordinate
        self.type = type
        self.address = address
        self.phone = phone
        self.email = email
        self.web = web
        self.image = image
        self.text = text

        
        super.init()
    }
//    // Annotation right callout accessory opens this mapItem in Maps app
//    func mapItem() -> MKMapItem {
//        let addressDict = [CNPostalAddressStreetKey: subtitle!]
//        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
//        let mapItem = MKMapItem(placemark: placemark)
//        mapItem.name = title
//        return mapItem
//    }
    
    // markerTintColor for type: Kulta, Kulta/etu, Etu, other
    var markerTintColor: UIColor  {
        switch type {
        case "Kulta":
            return .orange
        case "Kulta/Etu":
            return .purple
        case "Etu":
            return .blue
        default:
            return .gray
        }
    }
}

// MKMapViewDelegate is used to get selection from MapView
class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    // an array to hold the 'Course' objects from the JSON file
    // courses
    var courses = [Course]()
    
    // the map view needs an annotation view
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // indentifier
        let identifier = "CourseMarkerView"
        
        // don't modify user location annotation
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        // reuse the annotation if possible
        var annotationView: CourseMarkerView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CourseMarkerView
        
        // if we can't reuse, create a new one
        if annotationView == nil {
            annotationView = CourseMarkerView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        // return annotation view
        return annotationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // define delegates to mapview (in this class)
        mapView.delegate = self

        // select annotation (this line is commented in left image, and uncommented in right image)
      //  mapView.selectAnnotation(courses as! MKAnnotation, animated: true)

        loadJSONFromWeb()
        mapView.addAnnotations(courses)
        mapView.register(CourseMarkerView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadJSONFromWeb(){
        // create URL
        let urlString = "https://student.labranet.jamk.fi/~mapas/data/golf_courses_ios.json"
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }

        // create URLSession task
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // print possible error message
            if error != nil {
                print(error!.localizedDescription)
            }

            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }

            // decode JSON data
            let decoder = JSONDecoder()
            do {
                self.courses = try decoder.decode([Course].self, from: responseData)
                // show course annotations
                DispatchQueue.main.async {
                    self.mapView.addAnnotations(self.courses)
                }
            } catch let error{
                print(error)
            }
        }.resume() // start task
    }
    
   // some annotation calloutAccessoryControlTapped is tapped
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        print("CalloutAccessoryControlTapped tapped!")
        
        let location = view.annotation as! Course
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        //location.mapItem().openInMaps(launchOptions: launchOptions)
        
        
        let courseName = view.annotation as! Course
        let course = courseName.course
    
        
        let ac = UIAlertController(title: course, message: "This course annotation callout button is tapped", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    // some annotation is selected from the map
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("MKAnnotationView tapped!")
        if view.annotation is MKUserLocation {
            return
        }
        let selectAnnotation = view.annotation as! Course
        let title = selectAnnotation.title!
        let subtitles = selectAnnotation.subtitle!
        
        print("tapped: \(title + subtitles)")
    }


}

