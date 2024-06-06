//
//  RecipesViewController.swift
//  Ingredients2Recipes
//
//  Created by josh flores on 1/10/24.
//

import UIKit
import CoreData
import Firebase

class RecipeViewController: UIViewController/*, UITableViewDataSource, UITableViewDelegate*/ {
    
    let context = AppDelegate.persistentContainer.viewContext
    let recipeRequest = NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
    let ingredientRequest = NSFetchRequest<IngredientEntity>(entityName: "IngredientEntity")
    var viewModel = RecipeViewModel()
    var name: String = ""
//    var onlineName: String = ""
    var instruction: String = ""
//    var onlineInstruction: String = ""

    var ingredient: [IngredientModel] = []
    var onlineIngredient: [OnlineIngredientModel] = []

    var hours: Int16 = 0
    var onlineHours: Int = 0

    var minutes: Int16 = 0
    var onlineMinutes: Int = 0

    var selectedRow: Int
    var liked: Bool?
    
    private var fromOnline: Bool!
    

    
    init( name: String, instruction: String, ingredient: [IngredientModel], onlineIngredient: [OnlineIngredientModel], hours: Int16, onlineHours: Int, minutes: Int16, onlineMinutes: Int, selectedRow: Int, liked: Bool, fromOnline: Bool) {
        
        self.name = name
        self.instruction = instruction
        self.ingredient = ingredient
        self.onlineIngredient = onlineIngredient
        self.hours = hours
        self.onlineHours = onlineHours
        self.minutes = minutes
        self.onlineMinutes = onlineMinutes
        self.selectedRow = selectedRow
        self.liked = liked
        self.fromOnline = fromOnline
        
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
        title.font = .monospacedSystemFont(ofSize: 20, weight: .heavy)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    lazy var ingredientsList: UILabel = {
       let recipes = UILabel()
        recipes.numberOfLines = 0
        recipes.translatesAutoresizingMaskIntoConstraints = false
        var ingredientString = ""
        if ingredient.count != 0 {
            for ingredients in ingredient {
                ingredientString += "• \(ingredients.quantity) \(ingredients.unit.rawValue == "N/A" ? "" : ingredients.unit.rawValue) \(ingredients.ingredients)\n "
            }
            recipes.text = ingredientString
        }else{
            for ingredients in onlineIngredient {
                ingredientString += "• \(ingredients.quantity) \(ingredients.unit.rawValue == "N/A" ? "" : ingredients.unit.rawValue) \(ingredients.ingredients)\n "
            }
            recipes.text = ingredientString
        }
        return recipes
    }()
    
    lazy var instrucTitle: UILabel = {
        let title = UILabel()
        title.text = "Instructions:"
        title.font = .monospacedSystemFont(ofSize: 20, weight: .heavy)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var instructions: UILabel = {
        
        let instructs = UILabel()
        instructs.text = instruction
        instructs.font = .monospacedSystemFont(ofSize: 15, weight: .medium)
        instructs.sizeToFit()
        instructs.center = CGPoint(x: instrucContainerView.bounds.midX, y: instrucContainerView.bounds.midY)
        instructs.numberOfLines = 0
        instructs.textAlignment = .left
        instructs.lineBreakMode = .byWordWrapping
        instructs.translatesAutoresizingMaskIntoConstraints = false
       
        return instructs
    }()
    
    lazy var cookTimeTitle: UILabel = {
       let cookTitle = UILabel()
        cookTitle.text = "Cook Time:"
        cookTitle.font = .monospacedSystemFont(ofSize: 20, weight: .heavy)
        cookTitle.translatesAutoresizingMaskIntoConstraints = false
        return cookTitle
    }()
    
    lazy var cookTime: UILabel = {
        let time = UILabel()
        if hours == 0 && minutes == 0 {
            time.text = "\(onlineHours) hours \(onlineMinutes) minutes"
            time.translatesAutoresizingMaskIntoConstraints = false
        }else{
            time.text = "\(hours) hours \(minutes) minutes"
            time.translatesAutoresizingMaskIntoConstraints = false
        }
        
        return time
    }()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    let containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let innerView: UIView = {
        let view = UIView()
        
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 8.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let instructScrollView: UIScrollView = {
        let instructScroll = UIScrollView()
        instructScroll.translatesAutoresizingMaskIntoConstraints = false
        instructScroll.indicatorStyle = .black
        return instructScroll
    }()
    
    let instrucContainerView: UIView = {
        let margin: CGFloat = 10
        let instructView = UIView()
        instructView.frame = CGRect(x: 0, y: 0, width: instructView.frame.width + margin * 2, height: instructView.frame.height + margin * 2)
        instructView.translatesAutoresizingMaskIntoConstraints = false
        return instructView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = name
        self.navigationItem.rightBarButtonItem = barButtonItem
        self.innerView.frame = instrucContainerView.frame
        
        setLikedButton()
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
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
        let leading = scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let top = scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let width = scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        let bottom = scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        
        NSLayoutConstraint.activate([leading,top,width,bottom])
        
        containerView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, multiplier: 1).isActive = true

        
        containerView.addSubview(ingredientTitle)
        containerView.addSubview(ingredientsList)
        containerView.addSubview(instrucTitle)
        containerView.addSubview(innerView)
        innerView.addSubview(instructScrollView)
        instructScrollView.addSubview(instrucContainerView)
        instrucContainerView.addSubview(instructions)
        containerView.addSubview(cookTimeTitle)
        containerView.addSubview(cookTime)
        
        ingredientTitle.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10).isActive = true
        ingredientTitle.topAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        ingredientTitle.widthAnchor.constraint(equalTo: self.containerView.widthAnchor).isActive = true
        ingredientTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        ingredientsList.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 5).isActive = true
        ingredientsList.topAnchor.constraint(equalTo: self.ingredientTitle.bottomAnchor, constant: 5).isActive = true
        ingredientsList.heightAnchor.constraint(equalToConstant: 200).isActive = true
        ingredientsList.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -5).isActive = true
        
