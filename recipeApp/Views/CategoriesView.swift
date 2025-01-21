//
//  CategoriesView.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 18/11/2024.
//

import UIKit
import SnapKit
import Then
import Combine

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
    private var storage: FavoritesStorage = FavoritesStorage()
    var presenter: CategoriesPresenter?
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTableViewLayout()
        presenter?.loadCategories()
        view.backgroundColor = .white
        presenter?.favoritsUpdate
            .sink { [weak self] updateCategoryId in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
        
    }

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
        cell.configure(with: category.strCategory, isFavorite: storage.isCategoryFavorite(category.idCategory))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = data[indexPath.row]
        presenter?.showCategories(for: selectedCategory)
    }
}
    

