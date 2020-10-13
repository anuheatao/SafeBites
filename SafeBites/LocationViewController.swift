//
//  LocationViewController.swift
//  SafeBites
//
//  Created by Student on 8/8/20.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation


class LocationViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var names: [String] = []
    @IBOutlet var tableView: UITableView!
    var location: CLLocation!
    
    @IBAction func backtohomepressed(_ sender: Any) {
        self.performSegue(withIdentifier: "LocationtoHomeSegue", sender: self)
    }
    
    @IBAction func toPerillaPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toPerillaSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        if let x = UserDefaults.standard.object(forKey: "names") as? [String] {
            names = x
        }
    
    }
    override func viewDidAppear(_ animated: Bool) {
        if(location == nil) {
            let alertController = UIAlertController (title: "Unable to Get Nearby Restaurants", message: "To get nearby restaurants, we need to access your location. Please go to settings to fix this. Thanks!", preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                      alertController.addAction(cancelAction)
              let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

                  guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                      return
                  }

                  if UIApplication.shared.canOpenURL(settingsUrl) {
                      UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                          print("Settings opened: \(success)") // Prints true
                      })
                  }
              }
              alertController.addAction(settingsAction)
          

              present(alertController, animated: true, completion: nil)
            print("hullo")

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! nameTableViewCell
        cell.nameLabel.text = names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //when you select it
    }
    
    
}
