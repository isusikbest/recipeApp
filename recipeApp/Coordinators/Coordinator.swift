//
//  Coordinator.swift
//  recipeApp
//
//  Created by Vladimir Liubarskiy on 09/01/2025.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
