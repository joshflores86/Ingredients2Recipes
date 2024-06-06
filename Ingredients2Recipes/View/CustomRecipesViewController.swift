//
//  CustomRecipesViewController.swift
//  Ingredients2Recipes
//
//  Created by Josh Flores on 1/13/24.
//

import UIKit
import Firebase

class CustomRecipesViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {
    
    
    
    var viewModel = RecipeViewModel()
    //    private var textView: UITextView!
    private var textFieldArray: [UITextField] = []
    private var newPickerArray: [UITextField] = []
    private var pickersEntry: [IngredientEntry] = []
    private var qtyTextField: [UITextField] = []
    private var ingredList: [IngredientModel] = []
    private var containerHeight: NSLayoutConstraint!
    private var selectedPicker: [IngredientModel.UnitOfMeasure] = []
    private var unitsOfMeasure: [IngredientModel.UnitOfMeasure] = [.cup, .gallon, .grams, .oz, .pint, .quart, .tableSpoon, .teaSpoon, .qty, .none]
    private var selectedHours: Int!
    private var selectedMinutes: Int!
    private var addUp: Int = 0
    private var indexing: Int = 1
    private var containerViewHeight = 1.0
    private let textPlaceHolder = "Add instructions"
    private var instructionTitleTopAnchorConstraint: NSLayoutConstraint!
    
    let containerView: UIView = {
        let newView = UIView()
        
        newView.translatesAutoresizingMaskIntoConstraints = false
        return newView
    }()
    
    let scrollView: UIScrollView = {
        let coolView = UIScrollView()
        
        coolView.translatesAutoresizingMaskIntoConstraints = false
        return coolView
    }()
    
    lazy var recipeName: UILabel = {
        let name = UILabel()
        name.text = "Recipe Name"
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    lazy var nameTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Enter Recipe Name"
//        text.text = viewModel.customRecipes.first?.name
        text.translatesAutoresizingMaskIntoConstraints = false
        text.delegate = self
        text.borderStyle = .roundedRect
        return text
    }()
    
    
    
    lazy var customIngredient: UILabel = {
        let ingredientLabel = UILabel()
        ingredientLabel.text = "Ingredient"
        ingredientLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientLabel
    }()
    
    lazy var addTextFieldButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Add Ingredient", for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.backgroundColor = .systemBlue
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addedStep), for: .touchUpInside)
        return button
    }()
    
    lazy var ingredientTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Add ingredient"
