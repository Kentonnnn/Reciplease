//
//  CustomIngredientView.swift
//  Reciplease
//
//  Created by Nelson Pires Da Silva on 11/13/23.
//

import UIKit

class CustomRecipeCell: UITableViewCell {
    
    private lazy var blackRectangleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    static var cellIdentifier = "RecipeCell"
    
    private let containerView = UIView()
    
    let recipeLabel = UILabel()
    
    let recipeImageView = UIImageView()
    
    let ingredientLabel = UILabel()
    
    let totalTimeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStyle()
        setupView()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupStyle()
        setupView()
        setupLayout()
    }
    
    private func setupStyle() {
        self.containerView.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.97, alpha: 1)
        
        self.clipsToBounds = true
        
        self.recipeLabel.textColor = .white
        self.recipeLabel.font = UIFont.boldSystemFont(ofSize: 17)
        self.recipeLabel.numberOfLines = 1
        self.recipeLabel.lineBreakMode = .byTruncatingTail
        
        self.ingredientLabel.textColor = .white
        self.ingredientLabel.font = UIFont.boldSystemFont(ofSize: 10)
        self.ingredientLabel.numberOfLines = 1
        self.ingredientLabel.lineBreakMode = .byTruncatingTail
        
        self.recipeImageView.contentMode = .scaleAspectFill
        self.recipeImageView.clipsToBounds = true
        
        self.totalTimeLabel.backgroundColor = .black
        self.totalTimeLabel.textColor = .white
        self.totalTimeLabel.textAlignment = .center
        self.totalTimeLabel.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    func setupView() {
        self.containerView.addSubview(self.recipeImageView)
        self.containerView.addSubview(self.blackRectangleView)
        self.containerView.addSubview(self.recipeLabel)
        self.containerView.addSubview(self.ingredientLabel)
        self.containerView.addSubview(self.totalTimeLabel)
        
        self.contentView.addSubview(self.containerView)
        
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.recipeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        self.blackRectangleView.translatesAutoresizingMaskIntoConstraints = false
        self.ingredientLabel.translatesAutoresizingMaskIntoConstraints = false
        self.totalTimeLabel.translatesAutoresizingMaskIntoConstraints = false

    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            self.containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            
            self.recipeImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            self.recipeImageView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            self.recipeImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.recipeImageView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            
            self.blackRectangleView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.blackRectangleView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            self.blackRectangleView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            self.blackRectangleView.heightAnchor.constraint(equalToConstant: 40),
            
            self.recipeLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10),
            self.recipeLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.containerView.trailingAnchor, constant: -10),
            self.recipeLabel.topAnchor.constraint(equalTo: self.blackRectangleView.topAnchor, constant: 5),
            
            self.ingredientLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10),
            self.ingredientLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.containerView.trailingAnchor, constant: -10),
            self.ingredientLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -5),
                    
            //self.totalTimeLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10),
            self.totalTimeLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10),
            self.totalTimeLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 10),
            self.totalTimeLabel.heightAnchor.constraint(equalToConstant: 40),
            self.totalTimeLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}

