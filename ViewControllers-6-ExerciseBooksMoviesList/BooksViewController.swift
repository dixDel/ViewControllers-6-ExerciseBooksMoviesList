//
//  BooksViewController.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 04/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {
    @IBOutlet weak var booksTableView: UITableView!
    
    private let books = [
        Book(title: "Fondation", picture: #imageLiteral(resourceName: "Fondation-Asimov"), authors: [Author(name: "Isaac Asimov")]),
        Book(title: "Le Seigneur des anneaux", picture: #imageLiteral(resourceName: "seigneur anneaux"), authors: [Author(name: "J.R.R. Tolkien")])
    ]
    
    private var displayedBooks = [Book]()
    
    fileprivate func resetDisplayedBooks() {
        self.displayedBooks = self.books.sorted { (b1, b2) -> Bool in
            b1.name < b2.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Livres"
        
        resetDisplayedBooks()
        
        setupTableView()
    }
    
    func setupTableView() {
        self.booksTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        self.booksTableView.delegate = self
        self.booksTableView.dataSource = self
    }
    
}

extension BooksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.booksTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        cell.isPair = indexPath.row % 2 == 0
        cell.setupCell(item: self.books[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(identifier: "ItemDetailsViewController") as! ItemDetailsViewController
        destination.item = self.displayedBooks[indexPath.row]
        self.navigationController?.pushViewController(destination, animated: true)
        self.booksTableView.deselectRow(at: indexPath, animated: true)
    }
    
}

