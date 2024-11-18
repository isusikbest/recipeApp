//
//  CategoriesView.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 18/11/2024.
//

import UIKit
import SnapKit

protocol CategoriesViewProtocol: AnyObject {
    func showData(data:[String]) ->[String]
}

class CategoriesView: UIViewController, UITableViewDelegate {
    
    var tableView: UITableView = {
        let table = UITableView()
       
        return table
    }()
    
   
    var presenter = CategoriesPresenter.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension CategoriesView: CategoriesViewProtocol {
    func showData(data: [String]) ->[String] {
        <#code#>
    }
    
    func showData() {
        
    }
}
extension CategoriesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    }
    
    
}
