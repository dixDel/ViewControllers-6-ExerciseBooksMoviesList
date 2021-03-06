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

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var swipeImageView: UIImageView!
    
    var delegate: AddItemDelegate?
    
    var genre: String?
    
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
        
        self.navigationItem.title = "Ajouter un film"
        
        self.saveButton.setTitle("Enregistrer", for: .normal)
        
        self.cancelButton.setTitle("Annuler", for: .normal)
        
        self.nameLabel.text = "Titre"
        self.descriptionLabel.text = "Descriptif"
        self.yearLabel.text = "Année"
        self.nameLabel.textAlignment = .right
        self.descriptionLabel.textAlignment = .right
        self.yearLabel.textAlignment = .right
        
        self.nameTextField.text = ""
        self.descriptionTextField.text = ""
        self.yearTextField.text = ""
        self.yearTextField.keyboardType = .numberPad
        self.pictureImageView.image = #imageLiteral(resourceName: "movie")
        self.pictureImageView.contentMode = .center
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2.0, delay: 0.0, options: [.repeat], animations: {
            UIView.setAnimationRepeatCount(100);
            self.swipeImageView.alpha = 0.0
        }, completion: { (pos) in
            self.swipeImageView.alpha = 1.0
        })
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        self.pictureImageView.addGestureRecognizer(tapGesture)
        self.pictureImageView.isUserInteractionEnabled = true
    }
    
    @objc func viewSwipped(gesture: UIGestureRecognizer) {
        if let destination = storyboard?.instantiateViewController(identifier: "AddMovieGenreViewController") {
            if let nav = self.navigationController {
                nav.pushViewController(destination, animated: true)
            }
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
