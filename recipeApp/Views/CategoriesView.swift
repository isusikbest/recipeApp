//
//  CategoriesView.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 18/11/2024.
//

import UIKit
import SnapKit
import Then

protocol CategoriesViewProtocol: AnyObject {
    func showData(data: [Category])
}

class CategoriesView: UIViewController, UITableViewDelegate {
    
    private let tableView = UITableView().then {
      $0.backgroundColor = .clear
      $0.separatorStyle = .none
      $0.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
    }
    
    private var data: [Category] = []
    private let storage = FavoritesStorage.shared
    var presenter: CategoriesPresenter?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTableViewLayout()
        presenter?.loadCategories()
        view.backgroundColor = .white
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        tableView.reloadData()
//    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
    }
    
    func setupTableViewLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
}

extension CategoriesView: CategoriesViewProtocol {
    func showData(data: [Category]) {
        self.data = data
        tableView.reloadData()
    }
}

extension CategoriesView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = data[indexPath.row]
        let isFavorite = storage.isCategoryFavorite(category.idCategory)
        print("Category: \(category.strCategory), isFavorite: \(isFavorite)")
        cell.configure(with: category.strCategory, isFavorite: isFavorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = data[indexPath.row]
        presenter?.showDishes(for: selectedCategory)
    }
}
extension CategoriesView: CategoryViewDelegate {
    func didUpdateFavorites(for categoryId: String) {
        print("Delegate called for category ID: \(categoryId)")
        let updatedFavorites = FavoritesStorage.shared.isCategoryFavorite(categoryId)
                print("Updated favorites for category ID: \(categoryId) -> \(updatedFavorites)")
        tableView.reloadData()
    }
}

