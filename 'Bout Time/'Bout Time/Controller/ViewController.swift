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
    
    
    // MARK: - Outlets
    @IBOutlet weak var questionOneLabel: UILabel!
    @IBOutlet weak var questionTwoLabel: UILabel!
    @IBOutlet weak var questionThreeLabel: UILabel!
    @IBOutlet weak var questionFourLabel: UILabel!
    
    
    // MARK: - Load View
    override func viewDidLoad() {
        super.viewDidLoad()
        curveLabelCorners()
        movieList.shuffleMovieList()
        updateMovieRound()
    }

    func curveLabelCorners() {
        questionOneLabel.clipsToBounds = true
        questionOneLabel.layer.cornerRadius = 3
        questionTwoLabel.clipsToBounds = true
        questionTwoLabel.layer.cornerRadius = 3
        questionThreeLabel.clipsToBounds = true
        questionThreeLabel.layer.cornerRadius = 3
        questionFourLabel.clipsToBounds = true
        questionFourLabel.layer.cornerRadius = 3
    }
    
    func updateMovieRound() {
        questionOneLabel.text = movieList.movieArray[movieList.movieArrayIndex].movieName; movieList.movieArrayIndex += 1
        questionTwoLabel.text = movieList.movieArray[movieList.movieArrayIndex].movieName; movieList.movieArrayIndex += 1
        questionThreeLabel.text = movieList.movieArray[movieList.movieArrayIndex].movieName; movieList.movieArrayIndex += 1
        questionFourLabel.text = movieList.movieArray[movieList.movieArrayIndex].movieName; movieList.movieArrayIndex += 1
    }
}




