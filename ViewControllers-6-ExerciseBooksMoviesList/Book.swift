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
    var author: String
    var picture: UIImage?
    
    init(title: String, author: String) {
        self.name = title
        self.author = author
    }
}
