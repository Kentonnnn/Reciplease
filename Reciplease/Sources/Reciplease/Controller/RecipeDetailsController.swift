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

    let fullText = "You can find all the necessary instructions by clicking\non 'read more'. This will redirect you to the Edamam\nwebsite, providing you with all the steps needed for the\nsuccessful preparation of this recipe... Read More"

    private var iconFavoritedRecipe = false
    
    // MARK: - Views
    
    private lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var ingredientsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomRecipeIngredientsDetails.self, forCellReuseIdentifier: CustomRecipeIngredientsDetails.cellIdentifier)
        return tableView
    }()
    
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
    
    private lazy var totalTimeRecipe: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var favoriteRecipeImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(favoriteRecipeTapped))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupStyle()
        self.setupSubViews()
        self.setupLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let recipe = recipe {
            iconFavoritedRecipe = FavoriteRecipes.shared.isRecipeFavorite(recipe)
            updateFavoriteIcon()
        }
    }
    
    // MARK: - Private
    func setupStyle() {
        self.view.backgroundColor = .white
        
        self.titleLabel.text = "Detail Recipe"
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        self.recipeLabel.text = recipe?.label
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
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: nsRange)
        }

        self.instructionTextView.attributedText = attributedString
        self.instructionTextView.font = UIFont.systemFont(ofSize: 13)
        self.instructionTextView.isUserInteractionEnabled = true
        self.instructionTextView.linkTextAttributes = [
            .foregroundColor: UIColor.systemIndigo
        ]
        self.instructionTextView.textColor = .gray
        
        self.ingredientLabel.text = "Ingredients"
        self.ingredientLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        if let totalTime = recipe?.totalTime {
            self.totalTimeRecipe.text = "\(totalTime) mn"
        } else {
            self.totalTimeRecipe.text = "N/A"
        }
        self.totalTimeRecipe.backgroundColor = UIColor(red: 0.99, green: 0.94, blue: 0.87, alpha: 1)
        self.totalTimeRecipe.textColor = UIColor(red: 0.99, green: 0.768, blue: 0.50, alpha: 1)
        self.totalTimeRecipe.textAlignment = .center
        self.totalTimeRecipe.font = UIFont.boldSystemFont(ofSize: 13)
        self.totalTimeRecipe.layer.cornerRadius = 5
        self.totalTimeRecipe.clipsToBounds = true
        
    }
    
    func setupSubViews() {
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.favoriteRecipeImageView)
        
        self.scrollView.addSubview(self.containerView)
        
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.recipeImageView)
        self.containerView.addSubview(self.recipeLabel)
        self.containerView.addSubview(self.instructionTextView)
        self.containerView.addSubview(self.ingredientLabel)
        self.containerView.addSubview(self.ingredientsTableView)
        self.containerView.addSubview(self.totalTimeRecipe)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.containerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.containerView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),

            self.titleLabel.topAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.topAnchor),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            
            self.recipeImageView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            self.recipeImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 30),
            self.recipeImageView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -30),
            self.recipeImageView.heightAnchor.constraint(equalToConstant: 400),
            
            self.recipeLabel.topAnchor.constraint(equalTo: self.recipeImageView.bottomAnchor, constant: 20),
            self.recipeLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 30),
            self.recipeLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -30),
            
            self.instructionTextView.topAnchor.constraint(equalTo: self.recipeLabel.bottomAnchor, constant: 5),
            self.instructionTextView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 25),
            
            self.ingredientLabel.topAnchor.constraint(equalTo: self.instructionTextView.bottomAnchor, constant: 15),
            self.ingredientLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 30),
            
            self.ingredientsTableView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 30),
            self.ingredientsTableView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -30),
            self.ingredientsTableView.topAnchor.constraint(equalTo: self.totalTimeRecipe.bottomAnchor, constant: 10),
            self.ingredientsTableView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            self.ingredientsTableView.heightAnchor.constraint(equalToConstant: 400),
            
            self.totalTimeRecipe.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -30),
            self.totalTimeRecipe.topAnchor.constraint(equalTo: self.instructionTextView.bottomAnchor, constant: 10),
            self.totalTimeRecipe.heightAnchor.constraint(equalToConstant: 35),
            self.totalTimeRecipe.widthAnchor.constraint(equalToConstant: 65),
            
            self.favoriteRecipeImageView.heightAnchor.constraint(equalToConstant: 30),
            self.favoriteRecipeImageView.widthAnchor.constraint(equalToConstant: 30),
            self.favoriteRecipeImageView.topAnchor.constraint(equalTo: self.recipeImageView.topAnchor, constant: -15),
            self.favoriteRecipeImageView.trailingAnchor.constraint(equalTo: self.recipeImageView.trailingAnchor, constant: 10)
        ])
    }
    
    @objc private func favoriteRecipeTapped() {
        iconFavoritedRecipe.toggle()
        
        updateFavoriteIcon()

        if iconFavoritedRecipe {
            favoriteRecipeImageView.image = UIImage(named: "star.fill")
            // Ajoutez la recette aux favoris
            if let recipe = recipe {
                FavoriteRecipes.shared.addRecipeToFavorites(recipe)
            }
        } else {
            favoriteRecipeImageView.image = UIImage(named: "star")
            // Retirez la recette des favoris
            if let recipe = recipe {
                FavoriteRecipes.shared.removeRecipeFromFavorites(recipe)
            }
        }

        // Mettez à jour la table view dans FavoriteController
        if let favoriteController = navigationController?.viewControllers.first(where: { $0 is FavoriteController }) as? FavoriteController {
            favoriteController.tableView.reloadData()
        }
    }

    private func updateFavoriteIcon() {
        if iconFavoritedRecipe {
            favoriteRecipeImageView.image = UIImage(named: "star.fill")
        } else {
            favoriteRecipeImageView.image = UIImage(named: "star")
        }
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
