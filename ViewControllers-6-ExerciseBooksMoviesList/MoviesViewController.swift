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
            filterMovies(genre)
            self.genresCollectionView.reloadData()
            hasNewMovie = false
        }
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
        if let destination = storyboard?.instantiateViewController(identifier: "ItemDetailsViewController") as? ItemDetailsViewController {
            destination.item = self.displayedMovies[indexPath.row]
            self.navigationController?.pushViewController(destination, animated: true)
        }
        self.movieTableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.genresCollectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCollectionViewCell
        cell.setupCell(genre: self.genres[indexPath.row])
        if self.genres[indexPath.row] == Genres.A {
            self.genresCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
            cell.activateCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    fileprivate func filterMovies(_ genre: Genres) {
        if genre != Genres.A {
            self.displayedMovies = self.movies.filter { (movie) -> Bool in
                var isMatch = false
                if let movieGenre = movie.genres {
                    isMatch = movieGenre.contains(genre)
                }
                return isMatch
            }
        } else {
            self.resetDisplayedMovies()
        }
        self.movieTableView.reloadData()
        self.movieTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let genre = self.genres[indexPath.row]
        filterMovies(genre)
        self.getCell(indexPath)?.activateCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.getCell(indexPath)?.resetCell()
    }
    
    fileprivate func getCell(_ indexPath: IndexPath) -> GenreCollectionViewCell? {
        if let cell = self.genresCollectionView.cellForItem(at: indexPath) as? GenreCollectionViewCell {
            return cell
        }
        return nil
    }
}
