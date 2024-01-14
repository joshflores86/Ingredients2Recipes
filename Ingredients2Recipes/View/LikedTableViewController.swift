//
//  ViewController.swift
//  Ingredients2Recipes
//
//  Created by josh flores on 1/10/24.
//

import UIKit

class LikedTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView: UITableView = {
      let likedList = UITableView()
        likedList.register(<#T##nib: UINib?##UINib?#>, forCellReuseIdentifier: <#T##String#>)
        
       return likedList
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

}
