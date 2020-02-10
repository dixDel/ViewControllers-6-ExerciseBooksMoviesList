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
        self.setupParent()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Livres"
    }
    
    fileprivate func setupParent() {
        super.genresCollectionViewOutlet = self.genresCollectionView
        super.itemsTableViewOutlet = self.booksTableView
        super.items = self.books
        super.displayedItems = self.displayedBooks
    }
    
}
