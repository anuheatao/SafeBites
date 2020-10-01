//
//  LocationViewController.swift
//  SafeBites
//
//  Created by Student on 8/8/20.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

    @IBAction func backtohomepressed(_ sender: Any) {
        self.performSegue(withIdentifier: "LocationtoHomeSegue", sender: self)
    }
    
    @IBAction func toPerillaPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toPerillaSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
