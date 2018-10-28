//
//  BecomeTutorSubjectsViewController.swift
//  Tutor
//
//  Created by Javier Bustillo on 10/28/18.
//  Copyright © 2018 Javier Bustillo. All rights reserved.
//

import UIKit
import FirebaseFirestore

class BecomeTutorSubjectsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var bio: String!
    var userInfo: [String:Any]!
    var db: Firestore!
    var subjects: [String] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        tableView.allowsMultipleSelectionDuringEditing = true
        getSubjects()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityCell
        
        cell.subjectLabel.text = self.subjects[indexPath.row]
        return cell
    }
    
    
    func getSubjects(){
        self.db.collection("subjects").getDocuments { (querySnapshot, error) in
            for doc in (querySnapshot?.documents)!{
                self.subjects.append(doc.data()["name"] as! String)
            }
            self.tableView.reloadData()
        }
    }
    

    @IBAction func doneButton(_ sender: Any) {
        if self.tableView.indexPathsForSelectedRows?.count != 0 {
            self.performSegue(withIdentifier: "SegueToCity", sender: nil)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SegueToCity"{
            let vc = segue.destination as! BecomeTutorCityViewController
            var selectedSubjects: [String] = []
            for indexPath in self.tableView!.indexPathsForSelectedRows!{
                selectedSubjects.append(self.subjects[indexPath.row])
            }
            vc.selectedSubjects = selectedSubjects
            vc.bio = self.bio
            vc.userInfo = self.userInfo
        }
    }
    

}
