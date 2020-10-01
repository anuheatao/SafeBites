//
//  RatePerillaViewController.swift
//  SafeBites
//
//  Created by Student on 8/10/20.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit

class RatePerillaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func checkedBoxTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        }
        else {
            sender.isSelected = true
        }
    }
    
    @IBAction func toPerilla(_ sender: Any) {
        self.performSegue(withIdentifier: "RatetoPerillaSegue", sender: self)
    }
   @IBAction func SubmitPressed(_ sender: Any) { self.performSegue(withIdentifier: "RatetoScoreSegue", sender: self)
  }
    
}
