//
//  PerillaViewController.swift
//  SafeBites
//
//  Created by Student on 8/8/20.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit
import Firebase

class PerillaViewController: UIViewController, UITableViewDataSource & UITableViewDelegate {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ratePercentLabel: UILabel!
    @IBOutlet var SanSpecific: [UILabel]!
    @IBOutlet var PDSpecific: [UILabel]!
    @IBOutlet var SMSpecific: [UILabel]!
    @IBOutlet weak var RateButton: UIButton!
    @IBOutlet var slida: UISlider!
    @IBOutlet var pdsLabel: UILabel!
    @IBOutlet var pdsSlider: UISlider!
    @IBOutlet var osdSlider: UISlider!
    @IBOutlet var osLabel: UILabel!
    @IBOutlet var commentTableView: UITableView!
    @IBOutlet var scrollView: UIScrollView!
    
    var db = Firestore.firestore()
    var commentArray: [String] = []
    var restaurantName = ""
    
    @IBAction func perillatolocation(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "locationVC") as! LocationViewController
        view.window?.rootViewController = vc
    }
    @IBAction func rateButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "PerillatoRateSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        commentTableView.delegate = self
        commentTableView.dataSource = self
        RateButton.layer.cornerRadius = 25.0

            
        }
        
       
    override func viewDidAppear(_ animated: Bool) {
        if let x = UserDefaults.standard.object(forKey: "titleName") as? String {
            nameLabel.text = x
            restaurantName = x
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
                    let clearMarkSpacing = myData?["clearMarkSpacing"] as? Int ?? 0
                    let sixFeetSpacing = myData?["sixFeetSpacing"] as? Int ?? 0
                    let limitCustomers = myData?["limitCustomers"] as? Int ?? 0
                    let designatedTransactionArea = myData?["designatedTransactionArea"] as? Int ?? 0
                    let promotesSafety = myData?["promotesSafety"] as? Int ?? 0
                    let tempCheck = myData?["tempCheck"] as? Int ?? 0
                    let contactTracing = myData?["contactTracing"] as? Int ?? 0
                    let outdoorDining = myData?["outdoorDining"] as? Int ?? 0
                    let ventilationAirCirc = myData?["ventilationAirCirc"] as? Int ?? 0
                    let laminatedSingleUseMenus = myData?["laminatedSingleUseMenus"] as? Int ?? 0
                    let numerator = maskReq + sanitizeAfter + sanitizerHygeine + touchlessTransaction + shieldsBarriers
                    let pdNumber = clearMarkSpacing + sixFeetSpacing + limitCustomers + designatedTransactionArea + promotesSafety
                    let osNumber = tempCheck + contactTracing + outdoorDining + ventilationAirCirc + laminatedSingleUseMenus
                    let totals = total * 5
                    let float = roundf(Float(numerator)/Float(totals) * 100)
                    let pdAverage = roundf((Float(pdNumber)/Float(totals)) * 100)
                    let osAverage = roundf((Float(osNumber)/Float(totals)) * 100)
                    self.slida.value = float
                    self.ratePercentLabel.text = "\(self.slida.value)%"
                    self.SanSpecific.forEach { (label) in
                        label.text = "\(maskReq)/\(total) -- Mask Wearing Required \n \(sanitizerHygeine)/\(total) -- Hygiene Supplies Used \n \(sanitizeAfter)/\(total) -- Surfaces Sanitized after Each Person \n \(touchlessTransaction)/\(total) -- Touchless Transactions Used \n \(shieldsBarriers)/\(total) -- Sheilds or Physical Barriers"
                    }
                    self.pdsSlider.value = pdAverage
                    self.pdsLabel.text = "\(self.pdsSlider.value)%"
                    self.PDSpecific.forEach { (label) in
                        label.text = "\(clearMarkSpacing)/\(total) -- Clearly Marked Spacing \n \(sixFeetSpacing)/\(total) -- 6ft Spaced Furniture \n \(limitCustomers)/\(total) -- Limiting Customer Capacity \n \(designatedTransactionArea)/\(total) -- Designated Transaction Area \n \(promotesSafety)/\(total) -- Visible Signage Promoting Safety"
                    }
                    self.osdSlider.value = osAverage
                    self.osLabel.text = "\(self.osdSlider.value)%"
                    self.SMSpecific.forEach { (label) in
                        label.text = "\(tempCheck)/\(total) -- Temperature Check \n \(contactTracing)/\(total) -- Contact Tracing Provided \n \(outdoorDining)/\(total) -- Outdoor dining available \n \(ventilationAirCirc)/\(total) -- Ventilation and Air Circulation \n \(laminatedSingleUseMenus)/\(total) -- Single Use or Laminated Menus"
                    }
                    
                    
                }}
            self.db.collection("Reviews").document("\(x)").getDocument { (docSnapshot, error) in
                     if let error = error {
                         print("BAAADD: error getting docs: \(error.localizedDescription)")
                     }
                     print("HIHI")
                     let data = docSnapshot?.data()
                     let total = data?["total"] as? Int ?? 0
                     for i in 1...total {
                         if let comment = data?["comment \(i)"] as? String{
                             //there is a comment
                             self.commentArray.append(comment)
                             print("Comment array \(self.commentArray)")
                             self.commentTableView.reloadData()
                             if(i == total) {
                                 if(self.commentArray.count == 0) {
                                     self.commentArray.append("There are no comments right now. Add one by pressing the rate button.")
                                 }
                                 
                             }
                         }
                     }
        }
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return commentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(commentArray)
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentTableViewCell
        cell.commentLabel.text = commentArray[indexPath.row]
        return cell
    }
}

