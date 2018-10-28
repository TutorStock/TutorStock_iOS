//
//  TutorDetailViewController.swift
//  Tutor
//
//  Created by Javier Bustillo on 10/27/18.
//  Copyright © 2018 Javier Bustillo. All rights reserved.
//

import UIKit

class TutorDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subjectsLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var tutor: Tutor!
    var subject: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameLabel.text = tutor.getName()
        self.subjectsLabel.text = tutor.getSubjects()
        self.bioLabel.text = tutor.bio
        self.timeLabel.text = tutor.time
        self.priceLabel.text = tutor.getPrice()
        if tutor.rating == -1{
            self.ratingLabel.text = "No reviews yet"
        }
        else{
            self.ratingLabel.text = "\(tutor.rating!)/5"
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func requestButton(_ sender: Any) {
        self.performSegue(withIdentifier: "SegueToRequest", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SegueToRequest"{
            let requestMeetingVC = segue.destination as! RequestMeetingViewController
            requestMeetingVC.tutor = self.tutor
            requestMeetingVC.subject = self.subject
        }
    }
    
    

}
