//
//  BecomeTutorBioViewController.swift
//  Tutor
//
//  Created by Javier Bustillo on 10/28/18.
//  Copyright © 2018 Javier Bustillo. All rights reserved.
//

import UIKit

class BecomeTutorBioViewController: UIViewController {

    @IBOutlet weak var bioTextView: UITextView!
    var userInfo: [String: Any]!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButton(_ sender: Any) {
        if bioTextView.text != ""{
            self.performSegue(withIdentifier: "SegueToSubjects", sender: nil)
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SegueToSubjects"{
            let bc = segue.destination as! BecomeTutorSubjectsViewController
            bc.bio = self.bioTextView.text
            bc.userInfo = self.userInfo
        }
    }
    

}
