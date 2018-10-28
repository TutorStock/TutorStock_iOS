//
//  BecomeTutorCityViewController.swift
//  Tutor
//
//  Created by Javier Bustillo on 10/28/18.
//  Copyright © 2018 Javier Bustillo. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class BecomeTutorCityViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var moneyTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    
    var selectedSubjects: [String]!
    var bio: String!
    var cityPicker: UIPickerView!
    var cities: [String] = []
    var userInfo: [String:Any]!
    var db: Firestore!
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        cityPicker = UIPickerView()
        cityPicker.dataSource = self
        cityPicker.delegate = self
        cityTextField.inputView = cityPicker
        
        getCities()
        // Do any additional setup after loading the view.
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        self.cityTextField.text = self.cities[row]
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func doneButton(_ sender: Any) {
        let user = Auth.auth().currentUser
        if timeTextField.text != "" && moneyTextField.text != "" && cityTextField.text != ""{
            let tutor = [
                "first_name": self.userInfo["first_name"],
                "last_name": self.userInfo["last_name"],
                "phone_number": self.userInfo["phone_number"],
                "email": self.userInfo["email"],
                "time_available": timeTextField.text!,
                "price": Int(moneyTextField.text!),
                "subjects": self.selectedSubjects,
                "tutor_id": user?.uid,
                "city": cityTextField.text!,
                "bio": bio,
            ]
            
            db.collection("tutors").document((user?.uid)!).setData(tutor as [String : Any]) { (error) in
                if error == nil {
                    for subject in self.selectedSubjects{
                        let sub_id = [
                            "id": user?.uid,
                            "subject": subject,
                            "city": self.cityTextField.text!
                            ] as [String : Any]
                        self.db.collection("subjects_tutors_ids").addDocument(data: sub_id, completion: { (error) in
                            if error == nil{
                            }
                        })
                    }
                    self.performSegue(withIdentifier: "SegueToHome", sender: nil)
                    //performsegue home
                    //you are now a tutor
                }
            }
        }
        else{
            //alert empty fields
        }
    }
    func getCities(){
        db.collection("cities").getDocuments { (querySnapshot, error) in
            for doc in (querySnapshot?.documents)!{
                self.cities.append(doc.data()["name"] as! String)
            }
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
    }
    

}
