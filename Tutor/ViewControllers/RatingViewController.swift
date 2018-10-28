//
//  RatingViewController.swift
//  Tutor
//
//  Created by Javier Bustillo on 10/28/18.
//  Copyright © 2018 Javier Bustillo. All rights reserved.
//

import UIKit
import Cosmos
import FirebaseFirestore

class RatingViewController: UIViewController{

    @IBOutlet weak var cosmosView: CosmosView!
    var db: Firestore!
    var tutor_id: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
        
        cosmosView.didFinishTouchingCosmos = {
            rating in
            let rating = [
                "tutor_id": self.tutor_id,
                "rating": rating
                ] as [String : Any]
            self.db.collection("ratings").addDocument(data: rating, completion: { (error) in
                self.dismiss(animated: true, completion: {
                    
                })
            })
            
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true) {
            
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
