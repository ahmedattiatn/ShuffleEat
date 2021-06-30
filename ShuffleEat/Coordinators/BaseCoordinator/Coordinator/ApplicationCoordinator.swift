//
//  ApplicationCoordinator.swift
//  ShuffleEat
//
//  Created by Malek BARKAOUI on 21/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//


import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    
    // MARK: - Vars & Lets
    
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let router: RouterProtocol
    private var launchInstructor = LaunchInstructor.configure()
    private let viewControllerFactory: ViewControllerFactory = ViewControllerFactory()
    
    // MARK: - Coordinator
    
    override func start(with option: DeepLinkOption?) {
        if option != nil {
            
        } else {
            
            switch launchInstructor {
            case .onboarding: runOnboardingFlow()
            case .auth: runAFlow()
            case .main: runMainFlow()
            }
        }
    }
    
    // MARK: - Private methods
    
    private func runAFlow() {
//        let coordinator = self.coordinatorFactory.makeAuthCoordinatorBox(router: self.router, coordinatorFactory: self.coordinatorFactory, viewControllerFactory: self.viewControllerFactory)
//        coordinator.finishFlow = { [unowned self, unowned coordinator] in
//            self.removeDependency(coordinator)
//            self.launchInstructor = LaunchInstructor.configure(tutorialWasShown: false, isAutorized: true)
//            self.start()
//        }
//        self.addDependency(coordinator)
//        coordinator.start()
    }
    
    private func runOnboardingFlow() {
        let coordinator = self.coordinatorFactory.makeOnBoardingCoordinatorBox(router: self.router, coordinatorFactory: CoordinatorFactory(), viewControllerFactory: ViewControllerFactory())
        coordinator?.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.launchInstructor = LaunchInstructor.configure(tutorialWasShown: true, isAutorized: true)
            self.start()
        }
        self.addDependency(coordinator!)
        coordinator?.start()
    }
    
    private func runMainFlow() {
        let coordinator = self.coordinatorFactory.makeMainCoordinatorBox(router: self.router, coordinatorFactory: CoordinatorFactory(), viewControllerFactory: ViewControllerFactory())
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.launchInstructor = LaunchInstructor.configure(tutorialWasShown: false, isAutorized: false)
            self.start()
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    // MARK: - Init
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
}