        instrucTitle.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10).isActive = true
        instrucTitle.topAnchor.constraint(equalTo: self.ingredientsList.bottomAnchor, constant: 10).isActive = true
        instrucTitle.widthAnchor.constraint(equalTo: self.containerView.widthAnchor).isActive = true
        instrucTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        innerView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 5).isActive = true
        innerView.topAnchor.constraint(equalTo: self.instrucTitle.bottomAnchor, constant: 10).isActive = true
        innerView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -5).isActive = true
//        innerView.heightAnchor.constraint(equalToConstant: 480).isActive = true
        
        instructScrollView.leadingAnchor.constraint(equalTo: self.innerView.leadingAnchor).isActive = true
        instructScrollView.topAnchor.constraint(equalTo: self.innerView.topAnchor).isActive = true
        instructScrollView.widthAnchor.constraint(equalTo: self.innerView.widthAnchor).isActive = true
        instructScrollView.bottomAnchor.constraint(equalTo: self.innerView.bottomAnchor).isActive = true
        
        instrucContainerView.leadingAnchor.constraint(equalTo: self.instructScrollView.leadingAnchor).isActive = true
        instrucContainerView.topAnchor.constraint(equalTo: self.instructScrollView.topAnchor).isActive = true
        instrucContainerView.widthAnchor.constraint(equalTo: self.instructScrollView.widthAnchor).isActive = true
        instrucContainerView.bottomAnchor.constraint(equalTo: self.instructScrollView.bottomAnchor).isActive = true
        instrucContainerView.heightAnchor.constraint(equalTo: self.instructScrollView.heightAnchor, multiplier: 2).isActive = true

        instructions.leadingAnchor.constraint(equalTo: self.instrucContainerView.leadingAnchor, constant: 5).isActive = true
        instructions.topAnchor.constraint(equalTo: self.instrucContainerView.topAnchor, constant: 5).isActive = true
        instructions.heightAnchor.constraint(equalTo: self.instrucContainerView.heightAnchor, constant: -5).isActive = true
        instructions.widthAnchor.constraint(equalTo: self.instrucContainerView.widthAnchor, constant: -10).isActive = true
        
        cookTimeTitle.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 5).isActive = true
        cookTimeTitle.topAnchor.constraint(equalTo: self.innerView.bottomAnchor, constant: 10).isActive = true
        cookTimeTitle.widthAnchor.constraint(equalToConstant: 175).isActive = true
        cookTimeTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true

        cookTime.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10).isActive = true
        cookTime.topAnchor.constraint(equalTo: self.cookTimeTitle.bottomAnchor, constant: 10).isActive = true
        cookTime.widthAnchor.constraint(equalToConstant: 150).isActive = true
        cookTime.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setLikedButton() {
        let liked = UserDefaults.standard.bool(forKey: "Likedrecipe_\(name)")
        likeButton.isSelected = liked
        likeButton.tintColor = liked ? UIColor.red : UIColor.systemBlue
        likeButton.setImage(liked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
    }
    
    @objc func favorited() {
        likeButton.isSelected.toggle()
        liked = likeButton.isSelected
        
        
        if liked != false {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
            likeButton.tintColor = UIColor.red
            UserDefaults.standard.setValue(true, forKey: "Likedrecipe_\(name)")
            if fromOnline {
                let recipe = OnlineRecipeModel(name: name,
                                               ingredient: onlineIngredient,
                                               instructions: instructions.text ?? "",
                                               timeHours: onlineHours,
                                               timeMinute: onlineMinutes,
                                               favorite: liked ?? false)
                viewModel.saveOnlineRecipe(recipe)
                print("item has been liked")
            }else{
                
                let recipe = RecipeModel(name: name,
                                         ingredient: ingredient,
                                         instructions: instruction,
                                         timeHours: hours,
                                         timeMinute: minutes,
                                         favorite: liked ?? false)
                viewModel.saveRecipe(recipe)
                print("item has been liked")
            }
            
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
    
    
    
    
    
}


