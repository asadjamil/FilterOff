//
//  LoginViewController.swift
//  FilterOff
//
//  Created by Asad Jamil on 4/30/18.
//  Copyright © 2018 Asad Jamil. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    var user: User = User()
    let defaults = UserDefaults.standard
    
    static func instantiateViewController() -> LoginViewController {
        let name = String(describing: LoginViewController.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name) as! LoginViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("Login")
    }
    
    @IBAction func howItWorkTapped(_ sender: Any) {
        let onBoardingVC = OnBoardingViewController.instantiateViewController()
        present(onBoardingVC, animated: true, completion: nil)
    }
    
    @IBAction func facebookLoginTapped(_ sender: Any) {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["email","user_photos","user_birthday"], from: self) { (result, error) in
            if error == nil {
                let fbLoginResult: FBSDKLoginManagerLoginResult = result!
                if (result?.isCancelled)! {
                    return
                }
                if fbLoginResult.grantedPermissions.contains("email") && fbLoginResult.grantedPermissions.contains("user_photos") && fbLoginResult.grantedPermissions.contains("user_birthday") {
                    self.getUserData()
                }
            }
        }
    }
    
    func getUserData() {
        if FBSDKAccessToken.current() != nil {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email, gender, age_range, birthday"]).start(completionHandler: { (connection, result, error) -> Void in
                if let err = error { //Failure
                    print(err.localizedDescription)
                } else { //Successful
                    if let result = result as? [String: Any] {
                        print(result)
                        self.user.name = result["name"] as! String
                        self.user.email = result["email"] as! String
                        self.user.facebookID = result["id"] as! String
                        
                        let ageRange = result["age_range"] as! [String: Any]
                        self.user.gender = result["gender"] as! String
                        let pictureDictionary = result["picture"] as! [String: Any]
                        let dataDictionary = pictureDictionary["data"] as! [String: Any]
                        self.user.profileImageURL = dataDictionary["url"] as! String
                        self.user.facebookToken = FBSDKAccessToken.current().tokenString as String
                        if let birthday = result["birthday"] as? String {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "MM/dd/yyyy"
                            let dob = dateFormatter.date(from: birthday)!
                            
                            var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
                            calendar.timeZone = TimeZone(identifier: "UTC")!
                            let components = calendar.dateComponents([.year], from: dob, to: Date())
                            self.user.age = components.year!
                        } else {
                            self.user.age = ageRange["min"] as! Int
                        }
                        //print(self.user.age)
                        // Set to User Defaults
                        if let encodedUserData = try? JSONEncoder().encode(self.user) {
                            self.defaults.set(encodedUserData, forKey: "encodedUserData")
                        }
                        self.defaults.synchronize()
                        let homeVC = HomeViewController.instantiateViewController()
                        self.present(homeVC, animated: true, completion: nil)
                    }
                }
            })
        }
    }
  
}
