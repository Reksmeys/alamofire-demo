//
//  ReadVC.swift
//  Consume
//
//  Created by រស្មី on 28/10/22.
//

import UIKit

class ReadVC: UIViewController {
    
    var albumTitle: String?
    var welcomeMessage: String?
    var urlImage: String?
    
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var thumnailImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Description"

        
        if let albumTitle = albumTitle {
            descLabel.text = albumTitle
        }
        if let welcomeMessage = welcomeMessage {
            welcomeLabel.text = welcomeMessage
        }
        if let urlImage = urlImage {
            thumnailImageView.loadFrom(URLAddress: urlImage)
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
