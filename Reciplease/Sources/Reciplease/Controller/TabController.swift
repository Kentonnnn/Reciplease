//
//  TabController.swift
//  Reciplease
//
//  Created by Nelson Pires Da Silva on 11/10/23.
//

import UIKit

class TabController: UITabBarController, UITabBarControllerDelegate {
    
    private let customTabBarView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            self.delegate = self
            self.setupTabs()
            self.setupCustomTabBar()

            self.tabBar.isTranslucent = true
            self.tabBar.tintColor = .systemIndigo

            self.view.addSubview(customTabBarView)
            self.view.bringSubviewToFront(self.tabBar)
        }

        private func setupTabs() {
            let search = self.createNav(with: "", and: UIImage(systemName: "safari.fill"), vc: SearchController())
            let favorite = self.createNav(with: "", and: UIImage(systemName: "heart.fill"), vc: FavoriteController())
            let settings = self.createNav(with: "", and: UIImage(systemName: "gearshape.fill"), vc: SettingsController())
            self.setViewControllers([search, favorite, settings], animated: true)
        }

        private func setupCustomTabBar() {
            view.addSubview(customTabBarView)

            NSLayoutConstraint.activate([
                customTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                customTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                customTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                customTabBarView.heightAnchor.constraint(equalToConstant: 100)
            ])
            
            customTabBarView.layer.shadowColor = UIColor.black.cgColor
            customTabBarView.layer.shadowOpacity = 0.3
            customTabBarView.layer.shadowOffset = CGSize(width: 0, height: -3)
            customTabBarView.layer.shadowRadius = 5
        }

        private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
            let nav = UINavigationController(rootViewController: vc)
            nav.tabBarItem.title = title
            nav.tabBarItem.image = image
            return nav
        }
    }



