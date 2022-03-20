//
//  AboutMeViewController.swift
//  LoginApp
//
//  Created by Andrey Zhivotov on 20.03.2022.
//

import UIKit

class AboutMeViewController: UIViewController {

    @IBOutlet var userInfoLabel: UILabel!
    
    var userInfo = ""
    
    var titleOfUser = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleOfUser
        userInfoLabel.text = userInfo
    }
    
    
}
