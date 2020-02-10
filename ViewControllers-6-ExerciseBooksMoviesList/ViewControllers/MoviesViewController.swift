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
        
        setupTableView()
        setupCollectionView()
    }

    func setupTableView() {
        self.movieTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
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

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.displayedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.movieTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! ItemTableViewCell
        cell.isPair = indexPath.row % 2 == 0
        cell.setupCell(item: super.displayedItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let destination = storyboard?.instantiateViewController(identifier: "ItemDetailsViewController") as? ItemDetailsViewController {
            destination.item = super.displayedItems[indexPath.row]
            self.navigationController?.pushViewController(destination, animated: true)
        }
        self.movieTableView.deselectRow(at: indexPath, animated: true)
    }
    
}
