//
//  SingleLoginManager.swift
//  Eduoep
//
//  Created by apple on 2020/6/3.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import GoogleSignIn

class SingleLoginManager: NSObject {
    override init() {
        
    }
    
    func setupAllLoginID() {
        GIDSignIn.sharedInstance().clientID = "734041037075-oc98hj15ie6o0q6oosjr28v5ltmqbfk5.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
    }
    
}

extension SingleLoginManager: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
        }
        return
      }
      // Perform any operations on signed in user here.
      let userId = user.userID                  // For client-side use only!
      let idToken = user.authentication.idToken // Safe to send to the server
      let fullName = user.profile.name
      let givenName = user.profile.givenName
      let familyName = user.profile.familyName
      let email = user.profile.email
      // ...
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // ...
    }
}
