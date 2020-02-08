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
    
    var selectedIndex = IndexPath(row: 0, section: 0)
    var selectedCell: GenreCollectionViewCell?
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        resetDisplayedItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupCollectionView()
    }
    
    func setupCollectionView() {
        self.genresCollectionViewOutlet.register(UINib(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GenreCell")
        self.genresCollectionViewOutlet.dataSource = self
        self.genresCollectionViewOutlet.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.genresCollectionViewOutlet.collectionViewLayout = layout
    }
    
    fileprivate func resetDisplayedItems() {
        self.displayedItems = self.items.sorted { (item1, item2) -> Bool in
            item1.name < item2.name
        }
    }
    
    func hasBeenActivated(cell: GenreCollectionViewCell) {
        self.selectedCell = cell
    }
    
}

extension ItemViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.genresCollectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCollectionViewCell
        cell.setupCell(genre: self.genres[indexPath.row])
        if self.selectedCell == nil {
            self.selectedCell = cell
        }
        if self.selectedCell == cell {
            //self.genresCollectionViewOutlet.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
            cell.activateCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
    
    fileprivate func filterItems(_ genre: Genres) {
        print(genre)
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
        print("selected cell is \(self.selectedCell)")
        self.selectedCell?.resetCell()
        //self.collectionView(self.genresCollectionViewOutlet, didDeselectItemAt: self.selectedIndex)
        self.selectedIndex = indexPath
        let genre = self.genres[indexPath.row]
        filterItems(genre)
        self.selectedCell = self.getCell(indexPath)
        self.selectedCell?.activateCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
       // self.getCell(indexPath)?.resetCell()
    }
    
    /*func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deselect \(self.selectedIndex)")
        // scrolling then coming back without selecting another cell gives indexPath 0, 0
        self.getCell(self.selectedIndex)?.resetCell()
    }*/
    
    fileprivate func getCell(_ indexPath: IndexPath) -> GenreCollectionViewCell? {
        if let cell = self.genresCollectionViewOutlet.cellForItem(at: indexPath) as? GenreCollectionViewCell {
            print("found cell")
            return cell
        }
        return nil
    }
}
