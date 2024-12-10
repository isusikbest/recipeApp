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
    func showDishes(dishes: [Dish])
}

class CategoryView: UIViewController, UICollectionViewDelegateFlowLayout {
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 10
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
        $0.register(DishesByCategoryCell.self, forCellWithReuseIdentifier: "DishesByCategoryCell")
    }
    private var dishes: [Dish] = []
    
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
    func showDishes(dishes: [Dish]) {
        self.dishes = dishes
        collectionView.reloadData()
    }
}

extension CategoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishesByCategoryCell", for: indexPath) as? DishesByCategoryCell else {  fatalError("Failed to dequeue DishesByCategoryCell")
        }
        cell.configure(with: dishes[indexPath.row])
        cell.backgroundColor = .white
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let numberOfColumns: CGFloat = 3
           let totalWidth = collectionView.bounds.width
           let spacing: CGFloat = 30
           let calculatedWidth = (totalWidth - (numberOfColumns - 1) * spacing) / numberOfColumns
        return CGSize(width: calculatedWidth, height: calculatedWidth)
    }
}
