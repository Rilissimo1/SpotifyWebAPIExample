//
//  ViewController.swift
//  SpotifyWebAPIExample
//
//  Created by Riccardo Runci on 09/02/2020.
//  Copyright © 2020 Riccardo Runci. All rights reserved.
//

import UIKit
import SpotifyWebAPI
import Alamofire
import SafariServices
import AuthenticationServices


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        SpotifyAPI.v1.auth.configuration = AuthorizationServiceConfiguration(clientId: "{YOUR CLIENT ID}", clientSecret: "{YOUR CLIENT SECRET}", redirectUri: "{YOUR REDIRECT URI}", scopes: [Scopes.user_read_private, Scopes.user_read_email, Scopes.user_follow_read, Scopes.user_top_read, Scopes.user_library_read])

        self.checkSession()
    }
    
    private func presentHomepage(){
        DispatchQueue.main.async {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
            vc!.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true, completion: nil)
        }

    }
    
    private func authenticate(){
        SpotifyAPI.v1.auth.authenticate() { (newToken, errorResponse) in
            
            if let error = errorResponse{
                //Something gone wrong
                print(error)
                return
            }
            
            guard let accessToken = newToken else {
                //invalid access token
                return
            }
            self.presentHomepage()
            
        }
    }
    
    private func checkSession(){
        SpotifyAPI.v1.auth.checkIfSessionIsExpired { (expired) in
            if(expired){
                SpotifyAPI.v1.auth.refreshToken { (newAccessToken, errorResponse) in
                    if let accessToken = newAccessToken{
                        // refresh token success, you can call any API
                        self.presentHomepage()
                    }
                    else{
                        // refresh token failed
                        // user must authenticate again
                        self.authenticate()
                    }
                }
            }
            else{
                // the session is valid, you can call any API
                self.presentHomepage()
            }
        }
    }
}
