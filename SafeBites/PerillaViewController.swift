//
//  PerillaViewController.swift
//  SafeBites
//
//  Created by Student on 8/8/20.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit

class PerillaViewController: UIViewController {
    
    @IBOutlet var SanSpecific: [UIButton]!
    @IBOutlet var PDSpecific: [UIButton]!
    @IBOutlet var SMSpecific: [UIButton]!
    @IBOutlet weak var RateButton: UIButton!
    @IBAction func perillatolocation(_ sender: Any) {
        self.performSegue(withIdentifier: "PerillatoLocationSegue", sender: self)
    }
    
    @IBAction func rateButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "PerillatoRateSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        RateButton.layer.cornerRadius = 25.0
    }

    @IBAction func SanSeeMore(_ sender: UIButton) {
        SanSpecific.forEach { (button) in
            UIStackView.animate(withDuration: 0.3) {
                button.isHidden = !button.isHidden
            }
        }
    }
    
    @IBAction func SanSeeMoreTapped(_ sender: UIButton) {
        if sender.isSelected {
                 sender.isSelected = false
             }
             else {
                 sender.isSelected = true
             }
         }
    
    @IBAction func PDSeeMore(_ sender: UIButton) {
        PDSpecific.forEach { (button) in
            UIStackView.animate(withDuration: 0.3) {
                button.isHidden = !button.isHidden
            }
        }
    }
    
    @IBAction func SMSeeMore(_ sender: UIButton) {
        SMSpecific.forEach{ (button) in
            UIStackView.animate(withDuration: 0.3) {
                button.isHidden = !button.isHidden
            }
            
            }
    }
    
}

