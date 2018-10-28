//
//  FindTutorViewController.swift
//  Tutor
//
//  Created by Javier Bustillo on 10/27/18.
//  Copyright © 2018 Javier Bustillo. All rights reserved.
//

import UIKit
import FirebaseFirestore

class FindTutorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var location: String = ""
    var subject: String = ""
    var tutors: [Tutor]! = []
    
    var db: Firestore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()
        tableView.dataSource = self
        tableView.delegate = self
        
        getTutors()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TutorCell", for: indexPath) as! TutorCell
        let tutor = self.tutors[indexPath.row]
        cell.nameLabel.text = tutor.getName()
        cell.subjectsLabel.text = tutor.getSubjects()
        return cell
    }
    
    func getTutors(){
        let ref_tut_ids = db.collection("subjects_tutors_ids").whereField("subject", isEqualTo: self.subject).whereField("city", isEqualTo: self.location)
        
        var tut_ids: [String] = []
        ref_tut_ids.getDocuments { (querySnapshot, error) in
            for doc in (querySnapshot?.documents)!{
                tut_ids.append(doc.data()["id"] as! String)
            }
            self.getEachTutor(tut_ids: tut_ids)
        }
        
    }
    
    func getEachTutor(tut_ids: [String]){
        var index = 0
        for id in tut_ids{
            let ref = db.collection("tutors").document(id)
            ref.getDocument { (docSnapshot, error) in
                self.tutors.append(Tutor(dict: docSnapshot!.data()! as NSDictionary))
                if index == tut_ids.count - 1{
                    self.tableView.reloadData()
                }
                index += 1
            }
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SegueToDetail"{
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let tutor = self.tutors[indexPath!.row]
            let tutorDetailVC = segue.destination as! TutorDetailViewController
            tutorDetailVC.tutor = tutor
            tutorDetailVC.subject = self.subject
        }
    }
    

}
