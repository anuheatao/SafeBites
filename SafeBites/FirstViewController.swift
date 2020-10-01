//
//  FirstViewController.swift
//  SafeBites
//
//  Created by Student on 8/7/20.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBAction func LocationButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "HometoLocationSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

