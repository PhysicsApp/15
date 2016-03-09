//
//  CardView.swift
//  Fifteen
//
//  Created by Ricardo Lopez Focil on 09/03/16.
//  Copyright © 2016 Ricardo Lopez Focil. All rights reserved.
//

import UIKit

@objc protocol CardTouchingProtocol{
    func cardTouched(card : CardView)
}


@objc class CardView: UIView {

    var value : Int = 0
    
    private let label = UILabel()
    private let imageView = UIImageView(image: UIImage(named: "card")!)
    
    var hidesValue = true
    
    weak var delegate : CardTouchingProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }
    
    private func loadView(){
        self.addSubview(label)
        self.addSubview(imageView)
        
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 3
        
        self.label.frame.size = self.frame.size
        self.label.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        self.label.autoresizesSubviews = true
        
        self.imageView.frame.size = self.frame.size
        self.imageView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        self.imageView.autoresizesSubviews = true
        self.imageView.userInteractionEnabled = true
        self.setHiddenValue(true, animated : false)
        
        let gr = UITapGestureRecognizer(target: self, action: "tap")
        self.addGestureRecognizer(gr)
    }
    
    func tap(){
        self.delegate?.cardTouched(self)
    }
    
    func isHidingValue()->Bool{
        return hidesValue
    }
    
    func setHiddenValue(flag : Bool, animated : Bool){
        let f : ()->() = {
            self.imageView.hidden = !self.hidesValue
        }
        self.hidesValue = flag
        if animated{
            UIView.animateWithDuration(1, animations: f)
        }
        else{
            f()
        }
    }
    
    func loadWithString(str : String){
        self.label.text = str
    }
    
}
