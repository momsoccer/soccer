//
//  MenuViewController.swift
//  soccer
//
//  Created by 심성보 on 2017. 1. 11..
//  Copyright © 2017년 심성보. All rights reserved.
//

import UIKit
import ENSwiftSideMenu

class MenuViewController: ENSideMenuNavigationController, ENSideMenuDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let menu = storyBoard.instantiateViewController(withIdentifier: "MenuTableViewController") as! MenuTableViewController
        
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController:menu, menuPosition:ENSideMenuPosition.left)
        sideMenu?.menuWidth = 270.0
        view.bringSubview(toFront: navigationBar)
    }
    
}
