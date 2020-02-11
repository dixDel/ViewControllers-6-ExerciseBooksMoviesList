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
        self.setupTableView()
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

    func setupTableView() {
        self.itemsTableViewOutlet.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        self.itemsTableViewOutlet.delegate = self
        self.itemsTableViewOutlet.dataSource = self
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
    
    func createAddButton(title: String) {
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = title
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMovie))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addMovie() {
        if let navigationController = storyboard?.instantiateViewController(identifier: "AddMovieNavigationController") as? UINavigationController {
            let controller = navigationController.viewControllers[0] as! AddItemViewController
            controller.delegate = self as! AddItemDelegate
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
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

extension ItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.itemsTableViewOutlet.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        cell.isPair = indexPath.row % 2 == 0
        cell.setupCell(item: displayedItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let destination = storyboard?.instantiateViewController(identifier: "ItemDetailsViewController") as? ItemDetailsViewController {
            destination.item = displayedItems[indexPath.row]
            self.navigationController?.pushViewController(destination, animated: true)
        }
        self.itemsTableViewOutlet.deselectRow(at: indexPath, animated: true)
    }
    
}
