//
//  BooksViewController.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 04/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import UIKit

class BooksViewController: ItemViewController {
    @IBOutlet weak var booksTableView: UITableView!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    
    private var books = FakeDatabase().books
    
    private var displayedBooks = [Book]()
    
    override func viewDidLoad() {
        super.items = self.books
        super.displayedItems = self.displayedBooks
        super.genresCollectionViewOutlet = self.genresCollectionView
        super.itemsTableViewOutlet = self.booksTableView
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Livres"
        
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.items = self.books
        super.displayedItems = self.displayedBooks
        super.genresCollectionViewOutlet = self.genresCollectionView
        super.itemsTableViewOutlet = self.booksTableView
        super.viewDidAppear(animated)
    }
    
    func setupTableView() {
        self.booksTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        self.booksTableView.delegate = self
        self.booksTableView.dataSource = self
    }
    
}

extension BooksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.displayedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.booksTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! ItemTableViewCell
        cell.isPair = indexPath.row % 2 == 0
        cell.setupCell(item: super.displayedItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(identifier: "ItemDetailsViewController") as! ItemDetailsViewController
        destination.item = self.displayedBooks[indexPath.row]
        self.navigationController?.pushViewController(destination, animated: true)
        self.booksTableView.deselectRow(at: indexPath, animated: true)
    }*/
    
}

