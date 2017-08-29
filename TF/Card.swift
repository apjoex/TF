//
//  Card.swift
//  TF
//
//  Created by AKINDE-PETERS JOSEPH on 8/3/17.
//  Copyright © 2017 AKINDE-PETERS JOSEPH. All rights reserved.
//

import UIKit

@IBDesignable class Card: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        update()
    }
    
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet{
            update()

        }
    }
    
    func update() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 1.0
        layer.shadowRadius =  1.0
        layer.masksToBounds = false
    }

}
