//
//  ViewController.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 04/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import UIKit

class MoviesViewController: ItemViewController, AddItemDelegate {

    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var movieTableView: UITableView!
    
    private var movies = FakeDatabase().movies
    private var displayedMovies = [Movie]()
    
    private var hasNewMovie: Bool = false
    
    fileprivate func setupParent() {
        super.genresCollectionViewOutlet = self.genresCollectionView
        super.itemsTableViewOutlet = self.movieTableView
        super.items = self.movies
        super.displayedItems = self.displayedMovies
    }
    
    override func viewDidLoad() {
        setupParent()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Films"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMovie))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addMovie() {
        if let navigationController = storyboard?.instantiateViewController(identifier: "AddMovieNavigationController") as? UINavigationController {
            let controller = navigationController.viewControllers[0] as! AddItemViewController
            controller.delegate = self
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    func itemAdditionFinished(item: Item) {
        let movie = item as! Movie
        self.movies.append(movie)
        hasNewMovie = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if hasNewMovie {
            let genre = self.genres[0]
            //filterMovies(genre)
            self.genresCollectionView.reloadData()
            hasNewMovie = false
        }
    }
}
