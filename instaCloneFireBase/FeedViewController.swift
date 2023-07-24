//
//  FeedViewController.swift
//  instaCloneFireBase
//
//  Created by Doğukan Ahi on 21.07.2023.
//
import UIKit
import Firebase
import SDWebImage
class FeedViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableview: UITableView!
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    
    var documentIDArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.rowHeight = 500
        getDataFromFireStore()
    }
    
    func getDataFromFireStore() {
        
        let fireStoreDataBase = Firestore.firestore()
       
       
        fireStoreDataBase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            
            if error != nil {
            
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                
            }
            else {
                
                for document in snapshot!.documents {
                    let documentID = document.documentID
                    
                    
                    self.documentIDArray.append(documentID)
                    
                    if let postedby = document.get("postedby") as? String{
                        self.userEmailArray.append(postedby)
                        
                        if let postcommet = document.get("postcomment") as? String {
                            self.userCommentArray.append(postcommet)
                            
                            if let imageurl = document.get("imageUrl") as? String {
                                self.userImageArray.append(imageurl)
                                
                                if let likes = document.get("likes") as? Int {
                                    self.likeArray.append(likes)
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
               
                self.tableview.reloadData()
                
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell // tanımladığımız celli gösterme imageviewli olan
        
        cell.emaillabel.text = userEmailArray[indexPath.row]
        cell.likelabel.text = String(likeArray[indexPath.row])
        cell.commentlabel.text = userCommentArray[indexPath.row]
        cell.imageview.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell.documentIDLabel.text = documentIDArray[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    func makeAlert(titleInput:String,messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
        
    }
}
