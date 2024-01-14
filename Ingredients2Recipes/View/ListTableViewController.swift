//
//  ListTableViewController.swift
//  Ingredients2Recipes
//
//  Created by josh flores on 1/10/24.
//

import UIKit

class ListTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    lazy var viewModel = RecipeViewModel()
    
   
    
    let tableView: UITableView = {
       let tableList = UITableView()
       tableList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableList.rowHeight = 44
        tableList.translatesAutoresizingMaskIntoConstraints = false
        return tableList
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Recipes"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        
        tableConstraint()
        
    }
    
    func tableConstraint() {
        let leading = tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let top = tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        let width = tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        let height =  tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        
        NSLayoutConstraint.activate([leading, top, width, height])
    }

    // MARK: - Table view data source

   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.inHouseRecipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.inHouseRecipe[indexPath.row].name
        
        let chevron: UIImageView = {
            let label = UIImageView(image: UIImage(systemName: "chevron.right"))
            label.translatesAutoresizingMaskIntoConstraints = false
            label.tintColor = .gray
            
            cell.contentView.addSubview(label)
            
            return label
        }()
        
        NSLayoutConstraint.activate([
            chevron.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
            chevron.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(
            RecipeViewController(name: viewModel.inHouseRecipe[indexPath.row].name,
                                 instruction: viewModel.inHouseRecipe[indexPath.row].instructions,
                                 ingredient: viewModel.inHouseRecipe[indexPath.row].ingredient,
                                 hours: viewModel.inHouseRecipe[indexPath.row].timeHours,
                                 minutes: viewModel.inHouseRecipe[indexPath.row].timeMinute,
                                 liked: viewModel.inHouseRecipe[indexPath.row].favorite),
            animated: true)
    }
    

}
