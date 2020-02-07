//
//  ItemViewController.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 06/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ItemViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.genresCollectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCollectionViewCell
        cell.setupCell(genre: self.genres[indexPath.row])
        if self.genres[indexPath.row] == Genres.A {
            self.genresCollectionViewOutlet.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
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
            //self.resetDisplayedMovies()
        }
        self.itemsTableViewOutlet.reloadData()
        print(self.displayedItems.count)
        //self.movieTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let genre = self.genres[indexPath.row]
        filterItems(genre)
        self.getCell(indexPath)?.activateCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.getCell(indexPath)?.resetCell()
    }
    
    fileprivate func getCell(_ indexPath: IndexPath) -> GenreCollectionViewCell? {
        if let cell = self.genresCollectionViewOutlet.cellForItem(at: indexPath) as? GenreCollectionViewCell {
            return cell
        }
        return nil
    }
}
