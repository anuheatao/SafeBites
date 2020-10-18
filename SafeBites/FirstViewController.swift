//
//  FirstViewController.swift
//  SafeBites
//
//  Created by Student on 8/7/20.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit
import CoreLocation
import YelpAPI
import BrightFutures

class FirstViewController: UIViewController, UISearchBarDelegate,UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var locationManager = CLLocationManager()
    var names: [String] = []
    var location: CLLocation!
    @IBAction func LocationButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "HometoLocationSegue", sender: self)
    }
    var filteredData: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        searchBar.inputAccessoryView = toolbar
        if(CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            let locationManager = CLLocationManager()
            location = locationManager.location
            tableView.isHidden = false
            searchBar.isUserInteractionEnabled = true

        }
      let headers = [
      "authorization": "Bearer 0EKlpC9MWYQY3geEbSQr0AT8EzzBTzmpUeyc_MtapOzs5kQFMbPK7x1sC6BgMvEdIuWxx6p2WWmg3PasgWnrDin7ynDU1aQurpAv62ZFElZJAW2GEk97EWSTOGSLX3Yx",
      "cache-control": "no-cache"
      ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.yelp.com/v3/businesses/search?term=&latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&limit=50")! as URL,
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
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                    for i in convertedJsonIntoDict as! NSDictionary {
                        print("data: \(i.value)")
                        if(i.key as! String == "businesses") {
                            for j in i.value as! NSArray{
                                for k in j as! NSDictionary {
                                if(k.key as! String == "name") {
                                    self.names.append(k.value as! String)
                                    print("name: \(k.value)")
                                    }}
                                
                            }
                        }
                    }
                    DispatchQueue.main.async {
                          let vc = LocationViewController()
                          vc.names = self.names
                          print("Vc names: \(vc.names)")
                          UserDefaults.standard.set(self.names, forKey: "names")
                          vc.location = self.location
                        self.filteredData = self.names
                        self.tableView.reloadData()

                          }
            }
            }
            catch let error as NSError {
                print("Error: \(error)")
            }
        }
      }
        })

      dataTask.resume()
        
        
        
        
        
        /*                     let headers = [
                           "x-rapidapi-host": "tripadvisor1.p.rapidapi.com",
                           "x-rapidapi-key": "7583d34caemsh9b2f1408fcf2427p108a16jsnb67b17c9ec9c"
                       ]
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
         
         
         
         }
         } catch let error as NSError {
         print(error.localizedDescription)
         }
         }
         
         
         }
         })
         
         dataTask.resume()
         
         }else {
         print("its nil")
         }*/
                
    }
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(filteredData == nil) {
            return 0
        }else {
            return filteredData.count
        }
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       print("IHIHIHIHI")
            filteredData = names.filter({ (item: String) -> Bool in
                return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            })
        print("filteredData: \(filteredData)")
       DispatchQueue.main.async{
            self.tableView.reloadData()
        }
        
            }
}

