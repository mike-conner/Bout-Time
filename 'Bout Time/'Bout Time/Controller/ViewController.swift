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
    let timerMaxTime: Int = 60
    
    
    // MARK: - Outlets
    @IBOutlet weak var questionOneLabel: UILabel!
    @IBOutlet weak var questionTwoLabel: UILabel!
    @IBOutlet weak var questionThreeLabel: UILabel!
    @IBOutlet weak var questionFourLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    
    // MARK: - Load View
    override func viewDidLoad() {
        super.viewDidLoad()
        curveLabelCorners()
        movieList.shuffleMovieList()
        updateMovieRound()
        timerButton.isEnabled = false
        timerButton.setTitle(String(timerMaxTime), for: .normal)
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }

    @IBAction func changeMovieLabelLocation(_ sender: UIButton) {
        let button = sender as UIButton
        
        switch button.tag {
        case 1, 2:
            movieList.movieArray[0...1] = [movieList.movieArray[1], movieList.movieArray[0]]
            questionOneLabel.text = movieList.movieArray[0].movieName
            questionTwoLabel.text = movieList.movieArray[1].movieName
        case 3, 4:
            movieList.movieArray[1...2] = [movieList.movieArray[2], movieList.movieArray[1]]
            questionTwoLabel.text = movieList.movieArray[1].movieName
            questionThreeLabel.text = movieList.movieArray[2].movieName
        case 5, 6:
            movieList.movieArray[2...3] = [movieList.movieArray[3], movieList.movieArray[2]]
            questionThreeLabel.text = movieList.movieArray[2].movieName
            questionFourLabel.text = movieList.movieArray[3].movieName
        default:
            print("logic error")
            return
        }
    }
    
    @IBAction func nextRound(_ sender: Any) {
        timerButton.setTitle(String(timerMaxTime), for: .normal)
        timerButton.setBackgroundImage(nil, for: .normal)
        timerButton.isEnabled = false
        
        if movieList.boutTimeRound <= movieList.maxBoutTimeRounds {
            updateMovieRound()
        } else {
            print("done")
            movieList.resetGame(movieList: movieList)
            movieList.shuffleMovieList()
            updateMovieRound()
        }
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
        var temporaryIndexIdentifier = movieList.movieArrayIndex
        questionOneLabel.text = movieList.movieArray[temporaryIndexIdentifier].movieName; temporaryIndexIdentifier += 1
        questionTwoLabel.text = movieList.movieArray[temporaryIndexIdentifier].movieName; temporaryIndexIdentifier += 1
        questionThreeLabel.text = movieList.movieArray[temporaryIndexIdentifier].movieName; temporaryIndexIdentifier += 1
        questionFourLabel.text = movieList.movieArray[temporaryIndexIdentifier].movieName; temporaryIndexIdentifier += 1
        print(movieList.boutTimeRound)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if movieList.checkOrderOfMovies(movieList: movieList) {
                timerButton.setTitle("", for: .normal)
                timerButton.setBackgroundImage(UIImage(named: "next_round_success.png"), for: .normal)
                timerButton.isEnabled = true
            } else {
                timerButton.setTitle("", for: .normal)
                timerButton.setBackgroundImage(UIImage(named: "next_round_fail.png"), for: .normal)
                timerButton.isEnabled = true
            }
        }
    }
}




