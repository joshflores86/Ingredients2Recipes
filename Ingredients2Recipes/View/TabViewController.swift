//
//  ViewController.swift
//  Ingredients2Recipes
//
//  Created by josh flores on 1/10/24.
//

import UIKit
import Firebase
import FirebaseFirestore

class TabViewController: UITabBarController, UITabBarControllerDelegate {
    
    lazy var viewModel = RecipeViewModel()
    
    lazy var saveButton: UIButton = {
       let save = UIButton()
        save.titleLabel?.text = "Save"
        save.setTitleColor(UIColor.blue, for: .normal)
        save.titleLabel?.font = .systemFont(ofSize: 20)
        
        return save
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        self.delegate = self
        
        let recipeView = ListTableViewController()
        let likedView = LikedTableViewController()
        let customView = CustomRecipesViewController()
        
        recipeView.tabBarItem = UITabBarItem(title: "Recipes", image: UIImage(systemName: "list.bullet.rectangle"), tag: 0)
        likedView.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart.fill"), tag: 1)
        customView.tabBarItem = UITabBarItem(title: "Custom", image: UIImage(systemName: "square.and.pencil"), tag: 2)
        
        self.viewControllers = [ recipeView, likedView, customView]
        
        navigationItem.title = "Recipes"
        
        customView.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch tabBarController.selectedIndex {
        case 0:
            navigationItem.title = "Recipes"
        case 1:
            navigationItem.title = "Favorite"
        case 2:
            navigationItem.title = "Custom Recipe"
            
        default:
            break
        }
    }


}
