//
//  CategoriesView.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 18/11/2024.
//

import UIKit
import SnapKit

protocol CategoriesViewProtocol: AnyObject {
    func showData(data:[String])
}

class CategoriesView: UIViewController, UITableViewDelegate {
    
    var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private var data: [String] = []
    
    var presenter = CategoriesPresenter?.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        tableView.frame = view.bounds
    }
}
extension CategoriesView: CategoriesViewProtocol {
        func showData(data: [String]) {
            self.data = data
            tableView.reloadData()
        }
        
        
        
    }
extension CategoriesView: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            cell.textLabel?.text = data[indexPath.row]
            return cell
        }
        
        
    }

