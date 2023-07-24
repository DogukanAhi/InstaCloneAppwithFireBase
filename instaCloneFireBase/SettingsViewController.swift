//
//  SettingsViewController.swift
//  instaCloneFireBase
//
//  Created by Doğukan Ahi on 21.07.2023.
//

import UIKit
import Firebase
import FirebaseAuth
class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func LogoutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        }catch {
            print("error!")
        }
        
       
    }
    

}
