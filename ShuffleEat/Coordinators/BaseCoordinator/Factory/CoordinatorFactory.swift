//
//  CoordinatorFactory.swift
//  ShuffleEat
//
//  Created by Malek BARKAOUI on 21/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

protocol CoordinatorFactoryProtocol {

    func makeMainCoordinatorBox(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> MainCoordinator
    func makeOnBoardingCoordinatorBox (router: RouterProtocol, coordinatorFactory:CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> OnBoardingCoordinator?
     func makeSettingsCoordinatorBox (router: RouterProtocol, coordinatorFactory:CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> SettingsCoordinator
    func makeRestaurantsCoordinatorBox (router: RouterProtocol, coordinatorFactory:CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory,restaurants:[Restaurant]) -> RestaurantsCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    var onBoardingCoordinator:OnBoardingCoordinator?
     // MARK: - CoordinatorFactoryProtocol
    
    
    func makeRestaurantsCoordinatorBox(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory, restaurants:[Restaurant]) -> RestaurantsCoordinator {
        
        let restaurantsCoordinator = RestaurantsCoordinator(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory, restaurants: restaurants)
               
               return restaurantsCoordinator
           
       }
    
    func makeSettingsCoordinatorBox(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> SettingsCoordinator {
         let settingsCoordinator = SettingsCoordinator(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        
        return settingsCoordinator
    }
    
    
    func makeOnBoardingCoordinatorBox(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> OnBoardingCoordinator? {
         onBoardingCoordinator = OnBoardingCoordinator(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        
        return onBoardingCoordinator
    }
  
    func makeMainCoordinatorBox(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) -> MainCoordinator {
        let coordinator = MainCoordinator(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return coordinator
    }

    
}
