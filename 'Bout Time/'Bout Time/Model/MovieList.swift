//
//  Movie.swift
//  'Bout Time
//
//  Created by Mike Conner on 11/23/18.
//  Copyright © 2018 Mike Conner. All rights reserved.
//

import Foundation

struct Movie {
    var movieName: String
    var yearMovieWasReleased: Int
}

class MovieList {
    
    var movieArrayIndex: Int = 0
    var boutTimeRound: Int = 1
    let maxBoutTimeRounds: Int = 6
    var correctRounds: Int = 0
    var incorrectRounds: Int = 0
    
    var movieArray: [Movie] = [
        Movie(movieName: "Hercules in New York", yearMovieWasReleased: 1969),
        Movie(movieName: "The Long Goodbye", yearMovieWasReleased: 1973),
        Movie(movieName: "Stay Hungry", yearMovieWasReleased: 1976),
        Movie(movieName: "The Villain", yearMovieWasReleased: 1979),
        Movie(movieName: "Conan the Barbarian", yearMovieWasReleased: 1982),
        Movie(movieName: "The Terminator", yearMovieWasReleased: 1984),
        Movie(movieName: "Commando", yearMovieWasReleased: 1985),
        Movie(movieName: "Raw Deal", yearMovieWasReleased: 1986),
        Movie(movieName: "The Running Man", yearMovieWasReleased: 1987),
        Movie(movieName: "Twins", yearMovieWasReleased: 1988),
        Movie(movieName: "Total Recall", yearMovieWasReleased: 1990),
        Movie(movieName: "Terminator 2: Judgment Day", yearMovieWasReleased: 1991),
        Movie(movieName: "Last Action Hero", yearMovieWasReleased: 1993),
        Movie(movieName: "True Lies", yearMovieWasReleased: 1994),
        Movie(movieName: "Eraser", yearMovieWasReleased: 1996),
        Movie(movieName: "Batman & Robin", yearMovieWasReleased: 1997),
        Movie(movieName: "End of Days", yearMovieWasReleased: 1999),
        Movie(movieName: "The 6th Day", yearMovieWasReleased: 2000),
        Movie(movieName: "Dr. Dolittle 2", yearMovieWasReleased: 2001),
        Movie(movieName: "Collateral Damage", yearMovieWasReleased: 2002),
        Movie(movieName: "The Rundown", yearMovieWasReleased: 2003),
        Movie(movieName: "Around the World in 80 Days", yearMovieWasReleased: 2004),
        Movie(movieName: "The Kid & I", yearMovieWasReleased: 2005),
        Movie(movieName: "The Expendables", yearMovieWasReleased: 2010),
        Movie(movieName: "The Expendables 2", yearMovieWasReleased: 2012),
        Movie(movieName: "Escape Plan", yearMovieWasReleased: 2013),
        Movie(movieName: "Sabotage", yearMovieWasReleased: 2014),
        Movie(movieName: "Maggie", yearMovieWasReleased: 2015),
        Movie(movieName: "Aftermath", yearMovieWasReleased: 2017),
        Movie(movieName: "Viy 2: Journey to China", yearMovieWasReleased: 2019)]
    
    func shuffleMovieList () {
        movieArray.shuffle()
    }
    
    func checkOrderOfMovies (movieList: MovieList) -> Bool {
        var isTheUserCorrect: Bool = false
        
        if  movieList.movieArray[movieArrayIndex].yearMovieWasReleased < movieList.movieArray[movieArrayIndex + 1].yearMovieWasReleased && movieList.movieArray[movieArrayIndex + 1].yearMovieWasReleased < movieList.movieArray[movieArrayIndex + 2].yearMovieWasReleased && movieList.movieArray[movieArrayIndex].yearMovieWasReleased < movieList.movieArray[movieArrayIndex + 1].yearMovieWasReleased &&  movieList.movieArray[movieArrayIndex].yearMovieWasReleased < movieList.movieArray[movieArrayIndex + 1].yearMovieWasReleased {
            correctRounds += 1
            isTheUserCorrect = true
        } else {
            incorrectRounds += 1
        }
        movieArrayIndex += 4
        boutTimeRound += 1
        return isTheUserCorrect
    }

    func resetGame(movieList: MovieList) {
        movieList.movieArrayIndex = 0
        movieList.boutTimeRound = 1
        movieList.correctRounds = 0
        movieList.incorrectRounds = 0
    }
}
