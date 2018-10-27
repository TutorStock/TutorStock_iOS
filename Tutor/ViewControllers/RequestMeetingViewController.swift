//
//  RequestMeetingViewController.swift
//  Tutor
//
//  Created by Javier Bustillo on 10/27/18.
//  Copyright © 2018 Javier Bustillo. All rights reserved.
//

import UIKit
import FirebaseFirestore

class RequestMeetingViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var messageTextField: UITextView!
    
    @IBOutlet weak var timeTextField: UITextField!
    var datePicker: UIDatePicker!
    var date: Date!
    var tutor: Tutor!
    var db: Firestore!
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        datePicker = UIDatePicker()
        showDatePicker()
        // Do any additional setup after loading the view.
    }
    
    func showDatePicker(){
        datePicker.datePickerMode = .dateAndTime
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(RequestMeetingViewController.cancelDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(RequestMeetingViewController.donedatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        timeTextField.inputAccessoryView = toolbar
        timeTextField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        timeTextField.text = formatter.string(from: datePicker.date)
        self.date = datePicker.date
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }

    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    @IBAction func requestMeetingButton(_ sender: Any) {
        let user = "sdkfj"
        let request = [
            "message": self.messageTextField.text,
            "date": self.date,
            "tutor_id": self.tutor.id,
            "user_id": user,
            ] as [String : Any]
        let ref = db.collection("requests").addDocument(data: request) { (error) in
            if error == nil{
                //segue back home
                print("done bro")
            }
        }
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
