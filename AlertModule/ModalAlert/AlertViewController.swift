//
//  AlertViewController.swift
//  AlertModule
//
//  Created by Andrés Guzmán on 22/05/20.
//  Copyright © 2020 Andrés Guzmán. All rights reserved.
//

import UIKit

class AlertViewController: ViewController, Storyboard {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
