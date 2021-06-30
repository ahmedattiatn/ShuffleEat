//
//  RestaurantCoordinator.swift
//  ShuffleEat
//
//  Created by Malek BARKAOUI on 14/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import Foundation
import UIKit

class RestaurantsCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    private let restaurants: [Restaurant]
    
    
    // MARK: - Coordinator
    
    private func showRestaurantsListViewController() {
        let restaurantsListVC = self.viewControllerFactory.instantiateRestaurantsListViewController()
        restaurantsListVC.finishRestaurantsList = { [unowned self] in
            self.finishFlow?()
        }
        
        restaurantsListVC.showSettings = { [unowned self] in
            self.showSettingsViewController()
        }
        restaurantsListVC.viewModel = RestaurantViewModel()
        restaurantsListVC.viewModel.restaurantArray = restaurants
        self.router.push(restaurantsListVC)
    }
    
    private func showSettingsViewController() {
        let coordinator = self.coordinatorFactory.makeSettingsCoordinatorBox(router: self.router, coordinatorFactory: self.coordinatorFactory, viewControllerFactory: self.viewControllerFactory)
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.router.popModule()
        }
        
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    
    override func start() {
        self.showRestaurantsListViewController()
    }
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory, restaurants: [Restaurant]) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
        self.restaurants = restaurants
    }
    
}
