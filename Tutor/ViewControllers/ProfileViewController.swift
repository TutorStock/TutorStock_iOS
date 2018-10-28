//
//  ProfileViewController.swift
//  Tutor
//
//  Created by Javier Bustillo on 10/27/18.
//  Copyright © 2018 Javier Bustillo. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var becomeTutorButton: UIButton!
    var db: Firestore!
    var userInfo: [String: Any]!
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        self.nameLabel.text = ""
        becomeTutorButton.isHidden = true
        getUserInfo()
        
        // Do any additional setup after loading the view.
    }
    
    func getUserInfo(){
        let user = Auth.auth().currentUser
        db.collection("students").document((user?.uid)!).getDocument { (docSnap, error) in
            self.userInfo = docSnap?.data()
            self.nameLabel.text = (self.userInfo["first_name"] as! String) + " " + (self.userInfo["last_name"] as! String)
            if (self.userInfo["is_tutor"] as! Bool) == false {
                self.becomeTutorButton.isHidden = false
            }
        }
    }

    @IBAction func logOutButton(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "SegueToLogin", sender: nil)
        }
        catch{
            
        }
        
    }
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SegueToBio"{
            let vc = segue.destination as! BecomeTutorBioViewController
            vc.userInfo = self.userInfo
        }
    }
    

}
