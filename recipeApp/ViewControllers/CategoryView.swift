//
//  CategoryView.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 27/11/2024.
//

import UIKit
import SnapKit
import Then


protocol CategoryViewProtocol: AnyObject {
    func showDishes(dishes: [String])
}

class CategoryView: UIViewController, UICollectionViewDelegateFlowLayout {
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
        $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Dish")
    }
    private var dishes: [String] = []
    
    var presenter: CategoryPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupCollectionViewLayout()
        presenter?.loadDishes()
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func setupCollectionViewLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension CategoryView: CategoryViewProtocol {
    func showDishes(dishes: [String]) {
        self.dishes = dishes
        collectionView.reloadData()
    }
}

extension CategoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Dish", for: indexPath)
        cell.backgroundColor = .gray
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
}
