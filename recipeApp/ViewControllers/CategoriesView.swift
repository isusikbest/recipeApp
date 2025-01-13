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
    func showData(data: [String])
}

class CategoriesView: UIViewController, UITableViewDelegate {
    
    private let tableView = UITableView().then {
      $0.backgroundColor = .clear
      $0.separatorStyle = .none
      $0.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
    }
    
    private var data: [String] = []
    
    var presenter: CategoriesPresenter?
    weak var coordinator: RecipeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTableViewLayout()
        presenter?.loadCategories()
        view.backgroundColor = .white
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupTableViewLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
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
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1.5
            return cell
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = data[indexPath.row]
        coordinator?.showDishesBySelectedCategory(for: selectedCategory)
//        let factory = ScreensFactory()
//        let dishesPageVC = factory.createDishesPage(for: selectedCategory)
//        navigationController?.pushViewController(dishesPageVC, animated: true)
//        dishesPageVC.title = selectedCategory
    }
        
    }
