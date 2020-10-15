//
//  PerillaViewController.swift
//  SafeBites
//
//  Created by Student on 8/8/20.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit
import Firebase

class PerillaViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ratePercentLabel: UILabel!
    @IBOutlet var SanSpecific: [UILabel]!
    @IBOutlet var PDSpecific: [UIButton]!
    @IBOutlet var SMSpecific: [UIButton]!
    @IBOutlet weak var RateButton: UIButton!
    @IBOutlet var slida: UISlider!
    
    var db = Firestore.firestore()
    
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
    override func viewDidAppear(_ animated: Bool) {
        if let x = UserDefaults.standard.object(forKey: "titleName") as? String {
                   nameLabel.text = x
            self.db.collection("Reviews").document("\(x )").getDocument { (document, error) in
                             if let error = error {
                                 print("OH NO!!! Error fetching data: \(error.localizedDescription)")
                             }
                             if let document = document, document.exists {
                                 let myData = document.data()
                                let maskReq = myData?["maskWearingReqs"] as? Int ?? 0
                                let sanitizerHygeine = myData?["sanitizerHygeine"] as? Int ?? 0
                                let sanitizeAfter = myData?["sanitizeAfter"] as? Int ?? 0
                                let touchlessTransaction = myData?["touchlessTransaction"] as? Int ?? 0
                                let shieldsBarriers = myData?["shieldsBarriers"] as? Int ?? 0
                                let total = myData?["total"] as? Int ?? 0
                                let numerator = maskReq + sanitizeAfter + sanitizerHygeine + touchlessTransaction + shieldsBarriers
                                print("numerator: \(numerator)")
                                let totals = total * 5
                                print("totals: \(totals)")
                                let float = (Float(numerator)/Float(totals)) * 100
                                print("numba: \(float))")
                                self.slida.value = float
                                print("ok slider changed to: \(self.slida.value)")
                                self.ratePercentLabel.text = "\(self.slida.value)%"
                                self.SanSpecific.forEach { (label) in
                                    label.text = "\(maskReq)/\(total) -- Mask Wearing Required \n \(sanitizerHygeine)/\(total) -- Hygiene Supplies Used \n \(sanitizeAfter)/\(total) -- Surfaces Sanitized after Each Person \n \(touchlessTransaction)/\(total) -- Touchless Transactions Used \n \(shieldsBarriers)/\(total) -- Sheilds or Physical Barriers"
                                }
                }}
               }
        
        
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
 @IBAction func slider(_ sender: UISlider) {
        let x = Int(round((sender).value))
        ratePercentLabel.text = "\(x)%"
    }

    
}

