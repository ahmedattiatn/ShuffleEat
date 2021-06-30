//
//  SettingsCoordinator.swift
//  ShuffleEat
//
//  Created by Malek BARKAOUI on 27/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

final class SettingsCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    
    // MARK: - Coordinator
    
    private func showSettingsViewController() {
        let settingsVC = self.viewControllerFactory.instantiateSettingsViewController()
        settingsVC.finishSettings = { [unowned self] in
            self.finishFlow?()
        }
        
        settingsVC.showPreferences = { [unowned self] in
            self.showPreferencesViewController()
        }
        
        //        aVC.onGoToB = { [unowned self] in
        //            self.showBViewController()
        //        }
        //        aVC.onGoToProfile = { [unowned self] in
        //            self.showProfile()
        //        }
        self.router.push(settingsVC)
    }
    
    private func showPreferencesViewController() {
        let preferenceChoiceVC = self.viewControllerFactory.instantiatePreferenceChoiceViewController()
        preferenceChoiceVC.isModalInPresentation = true
        preferenceChoiceVC.choiceDone = { [unowned self] in
            self.router.refreshRootController()
            self.router.dismissModule(animated: true, completion: nil)
        }
        
        self.router.present(preferenceChoiceVC)
    }
    
    override func start() {
        self.showSettingsViewController()
    }
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }
    
}
