//
//  Storyboard.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import UIKit

enum Storyboards: String {
    case main = "Main"
    case alertVC = "AlertViewController"
}

protocol Storyboard {
    static func instantiate(from storyboard: Storyboards) -> Self
}

extension Storyboard where Self: UIViewController {
    static func instantiate(from storyboard: Storyboards) -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
