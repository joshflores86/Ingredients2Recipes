//
//  ViewController.swift
//  Ingredients2Recipes
//
//  Created by josh flores on 1/10/24.
//

import UIKit
import CoreData

class LikedTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var viewModel = RecipeViewModel()
    let request = NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
    let context = AppDelegate.persistentContainer.viewContext

    let tableView: UITableView = {
      let likedList = UITableView()
        likedList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        likedList.rowHeight = 44
        likedList.translatesAutoresizingMaskIntoConstraints = false
       return likedList
    }()
    

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        tableViewConstraint()
        
        tableView.reloadData()
        
    }
    
    func tableViewConstraint() {
        let leading = tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let top = tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        let width = tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        let height =  tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        
        NSLayoutConstraint.activate([leading, top, width, height])
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellCount = viewModel.fetchRequest().count
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = viewModel.fetchRequest()
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = recipe[indexPath.row].name
        
        let chevron: UIImageView = {
           let label = UIImageView()
            label.image = UIImage(systemName: "chevron.right")
            label.tintColor = .gray
            label.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(label)
            
            return label
        }()
        
        NSLayoutConstraint.activate([
            chevron.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            chevron.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])
        
        return cell
    }

   
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let recipe = try? context.fetch(request)
        
        if let deletedRecipe = recipe?.first(where: { $0.name == recipe?[indexPath.row].name }) {
            if editingStyle == .delete {
                context.delete(deletedRecipe)
                tableView.deleteRows(at: [indexPath], with: .fade)
                UserDefaults.standard.removeObject(forKey: "Likedrecipe_\(String(describing: recipe?[indexPath.row].name))")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let recipe = viewModel.fetchRequest()
        navigationController?.pushViewController(RecipeViewController(name: recipe[indexPath.row].name,
                                                                      instruction: recipe[indexPath.row].instructions,
                                                                      ingredient: recipe[indexPath.row].ingredient,
                                                                      hours: recipe[indexPath.row].timeHours,
                                                                      minutes: recipe[indexPath.row].timeMinute,
                                                                      liked: recipe[indexPath.row].favorite),
                                                 animated: true)
        
    }
    
    
}
