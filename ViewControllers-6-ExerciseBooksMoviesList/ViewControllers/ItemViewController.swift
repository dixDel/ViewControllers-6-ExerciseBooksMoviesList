//
//  ItemViewController.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 06/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, CellStateDelegate {
    
    //@IBOutlet weak var genresCollectionView: UICollectionView!
    weak var genresCollectionViewOutlet: UICollectionView!
    weak var itemsTableViewOutlet: UITableView!
    
    var items: [Item]!
    var displayedItems: [Item]!
    
    let genres = Genres.allCases
        .filter({ (genre) -> Bool in
            genre != Genres.NIL
        })
        .sorted { (genre1, genre2) -> Bool in
            if genre1 == Genres.A {
                return true
            } else {
                return genre1.rawValue < genre2.rawValue
            }
    }
    
    var selectedGenre: Genres?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        resetDisplayedItems()
        self.setupCollectionView()
    }
    
    func setupCollectionView() {
        self.genresCollectionViewOutlet.register(UINib(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GenreCell")
        self.genresCollectionViewOutlet.dataSource = self
        self.genresCollectionViewOutlet.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.genresCollectionViewOutlet.collectionViewLayout = layout
        self.genresCollectionViewOutlet.allowsMultipleSelection = false
    }
    
    fileprivate func resetDisplayedItems() {
        self.displayedItems = self.items.sorted { (item1, item2) -> Bool in
            item1.name < item2.name
        }
    }
    
    func hasBeenActivated(cell: GenreCollectionViewCell) {
        self.selectedGenre = cell.genre
    }
    
    func hasBeenDeactivated(cell: GenreCollectionViewCell) {
        self.selectedGenre = nil
    }
    
}

extension ItemViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.genresCollectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCollectionViewCell
        let genre = self.genres[indexPath.row]
        cell.setupCell(genre: genre)
        if self.selectedGenre == genre ||
            self.selectedGenre == nil && genre == Genres.A {
            cell.activateCell()
            //self.collectionView(collectionView, didSelectItemAt: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    fileprivate func filterItems(_ genre: Genres) {
        if genre != Genres.A {
            self.displayedItems = self.items.filter { (item) -> Bool in
                var isMatch = false
                if let itemGenre = item.genres {
                    isMatch = itemGenre.contains(genre)
                }
                return isMatch
            }
        } else {
            self.resetDisplayedItems()
        }
        self.itemsTableViewOutlet.reloadData()
        if self.displayedItems.count > 0 {
            self.itemsTableViewOutlet.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.selectedGenre == nil {
            self.collectionView(collectionView, didDeselectItemAt: IndexPath(row: 0, section: 0))
        }
        let cell = collectionView.cellForItem(at: indexPath) as? GenreCollectionViewCell
        cell?.activateCell()
        let genre = self.genres[indexPath.row]
        filterItems(genre)
        self.selectedGenre = genre
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
        let cell = collectionView.cellForItem(at: indexPath) as? GenreCollectionViewCell
        cell?.resetCell()
    }
}
