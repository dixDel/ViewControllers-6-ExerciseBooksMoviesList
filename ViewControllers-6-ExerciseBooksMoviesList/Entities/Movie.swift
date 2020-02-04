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
    
    var name: String
    var author: String
    var picture: UIImage? = nil
    var year: Int? = nil
    var genres: [Genre]? = nil
    
    init(name: String, author: String, picture: UIImage? = nil, year: Int? = nil, genres: [Genre]? = nil) {
        self.name = name
        self.author = author
        self.picture = picture
        self.year = year
        self.genres = genres
    }
    
}
