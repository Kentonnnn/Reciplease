//
//  FavoriteController.swift
//  Reciplease
//
//  Created by Nelson Pires Da Silva on 11/10/23.
//

import UIKit

class FavoriteController: UIViewController {
    
    // MARK: - Property
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupStyle()
        self.setupSubViews()
        self.setupLayout()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(CustomRecipeCell.self, forCellReuseIdentifier: CustomRecipeCell.cellIdentifier)
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = 153
        self.tableView.backgroundColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Private
    func setupStyle() {
        self.view.backgroundColor = .white
        
        self.titleLabel.text = "Reciplease"
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func setupSubViews() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.tableView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.tableView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -30),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
        ])
    }
    
    // MARK: - Action
    
    // MARK: - Core
    
}

extension FavoriteController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomRecipeCell.cellIdentifier, for: indexPath) as! CustomRecipeCell

        let favoriteRecipe = FavoriteRecipes.shared.getFavoriteRecipes()[indexPath.row]

        cell.recipeLabel.text = favoriteRecipe.label

        if let imageUrlString = favoriteRecipe.image, let imageUrl = URL(string: imageUrlString) {
            cell.recipeImageView.af.setImage(withURL: imageUrl)
        } else {
            cell.recipeImageView.image = UIImage(named: "defaultImage")
        }

        cell.ingredientLabel.text = favoriteRecipe.ingredientLines.joined(separator: ", ")

        if let totalTime = favoriteRecipe.totalTime {
            cell.totalTimeLabel.text = "\(totalTime) mn"
        } else {
            cell.totalTimeLabel.text = "N/A"
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteRecipes.shared.getFavoriteRecipes().count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFavoriteRecipe = FavoriteRecipes.shared.getFavoriteRecipes()[indexPath.row]

        let recipeDetailsController = RecipeDetailsController()

        recipeDetailsController.recipe = selectedFavoriteRecipe

        // Utilisez la référence à la navigation controller pour pousser le même objet RecipeDetailsController
        navigationController?.pushViewController(recipeDetailsController, animated: true)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
