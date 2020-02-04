//
//  MovieTableViewCell.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 04/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    
    var isPair: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(item: Item) {
        self.nameLabel.text = item.name
        if let picture = item.picture {
            self.pictureImageView.image = picture
            self.pictureImageView.contentMode = .scaleAspectFit
        }
        if isPair {
            self.backgroundColor = .white
        } else {
            self.backgroundColor = .lightGray
        }
    }
    
}
