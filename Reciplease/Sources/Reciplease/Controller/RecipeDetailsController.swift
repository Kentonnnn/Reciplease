//
//  RecipeDetailsController.swift
//  Reciplease
//
//  Created by Nelson Pires Da Silva on 12/6/23.
//

import UIKit

class RecipeDetailsController: UIViewController {
    
    // MARK: - Property
    var recipe: Recipes?
    
    private lazy var ingredientsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomRecipeIngredientsDetails.self, forCellReuseIdentifier: CustomRecipeIngredientsDetails.cellIdentifier)
        return tableView
    }()

    let fullText = "You can find all the necessary instructions by clicking\non 'read more'. This will redirect you to the Edamam\nwebsite, providing you with all the steps needed for the\nsuccessful preparation of this recipe... Read More"
    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var recipeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var instructionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.delegate = self
        return textView
    }()
    
    private lazy var ingredientLabel: UILabel = {
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
        
    }
    
    // MARK: - Private
    func setupStyle() {
        self.view.backgroundColor = .white
        
        self.titleLabel.text = "Detail Recipe"
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        self.recipeLabel.text = recipe?.label
        self.recipeLabel.textAlignment = .center
        self.recipeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.recipeLabel.lineBreakMode = .byWordWrapping
        
        if let imageUrlString = recipe?.image, let imageUrl = URL(string: imageUrlString) {
            self.recipeImageView.af.setImage(withURL: imageUrl)
        }
        
        self.recipeImageView.layer.cornerRadius = 10
        self.recipeImageView.clipsToBounds = true
        
        let attributedString = NSMutableAttributedString(string: fullText)

        if let range = fullText.range(of: "Read More") {
            let nsRange = NSRange(range, in: fullText)

            attributedString.addAttribute(.foregroundColor, value: UIColor.systemIndigo, range: nsRange)
            attributedString.addAttribute(.link, value: "https://www.google.com", range: nsRange)
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 13), range: nsRange)
        }

        self.instructionTextView.attributedText = attributedString
        self.instructionTextView.font = UIFont.systemFont(ofSize: 13)
        self.instructionTextView.isUserInteractionEnabled = true
        self.instructionTextView.linkTextAttributes = [
            .foregroundColor: UIColor.systemIndigo
        ]
        
        self.ingredientLabel.text = "Ingredients"
        self.ingredientLabel.textAlignment = .center
        self.ingredientLabel.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    func setupSubViews() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.recipeImageView)
        self.view.addSubview(self.recipeLabel)
        self.view.addSubview(self.instructionTextView)
        self.view.addSubview(self.ingredientLabel)
        self.view.addSubview(self.ingredientsTableView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.recipeImageView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            self.recipeImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            self.recipeImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            self.recipeImageView.heightAnchor.constraint(equalToConstant: 400),
            
            self.recipeLabel.topAnchor.constraint(equalTo: self.recipeImageView.bottomAnchor, constant: 20),
            self.recipeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            
            self.instructionTextView.topAnchor.constraint(equalTo: self.recipeLabel.bottomAnchor, constant: 5),
            self.instructionTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            
            self.ingredientLabel.topAnchor.constraint(equalTo: self.instructionTextView.bottomAnchor, constant: 10),
            self.ingredientLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            
            self.ingredientsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.ingredientsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.ingredientsTableView.topAnchor.constraint(equalTo: self.ingredientLabel.bottomAnchor, constant: 10)
        ])
    }
    
    // MARK: - Action
    
    // MARK: - Core
}

extension RecipeDetailsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.ingredientLines.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomRecipeIngredientsDetails.cellIdentifier, for: indexPath) as! CustomRecipeIngredientsDetails
        cell.textLabel?.text = recipe?.ingredientLines[indexPath.row]
        return cell
    }
}

extension RecipeDetailsController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}
