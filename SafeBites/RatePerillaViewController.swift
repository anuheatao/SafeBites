//
//  RatePerillaViewController.swift
//  SafeBites
//
//  Created by Student on 8/10/20.
//  Copyright © 2020 Student. All rights reserved.
//

import UIKit
import Firebase

class RatePerillaViewController: UIViewController {

    @IBOutlet var maskReq: UIButton!
    @IBOutlet var sanitizerHygiene: UIButton!
    @IBOutlet var sanitizeAfter: UIButton!
    @IBOutlet var touchlessTransaction: UIButton!
    @IBOutlet var shieldsBarriers: UIButton!
    
    var restaurantName: String!
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
         if let x = UserDefaults.standard.object(forKey: "titleName") as? String {
                    restaurantName = x
                }
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
   @IBAction func SubmitPressed(_ sender: Any) {
    var ref: DocumentReference!
    if(maskReq.isSelected) {
        var dataDescription: Int! = 0
        db.collection("Reviews").document("\(restaurantName ?? "")").getDocument { (document, error) in
            if let error = error {
                print("OH NO!!! Error fetching data: \(error.localizedDescription)")
            }
            if let document = document, document.exists {
                let myData = document.data()
                dataDescription = myData?["maskWearingReqs"] as? Int ?? 0
                
                self.db.collection("Reviews").document("\(self.restaurantName ?? "")").updateData([
                                "maskWearingReqs": dataDescription + 1 ,
                            ]) {err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("Document successfully written!")
                                }
            }
            }else {
                self.db.collection("Reviews").document("\(self.restaurantName ?? "")").setData([
                                "maskWearingReqs": dataDescription + 1 ,
                            ], merge: true) {err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("Document successfully written!")
                                }
            }

                    }

    }
    }
    if self.sanitizerHygiene.isSelected {
                var dataDescription: Int! = 0
                self.db.collection("Reviews").document("\(self.restaurantName ?? "")").getDocument { (document, error) in
                    if let error = error {
                        print("OH NO!!! Error fetching data: \(error.localizedDescription)")
                    }
                    if let document = document, document.exists {
                        let myData = document.data()
                        dataDescription = myData?["sanitizerHygeine"] as? Int ?? 0
                       self.db.collection("Reviews").document("\(self.restaurantName ?? "")").updateData([
                                              "sanitizerHygeine": dataDescription + 1 ,
                                          ]) {err in
                                              if let err = err {
                                                  print("Error writing document: \(err)")
                                              } else {
                                                  print("Document successfully written!")
                                              }


                        }}
                    else {
                            self.db.collection("Reviews").document("\(self.restaurantName ?? "")").setData([
                                                   "sanitizerHygeine": dataDescription + 1 ,
                                               ], merge: true) {err in
                                                   if let err = err {
                                                       print("Error writing document: \(err)")
                                                   } else {
                                                       print("Document successfully written!")
                                                   }

                        

        }
                           }
            }
    }
                if self.sanitizeAfter.isSelected {
                    var dataDescription: Int! = 0
                    self.db.collection("Reviews").document("\(self.restaurantName ?? "")").getDocument { (document, error) in
                        if let error = error {
                            print("OH NO!!! Error fetching data: \(error.localizedDescription)")
                        }
                        if let document = document, document.exists {
                            let myData = document.data()
                            dataDescription = myData?["sanitizeAfter"] as? Int ?? 0
                                self.db.collection("Reviews").document("\(self.restaurantName ?? "")").updateData([
                                "sanitizeAfter": dataDescription + 1 ,
                            ]) {err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("Document successfully written!")
                                }


                            }
                        }else {
                                    self.db.collection("Reviews").document("\(self.restaurantName ?? "")").setData([
                                    "sanitizeAfter": dataDescription + 1 ,
                                ], merge: true) {err in
                                    if let err = err {
                                        print("Error writing document: \(err)")
                                    } else {
                                        print("Document successfully written!")
                                    }

                            }

            }
                    

                }
    }
                if self.touchlessTransaction.isSelected {
                    var dataDescription: Int! = 0
                    self.db.collection("Reviews").document("\(self.restaurantName ?? "")").getDocument { (document, error) in
                        if let error = error {
                            print("OH NO!!! Error fetching data: \(error.localizedDescription)")
                        }
                        if let document = document, document.exists {
                            let myData = document.data()
                            dataDescription = myData?["touchlessTransaction"] as? Int ?? 0
                              self.db.collection("Reviews").document("\(self.restaurantName ?? "")").updateData([
                                                            "touchlessTransaction": dataDescription + 1 ,
                                                        ]) {err in
                                                            if let err = err {
                                                                print("Error writing document: \(err)")
                                                            } else {
                                                                print("Document successfully written!")
                                                            }

                            }
                        }else {
                                self.db.collection("Reviews").document("\(self.restaurantName ?? "")").setData([
                                                              "touchlessTransaction": dataDescription + 1 ,
                                                          ], merge: true) {err in
                                                              if let err = err {
                                                                  print("Error writing document: \(err)")
                                                              } else {
                                                                  print("Document successfully written!")
                                                              }

                            
                            }
                }

            }
                }
            if self.shieldsBarriers.isSelected {
                             var dataDescription: Int! = 0
                             self.db.collection("Reviews").document("\(self.restaurantName ?? "")").getDocument { (document, error) in
                                 if let error = error {
                                     print("OH NO!!! Error fetching data: \(error.localizedDescription)")
                                 }
                                 if let document = document, document.exists {
                                     let myData = document.data()
                                     dataDescription = myData?["shieldsBarriers"] as? Int ?? 0
                                    self.db.collection("Reviews").document("\(self.restaurantName ?? "")").updateData([
                                                                           "shieldsBarriers": dataDescription + 1 ,
                                                                       ]) {err in
                                                                           if let err = err {
                                                                               print("Error writing document: \(err)")
                                                                           } else {
                                                                               print("Document successfully written!")
                                                                           }

                                         }

                                       
                                 }else {
                                    self.db.collection("Reviews").document("\(self.restaurantName ?? "")").setData([
                                                                           "shieldsBarriers": dataDescription + 1 ,
                                                                       ], merge: true) {err in
                                                                           if let err = err {
                                                                               print("Error writing document: \(err)")
                                                                           } else {
                                                                               print("Document successfully written!")
                                                                           }

                                         }

                                }

                         }
                         }
            
                    var dataDes: Int! = 0
                    self.db.collection("Reviews").document("\(restaurantName ?? "nil")").getDocument { (document, error) in
                        if let error = error {
                            print("OH NO!!! Error fetching data: \(error.localizedDescription)")
                        }
                        if let document = document, document.exists {
                            let myData = document.data()
                            dataDes = myData?["total"] as? Int ?? 0
                            self.db.collection("Reviews").document("\(self.restaurantName ?? "nil")").updateData([
                                "total": dataDes + 1 ,
                            ]) {err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("docc successfully written!")
       }
                            }

                        }else {
                            self.db.collection("Reviews").document("\(self.restaurantName ?? "nil")").setData([
                                "total": dataDes + 1 ,
                            ], merge: true) {err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("doc successfully written!")
                                }
                            }

                        }

            }

            

    
    self.performSegue(withIdentifier: "RatetoScoreSegue", sender: self)

                    }
}

