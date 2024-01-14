//
//  ViewController.swift
//  Ingredients2Recipes
//
//  Created by josh flores on 1/10/24.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        let recipeView = ListTableViewController()
        let likedView = LikedTableViewController()
        
        recipeView.tabBarItem = UITabBarItem(title: "Recipes", image: UIImage(systemName: "list.bullet.rectangle"), tag: 0)
        likedView.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart.fill"), tag: 1)
        
        self.viewControllers = [ recipeView, likedView]
        
        navigationItem.title = "Recipes"
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch tabBarController.selectedIndex {
        case 0:
            navigationItem.title = "Recipes"
        case 1:
            navigationItem.title = "Favorite"
        default:
            break
        }
    }


}
