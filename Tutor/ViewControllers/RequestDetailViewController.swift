//
//  RequestDetailViewController.swift
//  Tutor
//
//  Created by Javier Bustillo on 10/27/18.
//  Copyright © 2018 Javier Bustillo. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class RequestDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var approvalStatusLabel: UILabel!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var ratingButton: UIButton!
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    var request: Request!
    var db: Firestore!
    var approval: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        db = Firestore.firestore()
        ratingButton.isHidden = true
        emailLabel.isHidden = true
        phoneLabel.isHidden = true
        
        nameLabel.text = request.name
        subjectLabel.text = request.subject
        dateTimeLabel.text = request.getDate()
        messageLabel.text = request.message
        getApproval()
        if request.tutor_id != user?.uid{
            approveButton.isHidden = true
            rejectButton.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func approveButton(_ sender: Any) {
        self.db.collection("requests").document(self.request.id).updateData(["approval": 1])
    }
    
    @IBAction func rejectButton(_ sender: Any) {
        self.db.collection("requests").document(self.request.id).updateData(["approval": -1])
        
    }
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    func getApproval(){
        db.collection("requests").document(self.request.id).addSnapshotListener { (docSnap, error) in
            if error == nil {
                let approval = docSnap?.data()!["approval"] as! Int
                if approval == 0 {
                    self.approvalStatusLabel.text = "Waiting for tutor to review"
                }
                else if approval == 1 {
                    let user = Auth.auth().currentUser
                    self.approvalStatusLabel.text = "Tutor has approved the meeting"
                    if self.request.tutor_id != user?.uid{
                        self.approvalStatusLabel.text = "Tutor has approved the meeting.\nYou will be contacted soon by the tutor."
                        self.ratingButton.isHidden = false
                    }
                    else{
                        self.setStudentInfo()
                    }
                }
                else if approval == -1 {
                    self.approvalStatusLabel.text = "Tutor has rejected meeting"
                }
                self.approval = approval
            }
        }
    }
    
    func setStudentInfo(){
        db.collection("students").document(self.request.user_id).getDocument { (docSnap, error) in
            if error == nil {
                self.emailLabel.text = docSnap?.data()!["email"] as! String
                self.phoneLabel.text = docSnap?.data()!["phone_number"] as! String
                self.emailLabel.isHidden = false
                self.phoneLabel.isHidden = false
            }
        }
    }
    
    @IBAction func ratingButton(_ sender: Any) {
        self.performSegue(withIdentifier: "SegueToRating", sender: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SegueToRating"{
            let vc = segue.destination as! RatingViewController
            vc.tutor_id = self.request.tutor_id
        }
    }
    

}
