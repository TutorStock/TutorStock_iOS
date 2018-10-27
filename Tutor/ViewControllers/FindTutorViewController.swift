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
    
    var location: String = ""
    var subject: String = ""
    var tutors: [Tutor]!
    
    var db: Firestore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TutorCell", for: indexPath)
        return cell
    }
    
    func getTutors(){
        let ref_tut_ids = db.collection("subjects_tutors_ids").whereField("subject", isEqualTo: self.subject).whereField("city", isEqualTo: self.location)
        
        var tut_ids: [String] = []
        ref_tut_ids.getDocuments { (querySnapshot, error) in
            for doc in (querySnapshot?.documents)!{
                tut_ids.append(doc.data()["id"] as! String)
            }
        }
        let ref = db.collection("tutors")
        for id in tut_ids{
            let ref = db.collection("tutors").document(id)
            ref.getDocument { (docSnapshot, error) in
                self.tutors.append(Tutor(dict: docSnapshot!.data() as! NSDictionary))
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
