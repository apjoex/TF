//
//  PlayViewController.swift
//  TF
//
//  Created by AKINDE-PETERS JOSEPH on 7/25/17.
//  Copyright © 2017 AKINDE-PETERS JOSEPH. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {

	
	@IBOutlet weak var classicCard: Card!
	@IBOutlet weak var survivalCard: Card!
	@IBOutlet weak var sprintCard: Card!
	
    var category: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func startGame(_ sender: UITapGestureRecognizer) {
		
        if let tappedCard = sender.view as? Card{
			
            switch tappedCard {
            case classicCard:
                category = "football"
                performSegue(withIdentifier: "start", sender: nil)
				
            default:
                print("Default")
            }
			
        }
		
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
        if segue.identifier == "start"{
            if let vc = segue.destination as? PlayScreenViewController{
                vc.category = category
            }
        }
    }

}
