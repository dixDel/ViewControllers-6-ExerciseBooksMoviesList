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
    @IBOutlet weak var pictureImageView: UIImageView!
    
    var delegate: AddItemDelegate?
    
    fileprivate func displayImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiper = UISwipeGestureRecognizer(target: self, action: #selector(viewSwipped(gesture:)))
        swiper.direction = .left
        self.view.addGestureRecognizer(swiper)
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Ajouter un truc"
        
        self.saveButton.setTitle("Enregistrer", for: .normal)
        
        self.cancelButton.setTitle("Annuler", for: .normal)
        
        self.nameTextField.text = ""
        self.descriptionTextField.text = ""
        self.yearTextField.text = ""
        self.pictureImageView.image = #imageLiteral(resourceName: "movie")
        self.pictureImageView.contentMode = .center
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        self.pictureImageView.addGestureRecognizer(tapGesture)
        self.pictureImageView.isUserInteractionEnabled = true
    }
    
    @objc func viewSwipped(gesture: UIGestureRecognizer) {
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AddMovieGenreViewController")
        if let nav = self.navigationController {
            nav.pushViewController(destination, animated: true)
            //nav.present(destination, animated: true, completion: nil)
            print("swiped!")
        }
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

extension AddItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.pictureImageView.contentMode = .scaleAspectFit
            self.pictureImageView.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
