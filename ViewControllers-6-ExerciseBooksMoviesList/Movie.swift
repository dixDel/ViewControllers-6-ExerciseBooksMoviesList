//
//  Movie.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 04/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import Foundation
import UIKit

class Movie {
    
    var name: String
    var picture: UIImage? = nil
    var pictureName: String?
    
    init(name: String, picture: UIImage? = nil, pictureName: String? = nil) {
        self.name = name
        self.picture = picture
        self.pictureName = pictureName
    }
    
}
