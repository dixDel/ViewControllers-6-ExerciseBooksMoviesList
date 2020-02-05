//
//  FakeDatabase.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 05/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import Foundation

enum Genres: String, CaseIterable {
    case SciFi = "Sci-Fi"
    case Action
    case Aventure
    case Comedy = "Comédie"
    case X
    case Fantasy = "Fantastique"
    case Historical = "Historique"
    case A = "Tous"
    case Drama = "Drame"
}

class FakeDatabase {
    
    let authors = [
        Author(name: "Isaac Asimov", picture: #imageLiteral(resourceName: "liv tyler")),
        Author(name: "Waf Dixney", picture: #imageLiteral(resourceName: "liv tyler")),
        Author(name: "Mel Gibson", picture: #imageLiteral(resourceName: "liv tyler")),
        Author(name: "James Cameron"),
        Author(name: "Wouf Dicksney"),
        Author(name: "Andrew Niccol"),
        Author(name: "David Fincher"),
        Author(name: "Martin Scorsese")
    ]
    
}
