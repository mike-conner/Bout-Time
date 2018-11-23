//
//  ViewController.swift
//  'Bout Time
//
//  Created by Mike Conner on 11/22/18.
//  Copyright © 2018 Mike Conner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Create Project Variables
    let movieList = MovieList()
    var round = 1
    
    
    // MARK: - Outlets
    @IBOutlet weak var questionOneLabel: UILabel!
    @IBOutlet weak var questionTwoLabel: UILabel!
    @IBOutlet weak var questionThreeLabel: UILabel!
    @IBOutlet weak var questionFourLabel: UILabel!
    
    // MARK: - Load View
    override func viewDidLoad() {
        super.viewDidLoad()
        curveLabelCorners(questionOneLabelBox: questionOneLabel, questionTwoLabelBox: questionTwoLabel, questionThreeLabelBox: questionThreeLabel, questionFourLabelBox: questionFourLabel)
        updateMovieRound()
    }

}


func curveLabelCorners(questionOneLabelBox: UILabel, questionTwoLabelBox: UILabel, questionThreeLabelBox: UILabel, questionFourLabelBox: UILabel) {
    questionOneLabelBox.clipsToBounds = true
    questionOneLabelBox.layer.cornerRadius = 3
    questionTwoLabelBox.clipsToBounds = true
    questionTwoLabelBox.layer.cornerRadius = 3
    questionThreeLabelBox.clipsToBounds = true
    questionThreeLabelBox.layer.cornerRadius = 3
    questionFourLabelBox.clipsToBounds = true
    questionFourLabelBox.layer.cornerRadius = 3
}

func updateMovieRound() {
    
}
