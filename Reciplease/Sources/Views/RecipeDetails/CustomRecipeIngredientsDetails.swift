//
//  CustomRecipeIngredientsDetails.swift
//  Reciplease
//
//  Created by Nelson Pires Da Silva on 12/6/23.
//

import UIKit

class CustomRecipeIngredientsDetails: UITableViewCell {

    static var cellIdentifier = "RecipeIngredientsDetails"
    
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

    }
    
    func setupView() {

    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([

        ])
    }
}
