//
//  Movie.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 04/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import Foundation
import UIKit

class Movie: Item {
    
    var name: String //Oh yes j'adore les String
    var picture: UIImage? = nil
    var year: Int? = nil
    var genres: [Genres]? = nil
    var description: String? = nil
    var authors: [Author]? = nil
    
    init(name: String, picture: UIImage? = nil, year: Int? = nil, genres: [Genres]? = nil, description: String? = nil, authors: [Author]? = nil) {
        self.name = name
        self.picture = picture
        self.year = year
        self.genres = genres
        self.description = description
        self.authors = authors
    }
    
}
