//
//  CustomSegue.swift
//  TF
//
//  Created by AKINDE-PETERS JOSEPH on 7/25/17.
//  Copyright © 2017 AKINDE-PETERS JOSEPH. All rights reserved.
//

import UIKit

class CustomSegue : UIStoryboardSegue {
    
    override func perform() {
        
        let src = self.source
        let dest = self.destination
        
        src.view.superview?.insertSubview(dest.view, aboveSubview: src.view)
        dest.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            dest.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (Finished) in
            src.present(dest, animated: false, completion: nil)
        }
    }
    
}
