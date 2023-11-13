//
//  SearchController.swift
//  Reciplease
//
//  Created by Nelson Pires Da Silva on 11/10/23.
//

import UIKit

class SearchController: UIViewController {
    
    // MARK: - Property
    
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
    
    private lazy var chooseIngredientLabel: UITextField = {
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

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupStyle()
        self.setupSubViews()
        self.setupLayout()

        let startColor = UIColor.white.cgColor
        let endColor = UIColor(red: 0.97, green: 0.97, blue: 0.98, alpha: 1).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [startColor, endColor]
        gradientLayer.locations = [0.0, 1.0]

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: - Private
    func setupStyle() {
        self.titleLabel.text = "Reciplease"
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        self.catchPhraseLabel.text = "What's in your fridge ? 🍤"
        self.catchPhraseLabel.textAlignment = .center
        self.catchPhraseLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        self.grayRectangleView.layer.cornerRadius = 10
        
        self.chooseIngredientLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        self.addIngredientButton.setTitle("+", for: .normal)
        self.addIngredientButton.backgroundColor = .systemGreen
        self.addIngredientButton.setTitleColor(.white, for: .normal)
        self.addIngredientButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        //self.addIngredientButton.addTarget(self, action: #selector(save), for: .touchUpInside)
    }
    
    func setupSubViews() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.catchPhraseLabel)
        self.view.addSubview(self.grayRectangleView)
        self.view.addSubview(self.addIngredientButton)
        
        self.grayRectangleView.addSubview(self.chooseIngredientLabel)
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
            
            self.chooseIngredientLabel.centerYAnchor.constraint(equalTo: self.grayRectangleView.centerYAnchor),
            self.chooseIngredientLabel.leadingAnchor.constraint(equalTo: self.grayRectangleView.leadingAnchor, constant: 20),

            self.addIngredientButton.topAnchor.constraint(equalTo: self.catchPhraseLabel.bottomAnchor, constant: 30),
            self.addIngredientButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            self.addIngredientButton.heightAnchor.constraint(equalToConstant: 60),
            self.addIngredientButton.widthAnchor.constraint(equalToConstant: 60),
        ])
    }

    // MARK: - Action

    // MARK: - Core

}
