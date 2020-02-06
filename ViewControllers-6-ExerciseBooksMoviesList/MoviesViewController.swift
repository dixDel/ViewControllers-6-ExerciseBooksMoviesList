//
//  ViewController.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 04/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, AddItemDelegate {

    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var movieTableView: UITableView!
    
    private let genres = Genres.allCases
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
    
    private var movies = [
        Movie(name: "Terminator 2", picture: #imageLiteral(resourceName: "terminator2"), year: 1991, genres: [
            Genres.SciFi,
            Genres.Action
        ], authors: [Author(name: "James Cameron")]),
        Movie(name: "Blanche-Neige et les septs mains", picture: #imageLiteral(resourceName: "Blanche-Neige"), genres: [Genres.X], authors: [Author(name: "Waf Dixney"), Author(name: "Wouf Dicksney")]),
        Movie(name: "Gattaca", picture: #imageLiteral(resourceName: "Gattaca"), year: 1997, genres: [Genres.SciFi], authors: [Author(name: "Andrew Niccol")]),
        Movie(name: "Fight Club", picture: #imageLiteral(resourceName: "fight club"), year: 1999, authors: [Author(name: "David Fincher")]),
        Movie(name: "Goodfellas", picture: #imageLiteral(resourceName: "goodfellas"), year: 1990, genres: [Genres.Drama], authors: [Author(name: "Martin Scorsese")]),
        Movie(name: "Braveheart", picture: #imageLiteral(resourceName: "braveheart"), year: 1995, genres: [Genres.Action, Genres.Historical, Genres.Aventure], description: "Au XIIIe siècle, Édouard Ier d'Angleterre, surnommé Longshanks (« aux longues jambes ») mais aussi The Hammer of Scots par les Anglais, occupe une bonne partie du sud de l'Écosse. Son oppression conduit à la mort du père et du frère du jeune William Wallace. Des années plus tard, après que Wallace a été élevé à l'étranger par son oncle, les Écossais continuent de vivre sous les lois cruelles d'Édouard Ier. Wallace revient dans son village natal avec l'intention de vivre comme paysan et d'éviter de s'impliquer dans les troubles qui agitent le pays. Il retrouve son amie et amour d'enfance, Murron MacClannough, à laquelle il montre le chardon, soigneusement préservé, qu'elle lui avait donné quand ils étaient enfants. Les deux jeunes gens se marient en secret afin d'éviter le décret du noctis primae (droit de la « première nuit ») que le roi a énoncé. Plus tard, quand un soldat anglais brutalise Murron et tente de la violer, Wallace vole à son secours. Il l'aide à monter à cheval pour qu'elle s'échappe pendant qu'il retient les soldats. Mais elle est finalement capturée et le shérif lui coupe la gorge en public, en proclamant : « une attaque contre les soldats du roi est pareille à une attaque contre le roi lui-même ». En représailles, Wallace, bientôt rejoint par les villageois, massacre la garnison anglaise et tranche la gorge du shérif à l'endroit même où celui-ci a tué Murron, et avec le même poignard. Ainsi débute la quête de Wallace pour l'indépendance de l'Écosse.\nQuand Édouard Ier apprend la nouvelle de la rébellion de Wallace, il charge son fils, le premier prince de Galles de l'Histoire, également prénommé Édouard, d'y mettre fin. Le prince Édouard est marié à Isabelle de France mais la délaisse car il est homosexuel. Pendant ce temps, Wallace et ses troupes multiplient les coups d'éclat et de nouvelles forces se joignent à lui au fur et à mesure que sa renommée grandit. Wallace inflige une cuisante défaite à l'armée anglaise envoyée contre lui lors de la bataille de Stirling. Il met ensuite à sac la cité d'York. Wallace cherche également à obtenir le soutien de Robert Bruce, solide prétendant au trône d'Écosse, mais celui-ci, malgré son admiration pour Wallace, est très influencé par son père, lépreux, qui le presse de soutenir Wallace officiellement tout en restant secrètement proche des Anglais.\nDevant l'ampleur que prend la rébellion, Édouard Ier envoie la princesse Isabelle négocier la paix avec Wallace. Celui-ci refuse l'or, les titres et les terres qui lui sont offerts en échange de sa soumission et fait forte impression sur Isabelle, qui s'attendait à rencontrer un barbare assoiffé de sang et non un homme cultivé. Plus tard, apprenant qu'Édouard Ier prépare une attaque surprise contre Wallace, Isabelle envoie sa servante le prévenir du danger. Wallace tente d'unir les nobles écossais contre les Anglais mais, sur le champ de bataille de Falkirk, il est trahi par les nobles Lochlan et Mornay. Les Écossais sont vaincus et Wallace découvre que Robert Bruce était dans l'état-major anglais. Il refuse néanmoins de le tuer et Bruce, saisi de remords, lui permet d'échapper à la capture. Wallace tue ensuite Lochlan et Mornay en représailles et mène désormais une guérilla contre les Anglais. Édouard Ier fait tendre une embuscade à Wallace par ses tueurs, mais prévenu à nouveau par Isabelle, il déjoue le piège et fait brûler vifs les tueurs anglais. Il retrouve Isabelle qui tombe sous son charme et couche avec lui, découvrant l'amour que son époux Édouard ne lui a pas donné.\nRobert Bruce est désormais désireux de joindre ses forces à celles de Wallace mais, lors d'une rencontre organisée entre eux deux, le père de Bruce et d'autres nobles écossais les trahissent. Wallace est capturé et livré aux Anglais alors que Bruce renie son père. Wallace est emmené à Londres et condamné à mort pour haute trahison, tandis qu'Édouard Ier est désormais gravement malade et proche de la fin. Isabelle, venue voir Wallace en prison, lui offre de s'empoisonner pour échapper à la torture mais il refuse. Isabelle apprend au roi, désormais incapable de parler, que l'enfant qu'elle attend, a priori le futur Édouard III d'Angleterre, est de Wallace, et lui promet de mettre un terme à sa lignée. Wallace subit publiquement une terrible torture mais refuse d'implorer la grâce du roi. Au lieu de crier « Pitié » pour que cessent ses tourments, il hurle « Liberté », ce qu'entend le roi d'Angleterre, et les deux personnages meurent en même temps, Wallace décapité à la hache et le roi sur son lit.\nDes années plus tard, Robert Bruce refuse de se soumettre à une armée anglaise et, invoquant la mémoire de Wallace, mène les Écossais à une écrasante victoire à la bataille de Bannockburn face à Édouard II d'Angleterre, assurant l'indépendance temporaire de l'Écosse.", authors: [Author(name: "Mel Gibson")])
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
        addController.delegate = self
        self.present(addController, animated: true, completion: nil)
    }
    
    func itemAdditionFinished(item: Item) {
        let movie = item as! Movie
        self.movies.append(movie)
        self.resetDisplayedMovies()
        self.movieTableView.insertRows(at: [IndexPath(row: self.movies.count - 1, section: 0)], with: .automatic)
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
