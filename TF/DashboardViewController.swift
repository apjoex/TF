//
//  DashboardViewController.swift
//  TF
//
//  Created by AKINDE-PETERS JOSEPH on 7/25/17.
//  Copyright © 2017 AKINDE-PETERS JOSEPH. All rights reserved.
//

import UIKit
import AZTabBar
import EasyNotificationBadge

class DashboardViewController: UIViewController {
    
    
    //var tabController : AZTabBarController
    var icons = ["play_outline","board_outline","profile_outline"]
    var selectedIcons = ["play_filled","board_filled","profile_filled"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
        let tabController = AZTabBarController.insert(into: self, withTabIconNames: icons, andSelectedIconNames: selectedIcons)
        
        let firstViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "first_view")
        let secondViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "second_view")
        let thirdViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "third_view")
        
        tabController.set(viewController: firstViewController, atIndex: 0)
        tabController.set(viewController: secondViewController, atIndex: 1)
        tabController.set(viewController: thirdViewController, atIndex: 2)

        tabController.buttonsBackgroundColor = UIColor.white
        tabController.selectionIndicatorHeight = 0


        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
