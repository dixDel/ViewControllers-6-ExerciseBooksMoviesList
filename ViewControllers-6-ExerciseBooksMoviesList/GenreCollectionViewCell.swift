//
//  GenreCollectionViewCell.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 05/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import UIKit

protocol CellStateDelegate {
    func hasBeenActivated(cell: GenreCollectionViewCell)
    func hasBeenDeactivated(cell: GenreCollectionViewCell)
}

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var genreLabel: UILabel!
    
    var delegate: CellStateDelegate?
    
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
        self.delegate?.hasBeenActivated(cell: self)
    }
    
    func resetCell() {
        self.backgroundColor = .white
        self.delegate?.hasBeenDeactivated(cell: self)
    }
    
}
