//
//  ViewController.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 04/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var movieTableView: UITableView!
    
    private let genres = Genres.allCases.sorted { (genre1, genre2) -> Bool in
        if genre1 == Genres.A {
            return true
        } else {
            return genre1.rawValue < genre2.rawValue
        }
    }
    
    private let movies = [
        Movie(name: "Terminator 2", author: "James Cameron", picture: #imageLiteral(resourceName: "terminator2"), year: 1991, genres: [
            Genres.SciFi,
            Genres.Action
        ]),
        Movie(name: "Blanche-Neige et les septs mains", author: "Waf Dixney", picture: #imageLiteral(resourceName: "Blanche-Neige"), genres: [Genres.X]),
        Movie(name: "Gattaca", author: "Andrew Niccol", picture: #imageLiteral(resourceName: "Gattaca"), year: 1997, genres: [Genres.SciFi]),
        Movie(name: "Fight Club", author: "David Fincher", picture: #imageLiteral(resourceName: "fight club"), year: 1999),
        Movie(name: "Goodfellas", author: "Martin Scorsese", picture: #imageLiteral(resourceName: "goodfellas"), year: 1990, genres: [Genres.Drama]),
        Movie(name: "Braveheart", author: "Mel Gibson", picture: #imageLiteral(resourceName: "braveheart"), year: 1995, genres: [Genres.Action, Genres.Historical, Genres.Aventure])
    ]
    private var displayedMovies = [Movie]()
    
    fileprivate func resetDisplayedMovies() {
        self.displayedMovies = self.movies.sorted { (movie1, movie2) -> Bool in
            movie1.name < movie2.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Films"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMovie))
        self.navigationItem.rightBarButtonItem = addButton
        
        resetDisplayedMovies()
        
        setupTableView()
        setupCollectionView()
    }

    func setupTableView() {
        self.movieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
    }
    
    func setupCollectionView() {
        self.genresCollectionView.register(UINib(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GenreCell")
        self.genresCollectionView.dataSource = self
        self.genresCollectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.genresCollectionView.collectionViewLayout = layout
    }
    
    @objc func addMovie() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let addController = storyboard.instantiateViewController(identifier: "AddItemViewController") as! AddItemViewController
        self.present(addController, animated: true, completion: nil)
    }
    
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.movieTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        cell.isPair = indexPath.row % 2 == 0
        cell.setupCell(item: self.displayedMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(identifier: "ItemDetailsViewController") as! ItemDetailsViewController
        destination.customTitle = self.displayedMovies[indexPath.row].name
        self.navigationController?.pushViewController(destination, animated: true)
        self.movieTableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Genres.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.genresCollectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCollectionViewCell
        cell.setupCell(genre: self.genres[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let genre = self.genres[indexPath.row]
        if genre != Genres.A {
            self.displayedMovies = self.movies.filter { (movie) -> Bool in
                var isMatch = false
                if let movieGenre = movie.genres {
                    isMatch = movieGenre.contains(self.genres[indexPath.row])
                }
                return isMatch
            }
        } else {
            self.resetDisplayedMovies()
        }
        self.movieTableView.reloadData()
        self.genresCollectionView.cellForItem(at: indexPath)?.backgroundColor = .lightGray
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.genresCollectionView.cellForItem(at: indexPath)?.backgroundColor = .white
    }
}
