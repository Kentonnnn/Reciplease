//
//  CustomIngredientView.swift
//  Reciplease
//
//  Created by Nelson Pires Da Silva on 11/13/23.
//

import UIKit

class CustomIngredientCell: UITableViewCell {
    
    static var cellIdentifier = "IngredientCell"
    
    private let containerView = UIView()
    
    let ingredientLabel = UILabel()
    
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
        self.layer.cornerRadius = 10
        self.containerView.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func setupView() {
        self.containerView.addSubview(ingredientLabel)
        
        self.contentView.addSubview(containerView)
        
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.ingredientLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            self.containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            
            self.ingredientLabel.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            self.ingredientLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10)
        ])
    }
}
