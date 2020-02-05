//
//  ItemDetailsViewController.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 04/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let item = self.item {
            self.navigationItem.title = item.name
            self.pictureImageView.image = item.picture
            self.dateLabel.text = ""
            self.authorsLabel.text = ""
            self.descriptionLabel.text = ""
            self.authorsLabel.text = item.authors?.map({ (author) -> String in
                author.name
                }).joined(separator: ", ")
            if item is Movie {
                let movie = item as! Movie
                if let year = movie.year {
                    self.dateLabel.text = "\(year)"
                }
                self.descriptionLabel.text = movie.description
                self.descriptionLabel.numberOfLines = 0
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
