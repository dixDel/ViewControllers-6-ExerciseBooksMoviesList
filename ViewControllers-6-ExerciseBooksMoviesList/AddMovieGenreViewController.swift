//
//  AddMovieGenreViewController.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 06/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import UIKit

class AddMovieGenreViewController: UIViewController {
    
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var genresPickerView: UIPickerView!
    @IBOutlet weak var authorsPickerView: UIPickerView!
    
    var database: FakeDatabase = FakeDatabase()
    var genres = Genres.allCases
        .filter({ (genre) -> Bool in
        genre != Genres.A
        })
        .sorted { (genre1, genre2) -> Bool in
            if genre1 == Genres.NIL {
                return true
            } else {
                return genre1.rawValue < genre2.rawValue
            }
    }
    var authors = [Author]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.genresLabel.textAlignment = .center
        self.authorsLabel.textAlignment = .center
        
        // Do any additional setup after loading the view.
        self.authors = database.authors.sorted { (a1, a2) -> Bool in
            if a1.name.isEmpty {
                return true
            } else {
                return a1.name < a2.name
            }
        }
        
        self.authorsPickerView.delegate = self
        self.authorsPickerView.dataSource = self
        self.genresPickerView.delegate = self
        self.genresPickerView.dataSource = self
        
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

extension AddMovieGenreViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        if pickerView == self.authorsPickerView {
            count = self.authors.count
        } else if pickerView == self.genresPickerView {
            count = self.genres.count
        }
        return count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var name = ""
        if pickerView == self.authorsPickerView {
            name = self.authors[row].name
        } else if pickerView == self.genresPickerView {
            name = self.genres[row].rawValue
        }
        return name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let parent = self.navigationController?.viewControllers[0] as! AddItemViewController
        parent.genre = self.genres[row].rawValue
    }
}
