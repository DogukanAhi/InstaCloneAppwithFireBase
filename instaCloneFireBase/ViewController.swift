//
//  ViewController.swift
//  instaCloneFireBase
//
//  Created by Doğukan Ahi on 20.07.2023.
//

import UIKit
import Firebase
import FirebaseAuth
class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBOutlet weak var paswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    
    
    @IBAction func signinClicked(_ sender: Any) {

        if emailField.text != nil && paswordField.text != nil {
            Auth.auth().signIn(withEmail: emailField.text!, password: paswordField.text!) { authdata, error in // Signin metodu
                
                if error != nil {
                    
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                    self.emailField.text = nil
                    self.paswordField.text = nil
                }
                else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    
                }
                
            }
            
        }


    }
    
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailField.text != nil && paswordField.text != nil {
            Auth.auth().createUser(withEmail: emailField.text!, password: paswordField.text!) { authdata, error in //burda iki tane output veriyo eskiler  authdata ve error kullanıcı oluşturuyoruz
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error") // localize olan firebase errorleri
                    
                    
                } else {
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    
                }
                
            }
            
            
            
        }
        else {
            makeAlert(titleInput: "Error", messageInput: "Please enter username and password.")
        }
        
    }
    func makeAlert(titleInput:String,messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
        
    }
}
