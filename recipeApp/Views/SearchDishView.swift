//
//  SearchDishView.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 13/01/2025.
//

import UIKit
import Combine
import SnapKit
import Then

class SearchDishView: UIViewController {
    
    var delegate: DishPresenterDelegate?
    private let viewModel: SearchDishViewModel
    private var cancellables = Set<AnyCancellable>()
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let placeHolderLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 17)
        $0.isHidden = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let placeHolderImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.tintColor = .gray
        $0.isHidden = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    init(viewModel: SearchDishViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.titleView = searchBar
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView)
        view.addSubview(placeHolderLabel)
        view.addSubview(placeHolderImage)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        placeHolderLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        placeHolderImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(placeHolderLabel.snp.top).offset(-10)
            make.width.height.equalTo(20)
        }
    }
    
    private func setupBindings() {
        searchBar.searchTextField.textPublisher
            .assign(to: \.searchText, on: viewModel)
            .store(in: &cancellables)
        
        viewModel.$filteredItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.updatePlaceHolderLabel(with: message)
            }
            .store(in: &cancellables)
        viewModel.$shouldShowPlaceholderImage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shouldShow in
                self?.placeHolderImage.isHidden = !shouldShow
            }
            .store(in: &cancellables)
    }
    
    func updatePlaceHolderLabel(with message: String?) {
        if let message = message {
            placeHolderLabel.isHidden = false
            placeHolderLabel.text = message
            placeHolderImage.isHidden = (message != "No found results")
        } else {
            placeHolderLabel.isHidden = true
            placeHolderImage.isHidden = true
        }
    }
    
}

extension SearchDishView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let dish = viewModel.filteredItems[indexPath.row]
        cell.textLabel?.text = dish.strMeal
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = delegate else { return }
        let selectedDish = viewModel.filteredItems[indexPath.row]
        viewModel.showDetail(by: selectedDish.idMeal, delegate: delegate)
    }
}

extension UISearchTextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
}
