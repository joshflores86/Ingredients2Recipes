//
//  RecipesViewController.swift
//  Ingredients2Recipes
//
//  Created by josh flores on 1/10/24.
//

import UIKit
import CoreData

class RecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let context = AppDelegate.persistentContainer.viewContext
    let recipeRequest = NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
    let ingredientRequest = NSFetchRequest<IngredientEntity>(entityName: "IngredientEntity")
    var viewModel = RecipeViewModel()
    var name: String = ""
    var instruction: String = ""
    var ingredient: [IngredientModel] = []
    var hours: Int16 = 0
    var minutes: Int16 = 0
    var selectedRow: Int?
    var liked: Bool?
    

    
    init( name: String, instruction: String, ingredient: [IngredientModel], hours: Int16, minutes: Int16, liked: Bool) {
        
        self.name = name
        self.instruction = instruction
        self.ingredient = ingredient
        self.hours = hours
        self.minutes = minutes
        self.liked = liked
        
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var likeButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(favorited), for: .touchUpInside)
        return button
    }()
    
    lazy var barButtonItem = UIBarButtonItem(customView: likeButton)
    
    lazy var recipeTitle: UILabel = {
        let title = UILabel()
        title.text = name
        title.font = .monospacedSystemFont(ofSize: 35, weight: .heavy)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    lazy var ingredientTitle: UILabel = {
       let title = UILabel()
        title.text = "Ingredients:"
        title.font = .preferredFont(forTextStyle: .largeTitle)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    lazy var ingredientsList: UITableView = {
       let recipes = UITableView()
        recipes.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        recipes.separatorStyle = .none
        recipes.translatesAutoresizingMaskIntoConstraints = false
        return recipes
    }()
    
    lazy var instrucTitle: UILabel = {
        let title = UILabel()
        title.text = "Instructions:"
        title.font = .preferredFont(forTextStyle: .largeTitle)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var instructions: UILabel = {
        
        let instructs = UILabel()
        instructs.text = instruction
        instructs.font = .monospacedSystemFont(ofSize: 15, weight: .medium)
        instructs.numberOfLines = 0
        instructs.textAlignment = .left
//        instructs.lineBreakMode = .byWordWrapping
        instructs.translatesAutoresizingMaskIntoConstraints = false
       
        return instructs
    }()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = name
        self.navigationItem.rightBarButtonItem = barButtonItem
        ingredientsList.delegate = self
        ingredientsList.dataSource = self
        
        setLikedButton()
        
        view.addSubview(scrollView)
        

        scrollViewConstraint()
        
    }
    
    func titleConstraint() {
        let leading = recipeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        let top = recipeTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 90)
        let width = recipeTitle.widthAnchor.constraint(equalToConstant: 200)
        let height = recipeTitle.heightAnchor.constraint(equalToConstant: 40)
        
        NSLayoutConstraint.activate([leading,top,width,height])
    }
    
    func scrollViewConstraint() {
        let leading = scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        let top = scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        let width = scrollView.widthAnchor.constraint(equalToConstant: 350)
        let bottom = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        
        NSLayoutConstraint.activate([leading,top,width,bottom])
        
        scrollView.addSubview(ingredientTitle)
        scrollView.addSubview(ingredientsList)
        scrollView.addSubview(instrucTitle)
        scrollView.addSubview(instructions)
        
        ingredientTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        ingredientTitle.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        ingredientTitle.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        ingredientTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        ingredientsList.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        ingredientsList.topAnchor.constraint(equalTo: ingredientTitle.bottomAnchor, constant: 5).isActive = true
        ingredientsList.heightAnchor.constraint(equalToConstant: 200).isActive = true
        ingredientsList.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -10).isActive = true
        
        instrucTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        instrucTitle.topAnchor.constraint(equalTo: ingredientsList.bottomAnchor, constant: 10).isActive = true
        instrucTitle.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        instrucTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true

        instructions.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        instructions.topAnchor.constraint(equalTo: instrucTitle.bottomAnchor, constant: 10).isActive = true
        instructions.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10).isActive = true
        instructions.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20).isActive = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredient.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let ingredients = viewModel.inHouseRecipe[indexPath.row].ingredient
        
        selectedRow = indexPath.row
        
        let ingredientString = ingredients.map { ingredient in
            return "* \(ingredient.quantity) \(ingredient.unit.rawValue == "N/A" ? "" : ingredient.unit.rawValue) \(ingredient.ingredients) "
        }
        
        let jointStrings = ingredientString.joined(separator: "\n")
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = jointStrings
        
        return cell
        
    }
    
    @objc func favorited() {
        likeButton.isSelected.toggle()
        liked = likeButton.isSelected
        
        
        if liked != false {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
            likeButton.tintColor = UIColor.red
            UserDefaults.standard.setValue(true, forKey: "Likedrecipe_\(name)")
            let recipe = RecipeModel(name: name,
                                     ingredient: ingredient,
                                     instructions: instruction,
                                     timeHours: hours,
                                     timeMinute: minutes,
                                     favorite: liked ?? false)
            viewModel.saveRecipe(recipe)
            print("item has been liked")
//            setLikedButton()
        }else{
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = UIColor.systemBlue
            recipeRequest.predicate = NSPredicate(format: "name == %@", name)
            UserDefaults.standard.removeObject(forKey: "Likedrecipe_\(name)")
            do{
                let results = try context.fetch(recipeRequest)
                if let lastRecipe = results.last {
                    context.delete(lastRecipe)
                    print("Last item has been unliked")
                }else{
                    print("No item to remove")
                }
            }catch{
                print("Error fetching and deleting recipe: \(error)")
            }
            
            print("item has been unliked")
        }
    }
    
    
    
    func setLikedButton() {
        let liked = UserDefaults.standard.bool(forKey: "Likedrecipe_\(name)")
        likeButton.isSelected = liked
        likeButton.tintColor = liked ? UIColor.red : UIColor.systemBlue
        likeButton.setImage(liked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
    }
    
}


