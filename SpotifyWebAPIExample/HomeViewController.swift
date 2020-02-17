//
//  HomeViewController.swift
//  SpotifyWebAPIExample
//
//  Created by Riccardo Runci on 13/02/2020.
//  Copyright © 2020 Riccardo Runci. All rights reserved.
//

import UIKit
import SpotifyWebAPI
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SpotifyAPI.v1.userProfile.getCurrentUserProfile { (userProfile, error) in
            
            if let user = userProfile{
                // refresh token success, you can call any API
                self.nameLabel.text = user.displayName ?? ""
                self.emailLabel.text = user.email ?? ""
                self.followersLabel.text = "Followers: " + (user.followers?.total.description ?? "0")
                self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
                if(user.images.count > 0){
                    self.profileImage.sd_setImage(with: URL(string: user.images[0].url), completed: nil)
                }
                
            }
            else{
                // refresh token failed
                // user must authenticate again
                self.nameLabel.text = "Something gone wrong!"
            }
        }
    }
    
}

