//
//  SignUpViewController.swift
//  Tutor
//
//  Created by Javier Bustillo on 10/27/18.
//  Copyright © 2018 Javier Bustillo. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class SignUpViewController: UIViewController {

  
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    var db: Firestore!
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            if error == nil{
                let user = result?.user
                let userInfo = [
                    "first_name": self.firstNameTextField.text!,
                    "last_name": self.lastNameTextField.text!,
                    "email": self.emailTextField.text!,
                    "phone_number": self.phoneNumberTextField.text!,
                    "is_tutor": false
                    ] as [String : Any]
            
                self.db.collection("students").document(user!.uid).setData(userInfo)
                self.performSegue(withIdentifier: "SegueToHome", sender: nil)
            }
            else{
                print(error)
            }
        }
    }
    
    @IBAction func canceButton(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
    @IBAction func onTap(_ sender: Any) {
        self.view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
