//
//  Author.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 04/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import Foundation
import UIKit

class Author: Item {
    var name: String
    var authors: [Author]? = nil
    var picture: UIImage?
    var genres: [Genres]? = nil
    
    init(name: String, picture: UIImage? = nil) {
        self.name = name
        self.picture = picture
    }
}