//        textfield.delegate = self
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderStyle = .roundedRect
        
        textFieldArray.append(textfield)
        
        return textfield
    }()
    
    lazy var unitPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        picker.tag = addUp
        addUp += 1
        return picker
    }()
    
    lazy var textFieldPicker: UITextField = {
        let textfield = UITextField()
        textfield.inputView = unitPicker
        textfield.tag = unitPicker.tag
        textfield.placeholder = "Select unit"
        textfield.borderStyle = .roundedRect
        textfield.textAlignment = .center
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        newPickerArray.append(textfield)
        
        return textfield
    }()
    
    lazy var quantityTextField:  UITextField = {
        let qty = UITextField()
        qty.placeholder = "Qty"
        qty.keyboardType = .numberPad
        qty.borderStyle = .roundedRect
        qty.delegate = self
        qty.translatesAutoresizingMaskIntoConstraints = false
        qtyTextField.append(qty)
        return qty
        
    }()
    
    lazy var instructionTitle: UILabel = {
        let title = UILabel()
        title.text = "Instructions"
        title.translatesAutoresizingMaskIntoConstraints = false
        title.frame = CGRect(x: 10, y: 400, width: 150, height: 35)
        return title
    }()
    
    lazy var longTextView: UITextView = {
        let longText = UITextView()
        longText.isEditable = true
        longText.isScrollEnabled = true
        longText.text = textPlaceHolder
        longText.font = UIFont.systemFont(ofSize: 16)
        longText.textColor = UIColor.lightGray
        longText.textAlignment = .left
        longText.layer.borderColor = UIColor.lightGray.cgColor
        longText.layer.borderWidth = 1.0
        longText.layer.cornerRadius = 8.0
        longText.translatesAutoresizingMaskIntoConstraints = false
        longText.delegate = self
        return longText
    }()
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textPlaceHolder {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = textPlaceHolder
            textView.textColor = UIColor.lightGray
        }
    }
    
    lazy var timeLabel: UILabel = {
        let timeTxt = UILabel()
        timeTxt.text = "Total Time"
        timeTxt.translatesAutoresizingMaskIntoConstraints = false
        return timeTxt
    }()
    
    lazy var timePicker: UIPickerView = {
        let time = UIPickerView()
        time.delegate = self
        time.dataSource = self
        time.tag = 100
        time.layer.borderWidth = 1.0
        time.layer.borderColor = UIColor.lightGray.cgColor
        time.layer.cornerRadius = 8.0
        time.translatesAutoresizingMaskIntoConstraints = false
        return time
    }()
    
    lazy var saveButton: UIButton = {
        let save = UIButton(type: .custom)
        save.setTitle("Save Recipe", for: .normal)
        save.setTitleColor(.black, for: .normal)
        save.setTitleColor(.white, for: .highlighted)
        save.backgroundColor = .systemBlue
        save.addTarget(self, action: #selector(saveRecipe), for: .touchUpInside)
        save.layer.cornerRadius = 10
        save.layer.masksToBounds = true
        save.titleLabel?.font = .systemFont(ofSize: 17)
        save.translatesAutoresizingMaskIntoConstraints = false
        return save
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Custom Recipe"
        
        view.addSubview(scrollView)
        self.scrollView.addSubview(containerView)
        self.containerView.addSubview(recipeName)
        self.containerView.addSubview(nameTextField)
        self.containerView.addSubview(saveButton)
        self.containerView.addSubview(customIngredient)
        self.containerView.addSubview(quantityTextField)
        self.containerView.addSubview(addTextFieldButton)
        self.containerView.addSubview(textFieldPicker)
        self.containerView.addSubview(ingredientTextField)
        self.containerView.addSubview(instructionTitle)
        self.containerView.addSubview(longTextView)
        self.containerView.addSubview(timeLabel)
        self.containerView.addSubview(timePicker)
        
        
        self.longTextView.delegate = self
        self.ingredientTextField.delegate = self
        
        let newPickerEntry = IngredientEntry(textField: ingredientTextField, picker: textFieldPicker)
        
        pickersEntry.append(newPickerEntry)
        
        scrollViewConstraint()
        containerViewConstraint()
        recipeNameConstraint()
        nameConstraint()
        saveButtonConstraint()
        ingredientContraint()
        qtyTextFieldconstraint()
        textFieldButtonConstraint()
        ingrediTextField()
        dropDownConstraint()
        instructionTitleConstraint()
        longTextConstraint()
        timeLabelConstraint()
        timePickerConstraint()
        
        self.scrollView.contentSize = containerView.bounds.size
    }
    func containerViewConstraint() {
        containerHeight = containerView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, multiplier: containerViewHeight)
        
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            containerHeight
        ])
    }
    
    func scrollViewConstraint() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func recipeNameConstraint() {
        NSLayoutConstraint.activate([
            recipeName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            recipeName.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            recipeName.widthAnchor.constraint(equalToConstant: 150),
            recipeName.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func nameConstraint() {
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            nameTextField.topAnchor.constraint(equalTo: recipeName.bottomAnchor, constant: 10),
            nameTextField.widthAnchor.constraint(equalToConstant: 250),
            nameTextField.heightAnchor.constraint(equalToConstant: 35)
            
        ])
    }
    
    func saveButtonConstraint() {
        NSLayoutConstraint.activate([
            saveButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            saveButton.topAnchor.constraint(equalTo: recipeName.bottomAnchor, constant: 10),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            saveButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    func ingredientContraint() {
        NSLayoutConstraint.activate([
            customIngredient.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            customIngredient.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            customIngredient.widthAnchor.constraint(equalToConstant: 150),
            customIngredient.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func textFieldButtonConstraint() {
        NSLayoutConstraint.activate([
            addTextFieldButton.leadingAnchor.constraint(equalTo: customIngredient.trailingAnchor, constant: 100),
            addTextFieldButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            addTextFieldButton.widthAnchor.constraint(equalToConstant: 125),
            addTextFieldButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func ingrediTextField() {
        NSLayoutConstraint.activate([
            ingredientTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            ingredientTextField.topAnchor.constraint(equalTo: addTextFieldButton.bottomAnchor, constant: 20),
            ingredientTextField.widthAnchor.constraint(equalToConstant: 200),
            ingredientTextField.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    
    func qtyTextFieldconstraint() {
        NSLayoutConstraint.activate([
            quantityTextField.leadingAnchor.constraint(equalTo: ingredientTextField.trailingAnchor, constant: 5),
            quantityTextField.topAnchor.constraint(equalTo: addTextFieldButton.bottomAnchor, constant: 20),
            quantityTextField.widthAnchor.constraint(equalToConstant: 75),
            quantityTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    func dropDownConstraint() {
        NSLayoutConstraint.activate([
            textFieldPicker.leadingAnchor.constraint(equalTo: quantityTextField.trailingAnchor, constant: 5),
            textFieldPicker.topAnchor.constraint(equalTo: addTextFieldButton.bottomAnchor, constant: 20),
            textFieldPicker.widthAnchor.constraint(equalToConstant: 75),
            //            textFieldPicker.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func instructionTitleConstraint() {
        instructionTitleTopAnchorConstraint = instructionTitle.topAnchor.constraint(equalTo: ingredientTextField.bottomAnchor, constant: 40)
        
        NSLayoutConstraint.activate([
            instructionTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            instructionTitleTopAnchorConstraint,
            instructionTitle.widthAnchor.constraint(equalToConstant: 150),
            instructionTitle.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    func longTextConstraint() {
        NSLayoutConstraint.activate([
            longTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            longTextView.topAnchor.constraint(equalTo: instructionTitle.bottomAnchor, constant: 10),
            longTextView.widthAnchor.constraint(equalToConstant: 380),
            longTextView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func timeLabelConstraint() {
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10),
            timeLabel.topAnchor.constraint(equalTo: self.longTextView.bottomAnchor, constant: 5),
            timeLabel.widthAnchor.constraint(equalToConstant: 100),
            timeLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func timePickerConstraint() {
        NSLayoutConstraint.activate([
            timePicker.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10),
            timePicker.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 1),
            timePicker.widthAnchor.constraint(equalToConstant: 200),
            timePicker.heightAnchor.constraint(equalToConstant: 75),
        ])
    }
    
    func updateContainerView(newHeight: CGFloat) {
        containerHeight.isActive = false
        containerHeight = containerView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor,
                                                                multiplier: newHeight)
        containerHeight.isActive = true
        
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: containerView.frame.size.height)
    }
    
    @objc func addedStep() {
        print("addUp = \(addUp)")
        print("Indexing = \(indexing)")
        containerViewHeight += 0.1
        
        let newTextField = UITextField()
        newTextField.borderStyle = .roundedRect
        newTextField.placeholder = "Add ingredient #\(addUp + 1)"
        newTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let newPicker = UIPickerView()
        newPicker.delegate = self
        newPicker.dataSource = self
        newPicker.tag = addUp
        
        let newUITextPicker = UITextField()
        newUITextPicker.inputView = newPicker
        newUITextPicker.placeholder = "Select Unit #\(addUp + 1)"
        newUITextPicker.tag = addUp
        newUITextPicker.borderStyle = .roundedRect
        newUITextPicker.textAlignment = .center
        newUITextPicker.translatesAutoresizingMaskIntoConstraints = false
        
        let newQtyField = UITextField()
        newQtyField.placeholder = "Qty"
        newQtyField.borderStyle = .roundedRect
        newQtyField.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldArray.append(newTextField)
        newPickerArray.append(newUITextPicker)
        qtyTextField.append(newQtyField)
        self.containerView.addSubview(textFieldArray[indexing])
        self.containerView.addSubview(qtyTextField[indexing])
        self.containerView.addSubview(newPickerArray[indexing])
        
        let after1stPickerEntry = IngredientEntry(textField: newTextField, picker: newUITextPicker)
        pickersEntry.append(after1stPickerEntry)
        
        NSLayoutConstraint.activate([
            textFieldArray[indexing].leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            textFieldArray[indexing].widthAnchor.constraint(equalToConstant: 200),
            textFieldArray[indexing].heightAnchor.constraint(equalToConstant: 35),
            qtyTextField[indexing].leadingAnchor.constraint(equalTo: textFieldArray[indexing - 1].trailingAnchor, constant: 5),
            qtyTextField[indexing].widthAnchor.constraint(equalToConstant: 75),
            qtyTextField[indexing].heightAnchor.constraint(equalToConstant: 35),
            newPickerArray[indexing].leadingAnchor.constraint(equalTo: qtyTextField[indexing - 1].trailingAnchor, constant: 5),
            newPickerArray[indexing].widthAnchor.constraint(equalToConstant: 75),
            newPickerArray[indexing].heightAnchor.constraint(equalToConstant: 35)
            
        ])
        
        if textFieldArray.count > 2 {
            self.containerView.removeConstraint(instructionTitleTopAnchorConstraint)
            instructionTitleTopAnchorConstraint = instructionTitle.topAnchor.constraint(equalTo: textFieldArray[indexing].bottomAnchor, constant: 50)
            instructionTitleTopAnchorConstraint.isActive = true
            
            NSLayoutConstraint.activate([
                textFieldArray[indexing].topAnchor.constraint(equalTo: textFieldArray[indexing - 1].bottomAnchor, constant: 10),
                qtyTextField[indexing].topAnchor.constraint(equalTo: textFieldArray[indexing - 1].bottomAnchor, constant: 10),
                newPickerArray[indexing].topAnchor.constraint(equalTo: newPickerArray[indexing - 1].bottomAnchor, constant: 10),
            ])
        } else {
            NSLayoutConstraint.activate([
                textFieldArray[indexing].topAnchor.constraint(equalTo: ingredientTextField.bottomAnchor, constant: 10),
                qtyTextField[indexing].topAnchor.constraint(equalTo: quantityTextField.bottomAnchor, constant: 10),
                newPickerArray[indexing].topAnchor.constraint(equalTo: textFieldPicker.bottomAnchor, constant: 10)
            ])
        }
        
        updateContainerView(newHeight: containerViewHeight )
        
        self.view.updateConstraintsIfNeeded()
        
        addUp += 1
        indexing += 1
        print("Button Pressed")
    }
    
    @objc func saveRecipe() {
        print(selectedPicker)
        
        
        for index in 0..<textFieldArray.count {
            
            ingredList.append(IngredientModel(ingredients: textFieldArray[index].text ?? "",
                                              unit: IngredientModel.UnitOfMeasure(rawValue: textFieldPicker.text ?? "") ?? .cup,
                                              quantity: Int64(qtyTextField[index].text ?? "") ?? 0))
        }
        
        let recipe = RecipeModel(
            name: nameTextField.text ?? "",
            ingredient: ingredList,
            instructions: longTextView.text,
            timeHours: Int16(selectedHours),
            timeMinute: Int16(selectedMinutes),
            favorite: true)
        
        viewModel.saveRecipe(recipe)
        
        ingredList.removeAll()
    }
    
    
    //MARK: - UIPicker DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == timePicker.tag {
            return 2
        }else{
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == timePicker.tag {
            if component == 0 {
                return 24
            }else{
                return 60
            }
        }else{
            return unitsOfMeasure.count
        }
    }
    
    //MARK: - UIPicker delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == timePicker.tag {
            if component == 0 {
                return "\(row) hours"
            }else{
                return "\(row) mintues"
            }
        }else{
            return unitsOfMeasure[row].rawValue
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == timePicker.tag {
            selectedHours = pickerView.selectedRow(inComponent: 0)
            selectedMinutes = pickerView.selectedRow(inComponent: 1)
            
            print("SelectEd Time: \(String(describing: selectedHours)) hours \(String(describing: selectedMinutes)) minutes")
        }else{
            guard let index = pickersEntry.firstIndex(where: {$0.picker.tag == pickerView.tag}) else {
                print("Picker not found for tag: \(pickerView.tag)")
                //            print("Picker not found for tag: \()")
                return
            }
            if index != 0 {
                selectedPicker.append(unitsOfMeasure[row])
                newPickerArray[index].text = selectedPicker.last?.rawValue
                newPickerArray[index].resignFirstResponder()
            }else{
                selectedPicker.append(unitsOfMeasure[row])
                newPickerArray[0].text = selectedPicker[index].rawValue
                newPickerArray[0].resignFirstResponder()
                //
            }
        }
    }
    //MARK: - UIPickerView Text
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        }else{
            label = UILabel()
        }
        
        if pickerView.tag == timePicker.tag {
            var title = ""
            if component == 0 {
                title = "\(row) hours"
            }else{
                title = "\(row) minutes"
            }
            label.attributedText = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)])
            
        }else{
            label.text = unitsOfMeasure[row].rawValue
            label.font = UIFont.systemFont(ofSize: 28)
            label.textAlignment = .center
        }
        return label
    }
    
}
