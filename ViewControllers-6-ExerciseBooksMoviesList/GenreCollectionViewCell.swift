//
//  GenreCollectionViewCell.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 05/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(genre: Genres) {
        self.resetCell()
        self.genreLabel.text = genre.rawValue
        self.genreLabel.textAlignment = .center
        self.genreLabel.textColor = .purple
    }
    
    func activateCell() {
        self.backgroundColor = .lightGray
    }
    
    func resetCell() {
        self.backgroundColor = .white
    }
    
}
