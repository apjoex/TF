//
//  RoundedButton.swift
//  TF
//
//  Created by AKINDE-PETERS JOSEPH on 7/25/17.
//  Copyright © 2017 AKINDE-PETERS JOSEPH. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBInspectable var rounded : Bool = false{
        didSet{
            updateCornerRadius()
        }
    }
    
    @IBInspectable var shadowRad : CGFloat? {
        didSet{
            updateLayerProperties()
        }
    }
    
    
    @IBInspectable var hasShadow : Bool = false{
        didSet{
            updateLayerProperties()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
        updateLayerProperties()
    }
    
    func updateCornerRadius(){
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
    
    func updateLayerProperties(){
        if(hasShadow){
            self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = shadowRad ?? 1.0
            self.layer.masksToBounds = false
        }
    }


}
