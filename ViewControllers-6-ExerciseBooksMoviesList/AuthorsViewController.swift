//
//  AuthorsViewController.swift
//  ViewControllers-6-ExerciseBooksMoviesList
//
//  Created by student5310 on 04/02/2020.
//  Copyright © 2020 student5310. All rights reserved.
//

import UIKit

class AuthorsViewController: UIViewController {

    @IBOutlet weak var authorsTableView: UITableView!
    
    private let authors = [
        Author(name: "Isaac Asimov", picture: nil),
        Author(name: "Waf Dixney", picture: nil)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Auteurs"
        
        setupTableView()
    }
    
    func setupTableView() {
        self.authorsTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        self.authorsTableView.delegate = self
        self.authorsTableView.dataSource = self
    }
    
    @objc func addMovie() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let addController = storyboard.instantiateViewController(identifier: "AddItemViewController") as! AddItemViewController
        self.present(addController, animated: true, completion: nil)
    }
    
}

extension AuthorsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.authors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.authorsTableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        cell.isPair = indexPath.row % 2 == 0
        cell.setupCell(item: self.authors[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
