//
//  Item.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 04/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import Foundation
import UIKit

protocol Item {
    var name: String { get set }
    var authors: [Author]? { get set } 
    var picture: UIImage? { get set }
    var genres: [Genres]? { get set }
}
