//
//  CGRectEx.swift
//  SubmitTransition
//
//  Created by Takuya Okamoto on 2015/08/07.
//  Copyright (c) 2015年 Uniface. All rights reserved.
//

import UIKit

extension CGRect {
    var x: CGFloat {
        get {
            return self.origin.x
        }
        set {
//            self = CGRectMake(newValue, self.y, self.width, self.height)
            self = CGRect(x: newValue, y: self.y, width: self.width, height: self.height)
        }
    }
    
    var y: CGFloat {
        get {
            return self.origin.y
        }
        set {
//            self = CGRectMake(self.x, newValue, self.width, self.height)
            self = CGRect(x: self.x, y: newValue, width: self.width, height: self.height)
        }
    }
    
    var width: CGFloat {
        get {
            return self.size.width
        }
        set {
//            self = CGRectMake(self.x, self.y, newValue, self.height)
            self = CGRect(x: self.x, y: self.y, width: newValue, height: self.height)
        }
    }
    
    var height: CGFloat {
        get {
            return self.size.height
        }
        set {
//            self = CGRectMake(self.x, self.y, self.width, newValue)
            self = CGRect(x: self.x, y: self.y, width: self.width, height: newValue)
        }
    }
    
    
    var top: CGFloat {
        get {
            return self.origin.y
        }
        set {
            y = newValue
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.origin.y + self.size.height
        }
        set {
//            self = CGRectMake(x, newValue - height, width, height)
            self = CGRect(x: x, y: newValue - height, width: width, height: height)
        }
    }
    
    var left: CGFloat {
        get {
            return self.origin.x
        }
        set {
            self.x = newValue
        }
    }
    
    var right: CGFloat {
        get {
            return x + width
        }
        set {
//            self = CGRectMake(newValue - width, y, width, height)
            self = CGRect(x: newValue - width, y: y, width: width, height: height)
        }
    }
    
    
    var midX: CGFloat {
        get {
            return self.x + self.width / 2
        }
        set {
//            self = CGRectMake(newValue - width / 2, y, width, height)
            self = CGRect(x: newValue - width / 2, y: y, width: width, height: height)
        }
    }
    
    var midY: CGFloat {
        get {
            return self.y + self.height / 2
        }
        set {
//            self = CGRectMake(x, newValue - height / 2, width, height)
            self = CGRect(x: x, y: newValue - height / 2, width: width, height: height)
        }
    }
    

    var center: CGPoint {
        get {
//            return CGPointMake(self.midX, self.midY)
            return CGPoint(x: self.midX, y: self.midY)
        }
        set {
            self = CGRect(x: newValue.x - width / 2, y: newValue.y - height / 2, width: width, height: height)
        }
    }
}
