//
//  HomeViewController.swift
//  FilterOff
//
//  Created by Asad Jamil on 5/3/18.
//  Copyright © 2018 Asad Jamil. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var user: User!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var howDoesItWorkBtn: UIButton!
    static func instantiateViewController() -> HomeViewController {
        let name = String(describing: HomeViewController.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name) as! HomeViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImageView.layer.cornerRadius = 75
        userImageView.clipsToBounds = true
        if let encodedUserData = defaults.data(forKey: "encodedUserData"),
            let encodedUser = try? JSONDecoder().decode(User.self, from: encodedUserData) {
            //print(encodedUser.name)
            user = encodedUser
            userImageView.af_setImage(withURL: URL(string: user.profileImageURL)!)
        }
    }
    
    @IBAction func howDoesItWorkedTapped(_ sender: Any) {
        let onBoardingVC = OnBoardingViewController.instantiateViewController()
        present(onBoardingVC, animated: true, completion: nil)
    }
    
}
