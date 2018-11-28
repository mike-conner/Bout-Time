//
//  Movie.swift
//  'Bout Time
//
//  Created by Mike Conner on 11/23/18.
//  Copyright © 2018 Mike Conner. All rights reserved.
//

import Foundation

// Each movie has a name and a year it was released.
struct Movie {
    var name: String
    var year: Int
}

class MovieGame {
    let maxRounds: Int = 6
    var currentRound: Int = 1
    var numberOfCorrectRounds: Int = 0
    var numberOfIncorrectRounds: Int = 0
    var currentMovieArrayIndexLocation: Int = 0
    var gameStatus: Bool = true
    
    var movieArray: [Movie] = [
        Movie(name: "Hercules in New York", year: 1969),
        Movie(name: "The Long Goodbye", year: 1973),
        Movie(name: "Stay Hungry", year: 1976),
        Movie(name: "The Villain", year: 1979),
        Movie(name: "Conan the Barbarian", year: 1982),
        Movie(name: "The Terminator", year: 1984),
        Movie(name: "Commando", year: 1985),
        Movie(name: "Raw Deal", year: 1986),
        Movie(name: "The Running Man", year: 1987),
        Movie(name: "Twins", year: 1988),
        Movie(name: "Total Recall", year: 1990),
        Movie(name: "Terminator 2: Judgment Day", year: 1991),
        Movie(name: "Last Action Hero", year: 1993),
        Movie(name: "True Lies", year: 1994),
        Movie(name: "Eraser", year: 1996),
        Movie(name: "Batman & Robin", year: 1997),
        Movie(name: "End of Days", year: 1999),
        Movie(name: "The 6th Day", year: 2000),
        Movie(name: "Dr. Dolittle 2", year: 2001),
        Movie(name: "Collateral Damage", year: 2002),
        Movie(name: "The Rundown", year: 2003),
        Movie(name: "Around the World in 80 Days", year: 2004),
        Movie(name: "The Kid & I", year: 2005),
        Movie(name: "The Expendables", year: 2010),
        Movie(name: "The Expendables 2", year: 2012),
        Movie(name: "Escape Plan", year: 2013),
        Movie(name: "Sabotage", year: 2014),
        Movie(name: "Maggie", year: 2015),
        Movie(name: "Aftermath", year: 2017),
        Movie(name: "Viy 2: Journey to China", year: 2019)]
    
    // Function to shuffle the order of movies in the game.
    func shufflemovieGame () {
        movieArray.shuffle()
    }
    
    func areTheMoviesInOrder() -> Bool {
        var isTheUserCorrect = false
        
        if  self.movieArray[currentMovieArrayIndexLocation].year < self.movieArray[currentMovieArrayIndexLocation + 1].year && self.movieArray[currentMovieArrayIndexLocation + 1].year < self.movieArray[currentMovieArrayIndexLocation + 2].year && self.movieArray[currentMovieArrayIndexLocation + 2].year < self.movieArray[currentMovieArrayIndexLocation + 3].year {
            numberOfCorrectRounds += 1
            isTheUserCorrect = true
        } else {
            numberOfIncorrectRounds += 1
        }

        currentMovieArrayIndexLocation += 4
        currentRound += 1
        return isTheUserCorrect
    }

    // Reset game variables
    func resetGame() {
        self.currentRound = 1
        self.numberOfCorrectRounds = 0
        self.numberOfIncorrectRounds = 0
        self.currentMovieArrayIndexLocation = 0
    }
}
