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
    var movieGame = MovieGame()
    var timer: Timer!
    var roundTime: Int = 60

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
        movieGame.shufflemovieGame()
        updateMovieRound()
        timerButton.isEnabled = false
    }
    
    // MARK: - Override functions
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let finalScoreVC : SecondViewController = segue.destination as? SecondViewController else {
            return
        }
        finalScoreVC.correctRounds = movieGame.numberOfCorrectRounds
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            checkOrderOfMovies()
        }
    }

    // MARK: - IBActions
    @IBAction func changeMovieLabelLocation(_ sender: UIButton) {
//        let button = sender as UIButton
        let temporaryIndexIdentifier = movieGame.currentMovieArrayIndexLocation
        
        switch sender.tag {
        case 1, 2:
            updateLabel(top: temporaryIndexIdentifier, bottom: temporaryIndexIdentifier + 1, firstLabel: questionOneLabel, secondLabel: questionTwoLabel)
        case 3, 4:
            updateLabel(top: temporaryIndexIdentifier + 1, bottom: temporaryIndexIdentifier + 2, firstLabel: questionTwoLabel, secondLabel: questionThreeLabel)
        case 5, 6:
            updateLabel(top: temporaryIndexIdentifier + 2, bottom: temporaryIndexIdentifier + 3, firstLabel: questionThreeLabel, secondLabel: questionFourLabel)
        default:
            // Default condition not possible.
            break
        }
    }
    
    @IBAction func nextRound(_ sender: Any) {
        if movieGame.gameStatus != true {
            performSegue(withIdentifier: "mySeque", sender: self)
            movieGame.resetGame()
            movieGame.shufflemovieGame()
        }
        timerButton.isEnabled = false
        timerButton.setBackgroundImage(nil, for: .normal)
        updateMovieRound()
    }
    
    // MARK: - Timer Functionality
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
    
    // MARK: - Functions
    func updateMovieRound() {
        var temporaryIndexIdentifier = movieGame.currentMovieArrayIndexLocation
        questionOneLabel.text = movieGame.movieArray[temporaryIndexIdentifier].name; temporaryIndexIdentifier += 1
        questionTwoLabel.text = movieGame.movieArray[temporaryIndexIdentifier].name; temporaryIndexIdentifier += 1
        questionThreeLabel.text = movieGame.movieArray[temporaryIndexIdentifier].name; temporaryIndexIdentifier += 1
        questionFourLabel.text = movieGame.movieArray[temporaryIndexIdentifier].name; temporaryIndexIdentifier += 1
        updateUserButtonStatus(isAccessable: true)
        startTimer()
    }
    
    func checkOrderOfMovies() {
        endTimer()
        timerButton.setTitle("", for: .normal)
        timerButton.isEnabled = true
        updateUserButtonStatus(isAccessable: false)
        
        movieGame.gameStatus = movieGame.currentRound < movieGame.maxRounds
        
        if movieGame.gameStatus {
            if movieGame.areTheMoviesInOrder() {
                timerButton.setBackgroundImage(UIImage(named: "next_round_success.png"), for: .normal)
            } else {
                timerButton.setBackgroundImage(UIImage(named: "next_round_fail.png"), for: .normal)
            }
        } else {
            if movieGame.areTheMoviesInOrder() {
                timerButton.setBackgroundImage(UIImage(named: "correct_final.png"), for: .normal)
            } else {
                timerButton.setBackgroundImage(UIImage(named: "incorrect_final.png"), for: .normal)
            }
        }
    }
    
    func updateUserButtonStatus(isAccessable: Bool) {
        questionOneDownButton.isUserInteractionEnabled = isAccessable
        questionTwoUpButton.isUserInteractionEnabled = isAccessable
        questionTwoDownButton.isUserInteractionEnabled = isAccessable
        questionThreeUpButton.isUserInteractionEnabled = isAccessable
        questionThreeDownButton.isUserInteractionEnabled = isAccessable
        questionFourUpButton.isUserInteractionEnabled = isAccessable
        
        if isAccessable {
            informationLabel.text = "Shake to complete"
        } else {
            informationLabel.text = "Tap events to learn more is currently not functional!"
        }
    }
    
    func updateLabel(top: Int, bottom: Int, firstLabel: UILabel, secondLabel: UILabel) {
        movieGame.movieArray[top...bottom] = [movieGame.movieArray[bottom], movieGame.movieArray[top]]
        firstLabel.text = movieGame.movieArray[top].name
        secondLabel.text = movieGame.movieArray[bottom].name
    }
}




