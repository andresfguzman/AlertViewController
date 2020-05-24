//
//  ViewController.swift
//  AlertModule
//
//  Created by Andrés Guzmán on 22/05/20.
//  Copyright © 2020 Andrés Guzmán. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func openModal(_ sender: UIButton) {
        let vc = LuloAlertViewController.instantiate(from: .alertVC)
        vc.transitioningDelegate = slideInTransitioningDelegate
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
}

