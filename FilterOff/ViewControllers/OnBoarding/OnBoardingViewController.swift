//
//  OnBoardingViewController.swift
//  FilterOff
//
//  Created by Asad Jamil on 5/2/18.
//  Copyright © 2018 Asad Jamil. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var walkThroughUIImageView: UIImageView!
    
    @IBOutlet weak var walkThroughLabel: UILabel!
    
    @IBOutlet weak var nextBtnLabel: UIButton!
    
    static func instantiateViewController() -> OnBoardingViewController {
        let name = String(describing: OnBoardingViewController.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: name) as! OnBoardingViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNextBtnBorder()
    }
    
    @IBAction func nextBtnTapped(_ sender: Any) {
        //print(pageControl.currentPage)
        pageControl.currentPage = pageControl.currentPage + 1
        if pageControl.currentPage == 1 {
            walkThroughUIImageView.image = UIImage(named: "wk-2.png")
            walkThroughLabel.text = "You have 60 seconds to pitch yourself live on video."
        }
        if pageControl.currentPage == 2 {
            walkThroughUIImageView.image = UIImage(named: "wk-3.png")
            walkThroughLabel.text = "After the pitch, you can decide wheather to pass or match."
            nextBtnLabel.setTitle("DONE", for: .normal)
        }
        if pageControl.currentPage == 3 {
            walkThroughUIImageView.image = UIImage(named: "wk-4.png")
            walkThroughLabel.text = "If you both give a thumbs up, you are entered into a match."
        }
        if pageControl.currentPage == 4 {
            //walkThroughUIImageView.image = UIImage(named: "wk-4.png")
            walkThroughLabel.text = "Send a video recording or video chat with them."
        }
        if pageControl.currentPage == 5 {
            //walkThroughUIImageView.image = UIImage(named: "wk-4.png")
            walkThroughLabel.text = "If you like each other, ask them out on a real date!"
            dismiss(animated: true, completion: nil)
        }
    }
    func setupNextBtnBorder() {
        nextBtnLabel.layer.borderColor = UIColor.white.cgColor
        nextBtnLabel.layer.cornerRadius = 2
        nextBtnLabel.layer.borderWidth = 2
        nextBtnLabel.clipsToBounds = true
    }
}
