//
//  OnBoardingCoordinator.swift
//  ShuffleEat
//
//  Created by Malek BARKAOUI on 24/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

final class OnBoardingCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    
    // MARK: - Coordinator
     
    private func showOnBoardingViewController() {
            let onBoarding = self.viewControllerFactory.instantiateOnBoardingViewController()
        onBoarding.finishOnBoarding = { [unowned self] in
            self.finishFlow?()
        }
    //        aVC.onGoToB = { [unowned self] in
    //            self.showBViewController()
    //        }
    //        aVC.onGoToProfile = { [unowned self] in
    //            self.showProfile()
    //        }
            self.router.setRootModule(onBoarding, hideBar: true)
        }
    
     override func start() {
         self.showOnBoardingViewController()
     }
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
           self.router = router
           self.coordinatorFactory = coordinatorFactory
           self.viewControllerFactory = viewControllerFactory
       }
    
}
