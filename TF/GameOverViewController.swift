//
//  GameOverViewController.swift
//  TF
//
//  Created by AKINDE-PETERS JOSEPH on 8/29/17.
//  Copyright © 2017 AKINDE-PETERS JOSEPH. All rights reserved.
//

import UIKit
import Lottie

class GameOverViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var coverLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    var mode : String = ""
    var correctAnswers = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        containerView.layer.cornerRadius = 4.0
        
        switch mode {
        case "success":
            coverImage.image = #imageLiteral(resourceName: "happy")
            coverLabel.text = "Great Job!"
            subLabel.text = "You answered \(correctAnswers) out of 10 questions correctly."
            break
        case "failure":
            coverImage.image = #imageLiteral(resourceName: "sad")
            coverLabel.text = "Game Over!"
            subLabel.text = "Uh oh! You lost all your lives."
            break
        default:
            print("Nothing sent")
        }
        
       
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
