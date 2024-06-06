//
//  ListTableViewController.swift
//  Ingredients2Recipes
//
//  Created by josh flores on 1/10/24.
//

import UIKit
import Firebase
import FirebaseFirestore

class ListTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let viewModel = RecipeViewModel()
    private var refresher: UIRefreshControl!
    
    
    let tableView: UITableView = {
        let tableList = UITableView()
        tableList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableList.rowHeight = 44
        tableList.backgroundColor = .clear
        tableList.translatesAutoresizingMaskIntoConstraints = false
        
        return tableList
        
    }()
    
    func refreshData() {
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(dataRefresh(_:)), for: .valueChanged)
        tableView.refreshControl = refresher
    }
    
    var background: CAGradientLayer = {
       let background = CAGradientLayer()
        background.colors = [
            UIColor.color1.cgColor,
            UIColor.color2.cgColor
        ]
        background.locations = [0.2, 0.8]
        background.startPoint = CGPoint(x: 1.0, y: 0.6)
        background.endPoint = CGPoint(x: 0.9, y: 0.8)
        return background
    }()
    
    @objc private func dataRefresh(_ sender: Any){
        self.viewModel.getData {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.tableView.reloadData()
                self.refresher.endRefreshing()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recipes"
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.layer.insertSublayer(background, at: 0)
        background.frame = self.view.bounds
        self.view.addSubview(tableView)
        
        tableConstraint()
        refreshData()
        
        self.viewModel.getData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableConstraint() {
        let leading = tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let top = tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        let width = tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        let height =  tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        
        NSLayoutConstraint.activate([leading, top, width, height])
    }
    
   
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.viewModel.inHouseRecipe.count
        }else{
            return self.viewModel.onlineRecipes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //        let inHouse = self.viewModel.inHouseRecipe[indexPath.row]
        //        let onlineRecipe = self.viewModel.onlineRecipes[indexPath.row]
        
        if indexPath.section == 0 {
            cell.textLabel?.text = self.viewModel.inHouseRecipe[indexPath.row].name
        }else{
            cell.textLabel?.text = self.viewModel.onlineRecipes[indexPath.row].name
        }
        cell.backgroundColor = .clear
        
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .clear
        
        let headerTitle = UILabel()
        
        if section == 0 {
            headerTitle.text = "Recipes"
            headerTitle.font = UIFont.systemFont(ofSize: 16)
            headerTitle.translatesAutoresizingMaskIntoConstraints = false
            
            header.addSubview(headerTitle)
        }else{
            headerTitle.text = "Special Recipes"
            headerTitle.font = UIFont.systemFont(ofSize: 16)
            headerTitle.translatesAutoresizingMaskIntoConstraints = false
            
            header.addSubview(headerTitle)
        }
        
        
        NSLayoutConstraint.activate([
            headerTitle.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 5),
            headerTitle.centerYAnchor.constraint(equalTo: header.centerYAnchor)
        ])
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            self.navigationController?.pushViewController(
                RecipeViewController(name: self.viewModel.inHouseRecipe[indexPath.row].name,
                                     instruction: viewModel.inHouseRecipe[indexPath.row].instructions,
                                     ingredient: self.viewModel.inHouseRecipe[indexPath.row].ingredient,
                                     onlineIngredient: [],
                                     hours: self.viewModel.inHouseRecipe[indexPath.row].timeHours,
                                     onlineHours: 0,
                                     minutes: self.viewModel.inHouseRecipe[indexPath.row].timeMinute,
                                     onlineMinutes: 0,
                                     selectedRow: indexPath.row,
                                     liked: self.viewModel.inHouseRecipe[indexPath.row].favorite, 
                                     fromOnline: false),
                animated: true)
        }else{
            self.navigationController?.pushViewController(
                RecipeViewController(name: self.viewModel.onlineRecipes[indexPath.row].name,
                                     instruction: self.viewModel.onlineRecipes[indexPath.row].instructions,
                                     ingredient: [],
                                     onlineIngredient: self.viewModel.onlineRecipes[indexPath.row].ingredient ,
                                     hours: 0,
                                     onlineHours: self.viewModel.onlineRecipes[indexPath.row].timeHours,
                                     minutes: 0,
                                     onlineMinutes: self.viewModel.onlineRecipes[indexPath.row].timeMinute,
                                     selectedRow: indexPath.row,
                                     liked: self.viewModel.onlineRecipes[indexPath.row].favorite, 
                                     fromOnline: true),
                animated: true)
        }
        
    }
    
    
    
}
