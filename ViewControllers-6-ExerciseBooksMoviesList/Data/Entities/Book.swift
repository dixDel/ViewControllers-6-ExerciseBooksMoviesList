//
//  Book.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 04/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import Foundation
import UIKit

class Book: Item {
    
    var name: String
    var authors: [Author]?
    var picture: UIImage?
    var genres: [Genres]?
    
    init(title: String, picture: UIImage? = nil, authors: [Author]? = nil, genres: [Genres]? = nil) {
        self.name = title
        self.picture = picture
        self.authors = authors
        self.genres = genres
    }
}
