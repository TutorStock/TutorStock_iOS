//
//  LogInViewController.swift
//  Tutor
//
//  Created by Javier Bustillo on 10/27/18.
//  Copyright © 2018 Javier Bustillo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        isSignedIn()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let user = Auth.auth().currentUser
        if user != nil{
            self.performSegue(withIdentifier: "SegueToHome", sender: nil)
        }
    }
    
    @IBAction func signInButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error == nil{
                self.performSegue(withIdentifier: "SegueToHome", sender: nil)
            }
        }

    }
    func isSignedIn(){
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: "SegueToHome", sender: nil)
            }
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
