//
//  SearchForRecipesController.swift
//  Reciplease
//
//  Created by Nelson Pires Da Silva on 11/15/23.
//

import UIKit

class RecipesController: UIViewController {
    
    // MARK: - Property
    private var tableView: UITableView = {
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
        self.tableView.rowHeight = 70
        self.tableView.backgroundColor = UIColor.clear
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
            
            self.tableView.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 20),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -30),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: -30),
        ])
    }

    // MARK: - Action

    // MARK: - Core

}

extension RecipesController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomRecipeCell.cellIdentifier, for: indexPath) as! CustomRecipeCell
        
        let recipe = RecipeService.shared.recipes[indexPath.row]
        
        cell.recipeLabel.text = recipe.name
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeService.shared.recipes.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
