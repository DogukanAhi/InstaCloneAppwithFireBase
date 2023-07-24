//
//  UploadViewController.swift
//  instaCloneFireBase
//
//  Created by Doğukan Ahi on 21.07.2023.
//

import UIKit
import Firebase
import FirebaseAuth
class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
                imageView.addGestureRecognizer(imageTapRecognizer)
        
      
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            imageView.image = info[.originalImage] as? UIImage
            self.dismiss(animated: true, completion: nil)
          
        }

    @IBAction func uploadButtonClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let uuid = UUID().uuidString
        
        let mediaFolder = storageReference.child("media") // media klasorune girme firebasede
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let imageReference = mediaFolder.child("\(uuid).jpeg") // görselin referansı oluşuturma .dmg olarak kaydediyor jpeg olmasya uygulama için sıkıntı yaratabilir.
            imageReference.putData(data) { storagemetadata, error in
                
                if error != nil {
                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "Error")
                    
                }else {
                    imageReference.downloadURL { url, error in
                        
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString // url yi stringe çevirme
                         
                            let firestoreDatabese = Firestore.firestore()
                            let firestoreReference : DocumentReference?
                            
                            
                            var firestorePost = ["imageUrl": imageUrl!, "postedby":  Auth.auth().currentUser!.email,"postcomment" : self.commentField.text!,"date" :FieldValue.serverTimestamp(), "likes" : 0] as [String :Any] // DB ye kaydetmek için dictionary oluşturma
                            
                            firestoreReference = firestoreDatabese.collection("Posts").addDocument(data: firestorePost, completion: { error in // Verileri DB'ye kaydediyoruz
                                
                                if error != nil {
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "error")
                                }
                                else {
                                    
                                    self.imageView.image = UIImage(named: "upload")
                                    self.commentField.text = ""
                                    self.tabBarController?.selectedIndex = 0 // alttaki bardaki yerler 0, 1, 2 olarak gidiyor
                                }
                                
                                
                            })
                            
                            
                            
                            
                            
                            
                            
                        }
                        
                    }
                    
                    
                }
                
            }
            
            
        }
        
        
    }
    
    @objc func selectImage(){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
    
            
        }
    func makeAlert(titleInput:String,messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
        
    }
    
    
}
