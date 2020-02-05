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
    @IBOutlet weak var authorLabel: UILabel!
    
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
        self.nameLabel.font = self.nameLabel.font.withSize(30)
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: self.nameLabel.font.pointSize)
        self.authorLabel.text = ""
        if let authors = item.authors {
            self.authorLabel.text = authors.map({ (author) -> String in
                author.name
            }).joined(separator: ", ")
        }
        if let picture = item.picture {
            self.pictureImageView.image = picture
            self.pictureImageView.contentMode = .scaleAspectFit
        }
        if isPair {
            self.backgroundColor = .white
        } else {
            self.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 0.9, green: 0.9, blue: 0.9, alpha: 1.0))
        }
    }
    
}
