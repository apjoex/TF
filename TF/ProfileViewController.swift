//
//  ProfileViewController.swift
//  TF
//
//  Created by AKINDE-PETERS JOSEPH on 7/25/17.
//  Copyright © 2017 AKINDE-PETERS JOSEPH. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet var activeProfileView: UIView!
    
    var alert : String = "" {
        didSet{
            if(alert == "Signed in"){
                print("E reach here")
                let defaults = UserDefaults.standard
                defaults.set("Saved data", forKey: "demo")
                activeProfileView.alpha = 1.0
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCreateAccountModal" {
            let newVC = segue.destination as? CreateAccountViewController
            newVC?.callback = { message in
                self.alert = message
                print("Received message is \(message)")
            }
        }
    }

}
