//
//  SearchController.swift
//  Reciplease
//
//  Created by Nelson Pires Da Silva on 11/10/23.
//

import UIKit

class SearchController: UIViewController {
    
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
    
    private lazy var catchPhraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var grayRectangleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.97, alpha: 1)
        return view
    }()
    
    private lazy var chooseIngredientTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "🔍  Ex. Lemon, Cheese...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textField
    }()
    
    private lazy var addIngredientButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    private lazy var clearIngredientButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    private lazy var searchForRecipesButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    private lazy var titleTableViewLabel: UILabel = {
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
        self.setupGesture()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(CustomIngredientCell.self, forCellReuseIdentifier: CustomIngredientCell.cellIdentifier)
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = 70
        self.tableView.backgroundColor = UIColor.clear

        self.chooseIngredientTextField.delegate = self
    }
    
    // MARK: - Private
    func setupStyle() {
        self.view.backgroundColor = .white
        
        self.titleLabel.text = "Reciplease"
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        self.catchPhraseLabel.text = "What's in your fridge ? 🍤"
        self.catchPhraseLabel.textAlignment = .center
        self.catchPhraseLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        self.grayRectangleView.layer.cornerRadius = 10
        
        self.chooseIngredientTextField.font = UIFont.boldSystemFont(ofSize: 17)
        
        self.addIngredientButton.setTitle("+", for: .normal)
        self.addIngredientButton.backgroundColor = .systemGreen
        self.addIngredientButton.setTitleColor(.white, for: .normal)
        self.addIngredientButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        self.addIngredientButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        
        self.clearIngredientButton.setTitle("🗑️", for: .normal)
        self.clearIngredientButton.setTitleColor(.red, for: .normal)
        self.clearIngredientButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.clearIngredientButton.addTarget(self, action: #selector(clearIngredients), for: .touchUpInside)

        self.titleTableViewLabel.text = "Ingredient"
        self.titleTableViewLabel.textAlignment = .center
        self.titleTableViewLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        self.searchForRecipesButton.setTitle("Search for recipes", for: .normal)
        self.searchForRecipesButton.setTitleColor(.white, for: .normal)
        self.searchForRecipesButton.backgroundColor = .systemIndigo
        self.searchForRecipesButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.searchForRecipesButton.addTarget(self, action: #selector(searchForRecipes), for: .touchUpInside)
    }
    
    func setupSubViews() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.catchPhraseLabel)
        self.view.addSubview(self.grayRectangleView)
        self.view.addSubview(self.addIngredientButton)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.titleTableViewLabel)
        self.view.addSubview(self.clearIngredientButton)
        self.view.addSubview(self.searchForRecipesButton)
        
        self.grayRectangleView.addSubview(self.chooseIngredientTextField)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.catchPhraseLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            self.catchPhraseLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            
            self.grayRectangleView.topAnchor.constraint(equalTo: self.catchPhraseLabel.bottomAnchor, constant: 30),
            self.grayRectangleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            self.grayRectangleView.trailingAnchor.constraint(equalTo: self.addIngredientButton.leadingAnchor, constant: -10),
            self.grayRectangleView.heightAnchor.constraint(equalToConstant: 60),
            
            self.chooseIngredientTextField.centerYAnchor.constraint(equalTo: self.grayRectangleView.centerYAnchor),
            self.chooseIngredientTextField.leadingAnchor.constraint(equalTo: self.grayRectangleView.leadingAnchor, constant: 20),
            
            self.addIngredientButton.topAnchor.constraint(equalTo: self.catchPhraseLabel.bottomAnchor, constant: 30),
            self.addIngredientButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            self.addIngredientButton.heightAnchor.constraint(equalToConstant: 60),
            self.addIngredientButton.widthAnchor.constraint(equalToConstant: 60),
            
            self.clearIngredientButton.topAnchor.constraint(equalTo: self.grayRectangleView.bottomAnchor, constant: 20),
            self.clearIngredientButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            self.clearIngredientButton.heightAnchor.constraint(equalToConstant: 40),
            self.clearIngredientButton.widthAnchor.constraint(equalToConstant: 60),
            
            self.tableView.topAnchor.constraint(equalTo: self.titleTableViewLabel.bottomAnchor, constant: 20),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -30),
            self.tableView.bottomAnchor.constraint(equalTo: self.searchForRecipesButton.topAnchor, constant: -30),
            
            self.titleTableViewLabel.topAnchor.constraint(equalTo: self.grayRectangleView.bottomAnchor, constant: 30),
            self.titleTableViewLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            
            self.searchForRecipesButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -130),
            self.searchForRecipesButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.searchForRecipesButton.heightAnchor.constraint(equalToConstant: 40),
            self.searchForRecipesButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Action
    @objc func add() {
        guard let name = chooseIngredientTextField.text, !name.isEmpty else {
            return
        }
        
        let ingredient = Ingredient(name: name)
        
        IngredientService.shared.add(ingredient: ingredient)
        
        tableView.reloadData()
        
        chooseIngredientTextField.text = ""
    }
    
    @objc func clearIngredients() {
        IngredientService.shared.deleteAllIngredients()
        tableView.reloadData()
    }
    
    @objc func searchForRecipes() {
        let recipesController = RecipesController()
        self.navigationController?.pushViewController(recipesController, animated: false)
        
        recipesController.searchForRecipes()
    }
    
    @objc private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        chooseIngredientTextField.resignFirstResponder()
    }
    
    // MARK: - Core
}

extension SearchController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IngredientService.shared.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomIngredientCell.cellIdentifier, for: indexPath) as! CustomIngredientCell
        
        let ingredient = IngredientService.shared.ingredients[indexPath.row]
        
        cell.ingredientLabel.text = ingredient.name
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

extension SearchController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

