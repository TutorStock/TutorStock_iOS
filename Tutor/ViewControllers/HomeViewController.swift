//
//  HomeViewController.swift
//  Tutor
//
//  Created by Javier Bustillo on 10/27/18.
//  Copyright © 2018 Javier Bustillo. All rights reserved.
//

import UIKit
import FirebaseFirestore

class HomeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    var subjects: [String] = []
    var cities: [String] = []
    var subjectPicker: UIPickerView!
    var cityPicker: UIPickerView!

    var db: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()

        getSubjects()
        getCities()
        
        subjectPicker = UIPickerView()
        subjectPicker.tag = 1
        subjectPicker.dataSource = self
        subjectPicker.delegate = self
        
        cityPicker = UIPickerView()
        cityPicker.tag = 2
        cityPicker.dataSource = self
        cityPicker.delegate = self
        
        subjectTextField.inputView = subjectPicker
        
        locationTextField.inputView = cityPicker
        // Do any additional setup after loading the view.
    }
    
    @IBAction func findTutorButton(_ sender: Any) {
        if self.locationTextField.text == ""{
            //alert user needs location
        }
        else if self.subjectTextField.text == "" {
            //alert user needs subject
        }
        else{
            self.performSegue(withIdentifier: "SegueToFind", sender: nil)
        }
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return self.subjects.count
        }
        else{
            return self.cities.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            return self.subjects[row]
        }
        else{
            return self.cities[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if pickerView.tag == 1{
            self.subjectTextField.text = self.subjects[row]
        }
        else{
            self.locationTextField.text = self.cities[row]
        }
        self.view.endEditing(true)
    }
    
    func getSubjects(){
        let ref = db.collection("subjects")
        
        ref.getDocuments { (querySnapshot, error) in
            for doc in (querySnapshot?.documents)!{
                let subject_dic = doc.data()
                self.subjects.append(subject_dic["name"] as! String)
            }
            self.subjectPicker.reloadAllComponents()
            self.subjectTextField.text = self.subjects[0]

        }
    }
    
    func getCities(){
        let ref = db.collection("cities")
        
        ref.getDocuments { (querySnapshot, error) in
            for doc in (querySnapshot?.documents)! {
                let city_dic = doc.data()
                self.cities.append(city_dic["name"] as! String)
            }
            self.cityPicker.reloadAllComponents()
            self.locationTextField.text = self.cities[0]
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SegueToFind"{
            let findTutorVC = segue.destination as! FindTutorViewController
            findTutorVC.location = self.locationTextField.text!
            findTutorVC.subject = self.subjectTextField.text!
        }
    }
    

}
