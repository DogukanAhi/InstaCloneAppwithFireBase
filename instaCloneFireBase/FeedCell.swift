//
//  FeedCell.swift
//  instaCloneFireBase
//
//  Created by Doğukan Ahi on 21.07.2023.
//

import UIKit
import Firebase
class FeedCell: UITableViewCell {

    
    @IBOutlet weak var emaillabel: UILabel!
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var commentlabel: UILabel!
    
    @IBOutlet weak var likelabel: UILabel!
    
    @IBOutlet weak var documentIDLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
        
        let firestoreDatabase = Firestore.firestore()
        if let likeCount = Int(likelabel.text!) {
            
            let likeStore = ["likes": likeCount + 1] as [String : Any]
           
            firestoreDatabase.collection("Posts").document(documentIDLabel.text!).setData(likeStore, merge: true) // güncelleme db'de
            
          
            
        }
       
        
        
        
        
    }
    
    
    
}
