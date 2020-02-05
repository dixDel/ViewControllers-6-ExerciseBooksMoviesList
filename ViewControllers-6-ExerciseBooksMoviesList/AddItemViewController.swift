//
//  AddItemViewController.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 04/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import UIKit

protocol AddItemDelegate {
    func itemAdditionFinished(item: Item)
}

class AddItemViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var authorsPickerView: UIPickerView!
    @IBOutlet weak var genresPickerView: UIPickerView!
    @IBOutlet weak var pictureImageView: UIImageView!
    
    var delegate: AddItemDelegate?
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

        // Do any additional setup after loading the view.
        self.authors = database.authors.sorted { (a1, a2) -> Bool in
            print(a1.name)
            if a1.name.isEmpty {
                return true
            } else {
                return a1.name < a2.name
            }
        }
        
        self.navigationItem.title = "Ajouter un truc"
        
        self.saveButton.setTitle("Enregistrer", for: .normal)
        
        self.cancelButton.setTitle("Annuler", for: .normal)
        
        self.nameTextField.text = ""
        self.descriptionTextField.text = ""
        self.yearTextField.text = ""
        self.authorsPickerView.delegate = self
        self.authorsPickerView.dataSource = self
        self.genresPickerView.delegate = self
        self.genresPickerView.dataSource = self
        self.pictureImageView.image = #imageLiteral(resourceName: "movie")
        self.pictureImageView.contentMode = .center
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if let name = self.nameTextField.text {
            let movie = Movie(name: name)
            if let description = self.descriptionTextField.text, let date = self.yearTextField.text {
                movie.description = description
                movie.year = Int(date)
            }
            self.delegate?.itemAdditionFinished(item: movie)
        }
        self.dismiss(animated: true, completion: nil)
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

extension AddItemViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        if pickerView == self.authorsPickerView {
            count = database.authors.count
        } else if pickerView == self.genresPickerView {
            count = self.genres.count
        }
        return count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var name = ""
        if pickerView == self.authorsPickerView {
            name = database.authors[row].name
        } else if pickerView == self.genresPickerView {
            name = self.genres[row].rawValue
        }
        return name
    }
}
