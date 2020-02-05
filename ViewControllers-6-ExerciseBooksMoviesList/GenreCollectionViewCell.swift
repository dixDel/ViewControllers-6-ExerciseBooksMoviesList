//
//  GenreCollectionViewCell.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 05/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var genreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(genre: Genres) {
        self.genreButton.setTitle(genre.rawValue, for: .normal)
    }
    
    @IBAction func genreAction(_ sender: Any) {
        print("genre")
    }
    
}
