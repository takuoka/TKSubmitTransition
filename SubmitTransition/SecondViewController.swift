//
//  SecondViewController.swift
//  SubmitTransition
//
//  Created by Takuya Okamoto on 2015/08/07.
//  Copyright (c) 2015年 Uniface. All rights reserved.
//


import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bg = UIImageView(image: UIImage(named: "Home"))
        bg.frame = self.view.frame
        self.view.addSubview(bg)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.onTapScreen))
        bg.isUserInteractionEnabled = true
        bg.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func onTapScreen() {
        self.dismiss(animated: true, completion: nil)
    }
}

