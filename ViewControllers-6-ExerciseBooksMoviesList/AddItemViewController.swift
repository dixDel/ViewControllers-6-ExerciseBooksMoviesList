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
    
    fileprivate func displayImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.authors = database.authors.sorted { (a1, a2) -> Bool in
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
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        self.pictureImageView.addGestureRecognizer(tapGesture)
        self.pictureImageView.isUserInteractionEnabled = true
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            displayImagePicker()
        }
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
            if let image = self.pictureImageView.image {
                movie.picture = image
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
}

extension AddItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.pictureImageView.contentMode = .scaleAspectFit
            self.pictureImageView.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
