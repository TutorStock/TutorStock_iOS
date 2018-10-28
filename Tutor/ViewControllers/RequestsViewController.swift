
//
//  RequestsViewController.swift
//  Tutor
//
//  Created by Javier Bustillo on 10/27/18.
//  Copyright © 2018 Javier Bustillo. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class RequestsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var db: Firestore!
    var requests: [Request] = []
    var isTutor: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        tableView.delegate = self
        tableView.dataSource = self
        getRequests()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell", for: indexPath) as! RequestCell
        let request = self.requests[indexPath.row]
        cell.nameLabel.text = request.name
        cell.subjectLabel.text = request.subject
        cell.dateTimeLabel.text = request.getDate() // TODO: format date
        return cell
    }
    
    func getRequests(){
        let user = Auth.auth().currentUser
        var ref = db.collection("requests").whereField("user_id", isEqualTo: user?.uid)
        ref.addSnapshotListener { (querySnapshot, error) in
            for doc in (querySnapshot?.documents)!{
                self.requests.append(Request(dict: doc.data() as NSDictionary))
            }
            self.requests = self.requests.sorted(by: { $0.date < $1.date })
            self.tableView.reloadData()
        }
        ref = db.collection("requests").whereField("tutor_id", isEqualTo: user?.uid)
        ref.addSnapshotListener { (querySnapshot, error) in
            for doc in (querySnapshot?.documents)! {
                self.requests.append(Request(dict: doc.data() as NSDictionary))
            }
            self.requests = self.requests.sorted(by: { $0.date < $1.date })
            self.tableView.reloadData()
        }
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let request = self.requests[indexPath!.row]
        let requestDetailVC = segue.destination as! RequestDetailViewController
        requestDetailVC.request = request
    }
 

}
