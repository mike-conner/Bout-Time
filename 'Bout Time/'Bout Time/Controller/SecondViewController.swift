//
//  SecondViewController.swift
//  'Bout Time
//
//  Created by Mike Conner on 11/24/18.
//  Copyright © 2018 Mike Conner. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var correctRounds: Int = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "\(correctRounds)/6"
    }
    
    @IBAction func playAgain(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
