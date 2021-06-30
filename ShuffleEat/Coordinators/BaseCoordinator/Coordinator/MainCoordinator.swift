//
//  MainCoordinator.swift
//  ShuffleEat
//
//  Created by Malek BARKAOUI on 21/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//


final class MainCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    
    // MARK: - CoordinatorFinishOutput
    
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    
    // MARK: - Private methods
    
    private func showRandomRestaurantViewController() {
        let restaurantsVC = self.viewControllerFactory.instantiateRestaurantsViewController()
        restaurantsVC.showPreferenceChoice = { [unowned self] in
            self.showPreferenceChoiceViewController()
        }
        restaurantsVC.showSettings = { [unowned self] in
            self.showSettingsViewController()
            //self.showNotificationSettingsViewController()
        }
        
        restaurantsVC.showRestaurantsList = { [unowned self] restaurants in
            print("\n***********************************************\nlist restaurants from MainCoordinator \(restaurants)")
            self.showRestaurantsList(restaurants)
        }
        
        self.router.setRootModule(restaurantsVC, hideBar: true)
    }
    
    private func showRestaurantsList(_ restaurants:[Restaurant]) {
        let coordinator = self.coordinatorFactory.makeRestaurantsCoordinatorBox(router: self.router, coordinatorFactory: self.coordinatorFactory, viewControllerFactory: self.viewControllerFactory,restaurants: restaurants )
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.router.popModule()
        }
        
        self.addDependency(coordinator)
        coordinator.start()
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
    
    private func showPreferenceChoiceViewController() {
        let preferenceChoiceVC = self.viewControllerFactory.instantiatePreferenceChoiceViewController()
        preferenceChoiceVC.isModalInPresentation = true
        preferenceChoiceVC.choiceDone = { [unowned self] in
            self.router.popToRootModule(animated: false)
            self.router.dismissModule()
            self.showRandomRestaurantViewController()
        }
        
        self.router.present(preferenceChoiceVC)
    }
    
    
    
    //    private func showBViewController() {
    //        let bVC = self.viewControllerFactory.instantiateBViewController()
    //        bVC.onBack = { [unowned self] in
    //            self.router.popModule()
    //        }
    //        bVC.onLogout = { [unowned self] in
    //            self.finishFlow?()
    //        }
    //        self.router.push(bVC)
    //    }
    
    //    private func showProfile() {
    //        let coordinator = self.coordinatorFactory.makeProfileCoordinatorBox(router: self.router, coordinatorFactory: self.coordinatorFactory, viewControllerFactory: self.viewControllerFactory)
    //        coordinator.finishFlow = { [unowned self, unowned coordinator] in
    //            self.removeDependency(coordinator)
    //            self.router.popModule()
    //        }
    //        self.addDependency(coordinator)
    //        coordinator.start()
    //    }
    
    // MARK: - Coordinator
    
    override func start() {
        self.showRandomRestaurantViewController()
    }
    
    // MARK: - Init
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }
    
}
