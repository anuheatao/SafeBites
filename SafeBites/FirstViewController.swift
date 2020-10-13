//
//  FirstViewController.swift
//  SafeBites
//
//  Created by Student on 8/7/20.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController {
    var locationManager = CLLocationManager()
    var names: [String] = []
    var location: CLLocation!
    @IBAction func LocationButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "HometoLocationSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
    }
    override func viewDidAppear(_ animated: Bool) {
               let headers = [
                     "x-rapidapi-host": "tripadvisor1.p.rapidapi.com",
                     "x-rapidapi-key": "7583d34caemsh9b2f1408fcf2427p108a16jsnb67b17c9ec9c"
                 ]
                 if(CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
                     let locationManager = CLLocationManager()
                     location = locationManager.location
                    
                 }
            if(location != nil) {
                 let request = NSMutableURLRequest(url: NSURL(string: "https://tripadvisor1.p.rapidapi.com/restaurants/list-by-latlng?limit=30&currency=USD&distance=2&lunit=km&lang=en_US&latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)")! as URL,
                                                   cachePolicy: .useProtocolCachePolicy,
                                                   timeoutInterval: 10.0)
                 request.httpMethod = "GET"
                 request.allHTTPHeaderFields = headers
                 
                 let session = URLSession.shared
                 let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                     if (error != nil) {
                         print(error)
                     } else {
                         let httpResponse = response as? HTTPURLResponse
                         print(httpResponse)
                         if let data = data, let dataString = String(data: data, encoding: .utf8) {
                             //print("Response data string:\n \(dataString)")
                             
                                  do {
                              
                                 if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                                     print(convertedJsonIntoDict)
                                     for i  in convertedJsonIntoDict as! NSDictionary {
                                         if i.key as! String == "data" {
                                             print("data: \(i.value)")
                                             for j in i.value as! NSArray {
                                                 for k in j as! NSDictionary{
                                                     if(k.key as! String == "name") {
                                                         print("name: \(k.value)")
                                                         self.names.append(k.value as! String)
                                                        DispatchQueue.main.async {
                                                        let vc = LocationViewController()
                                                        vc.names = self.names
                                                            print("Vc names: \(vc.names)")
                                                            UserDefaults.standard.set(self.names, forKey: "names")
                                                            vc.location = self.location

                                                        }

                                                     }
                                                 }                                    }
                                         }
                                     }
                                        /* if let nameData = convertedJsonIntoDict[0] as? NSDictionary {
                                             for i in nameData {
                                                 if(i.key as! String == "name") {
                                                     print("name: \(i.value)")
                                                     self.names.append(i.key as! String)
                                                 }
                                             }
                                         }else {
                                             print("uh uh not workiing")
                                     }
                                     */

                                     
                                 }
                             } catch let error as NSError {
                                 print(error.localizedDescription)
                             }
                         }
                         
                         
                     }
                 })
                 
                 dataTask.resume()
               
        }
            
    }

}

