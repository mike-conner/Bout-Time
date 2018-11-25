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
    var timer: Timer!
    var roundTime: Int = 60
    var gameStatus: Bool = true
    
    
    // MARK: - Outlets
    @IBOutlet weak var questionOneLabel: UILabel!
    @IBOutlet weak var questionTwoLabel: UILabel!
    @IBOutlet weak var questionThreeLabel: UILabel!
    @IBOutlet weak var questionFourLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var questionOneDownButton: UIButton!
    @IBOutlet weak var questionTwoUpButton: UIButton!
    @IBOutlet weak var questionTwoDownButton: UIButton!
    @IBOutlet weak var questionThreeUpButton: UIButton!
    @IBOutlet weak var questionThreeDownButton: UIButton!
    @IBOutlet weak var questionFourUpButton: UIButton!
    @IBOutlet weak var timerButton: UIButton!
    
    // MARK: - Load View
    override func viewDidLoad() {
        super.viewDidLoad()
        curveLabelCorners()
        movieList.shuffleMovieList()
        startTimer()
        updateMovieRound()
        timerButton.isEnabled = false
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }

    @IBAction func changeMovieLabelLocation(_ sender: UIButton) {
        let button = sender as UIButton
        let temporaryIndexIdentifier = movieList.movieArrayIndex
        
        switch button.tag {
        case 1, 2:
            movieList.movieArray[temporaryIndexIdentifier...(temporaryIndexIdentifier + 1)] = [movieList.movieArray[(temporaryIndexIdentifier + 1)], movieList.movieArray[temporaryIndexIdentifier]]
            questionOneLabel.text = movieList.movieArray[temporaryIndexIdentifier].movieName
            questionTwoLabel.text = movieList.movieArray[(temporaryIndexIdentifier + 1)].movieName
        case 3, 4:
            movieList.movieArray[(temporaryIndexIdentifier + 1)...(temporaryIndexIdentifier + 2)] = [movieList.movieArray[(temporaryIndexIdentifier + 2)], movieList.movieArray[(temporaryIndexIdentifier + 1)]]
            questionTwoLabel.text = movieList.movieArray[(temporaryIndexIdentifier + 1)].movieName
            questionThreeLabel.text = movieList.movieArray[(temporaryIndexIdentifier + 2)].movieName
        case 5, 6:
            movieList.movieArray[(temporaryIndexIdentifier + 2)...(temporaryIndexIdentifier + 3)] = [movieList.movieArray[(temporaryIndexIdentifier + 3)], movieList.movieArray[(temporaryIndexIdentifier + 2)]]
            questionThreeLabel.text = movieList.movieArray[(temporaryIndexIdentifier + 2)].movieName
            questionFourLabel.text = movieList.movieArray[(temporaryIndexIdentifier + 3)].movieName
        default:
            fatalError()
        }
    }
    
    @IBAction func nextRound(_ sender: Any) {
        if gameStatus != true {
            performSegue(withIdentifier: "mySeque", sender: self)
            movieList.resetGame(movieList: movieList)
            movieList.shuffleMovieList()
        }
        timerButton.isEnabled = false
        timerButton.setBackgroundImage(nil, for: .normal)
        startTimer()
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
        var temporaryIndexIdentifier = movieList.movieArrayIndex
        questionOneLabel.text = movieList.movieArray[temporaryIndexIdentifier].movieName; temporaryIndexIdentifier += 1
        questionTwoLabel.text = movieList.movieArray[temporaryIndexIdentifier].movieName; temporaryIndexIdentifier += 1
        questionThreeLabel.text = movieList.movieArray[temporaryIndexIdentifier].movieName; temporaryIndexIdentifier += 1
        questionFourLabel.text = movieList.movieArray[temporaryIndexIdentifier].movieName; temporaryIndexIdentifier += 1
        questionOneDownButton.isUserInteractionEnabled = true
        questionTwoUpButton.isUserInteractionEnabled = true
        questionTwoDownButton.isUserInteractionEnabled = true
        questionThreeUpButton.isUserInteractionEnabled = true
        questionThreeDownButton.isUserInteractionEnabled = true
        questionFourUpButton.isUserInteractionEnabled = true
        informationLabel.text = "Shake to complete"
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        UIView.setAnimationsEnabled(false)
        timerButton.setTitle("\(timeFormatted(roundTime))", for: .normal)
        if roundTime != 0 {
            roundTime -= 1
        } else {
            endTimer()
            checkOrderOfMovies()
        }
    }
    
    func endTimer() {
        timer.invalidate()
        roundTime = 60
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            checkOrderOfMovies()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let finalScoreVC : SecondViewController = segue.destination as! SecondViewController
        finalScoreVC.correctRounds = movieList.correctRounds
    }
    
    func checkOrderOfMovies () {
        endTimer()
        timerButton.setTitle("", for: .normal)
        timerButton.isEnabled = true
        questionOneDownButton.isUserInteractionEnabled = false
        questionTwoUpButton.isUserInteractionEnabled = false
        questionTwoDownButton.isUserInteractionEnabled = false
        questionThreeUpButton.isUserInteractionEnabled = false
        questionThreeDownButton.isUserInteractionEnabled = false
        questionFourUpButton.isUserInteractionEnabled = false
        
        informationLabel.text = "Tap events to learn more"
        
        gameStatus = movieList.boutTimeRound < movieList.maxBoutTimeRounds
        
        if gameStatus {
            if movieList.areTheMoviesInOrder(movieList: movieList) {
                timerButton.setBackgroundImage(UIImage(named: "next_round_success.png"), for: .normal)
            } else {
                timerButton.setBackgroundImage(UIImage(named: "next_round_fail.png"), for: .normal)
            }
        } else {
            if movieList.areTheMoviesInOrder(movieList: movieList) {
                timerButton.setBackgroundImage(UIImage(named: "correct_final.png"), for: .normal)
            } else {
                timerButton.setBackgroundImage(UIImage(named: "incorrect_final.png"), for: .normal)
            }
        }
    }
}




