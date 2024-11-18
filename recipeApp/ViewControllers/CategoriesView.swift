//
//  CategoriesView.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 18/11/2024.
//

import UIKit
import SnapKit

protocol CategoriesViewProtocol: AnyObject {
    func setupUI()
    func setupCell()
}

class CategoriesView: UIViewController {
    
    var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension CategoriesView: CategoriesViewProtocol {
    func setupUI() {
        
    }
    
    func setupCell() {
        
    }
    
    
}
extension CategoriesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    
}
