//
//  ViewController.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 04/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    private var movies = [
        Movie(name: "Blanche-Neige et les septs mains", author: "Waf Dixney", picture: #imageLiteral(resourceName: "Blanche-Neige")),
        Movie(name: "Gattaca", author: "Andrew Niccol", picture: #imageLiteral(resourceName: "Gattaca"), year: 1997),
        Movie(name: "Fight Club", author: "David Fincher", picture: #imageLiteral(resourceName: "fight club"), year: 1999)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Films"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMovie))
        self.navigationItem.rightBarButtonItem = addButton
        
        self.movies.sort { (movie1, movie2) -> Bool in
            movie1.name < movie2.name
        }
        
        setupTableView()
    }

    func setupTableView() {
        self.movieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
    }
    
    @objc func addMovie() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let addController = storyboard.instantiateViewController(identifier: "AddItemViewController") as! AddItemViewController
        self.present(addController, animated: true, completion: nil)
    }
    
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.movieTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        cell.setupCell(item: self.movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(identifier: "ItemDetailsViewController") as! ItemDetailsViewController
        destination.customTitle = self.movies[indexPath.row].name
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
}
