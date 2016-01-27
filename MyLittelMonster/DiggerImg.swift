//
//  DiggerImg.swift
//  MyLittelMonster
//
//  Created by Amr Sami on 1/27/16.
//  Copyright © 2016 Amr Sami. All rights reserved.
//

import Foundation
import UIKit

class DiggerImg: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        playIdelAnimation()
    }
    
    func playIdelAnimation() {
        
        self.image = UIImage(named: "idle (1).png")
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        for var i = 1; i <= 4; i++ {
            let img = UIImage(named: "idle (\(i)).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func playDeathAnimation() {
        
        self.image = UIImage(named: "hide (6).png")
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        for var i = 1; i <= 6; i++ {
            let img = UIImage(named: "hide (\(i)).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
    func playReverseDeathAnimation() {
        
        self.image = UIImage(named: "hide (6).png")
        
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        for var i = 1; i <= 6; i++ {
            let img = UIImage(named: "appear (\(i)).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
}