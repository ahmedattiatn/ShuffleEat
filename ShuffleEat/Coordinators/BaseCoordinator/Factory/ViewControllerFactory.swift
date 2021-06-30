//
//  ViewControllerFactory.swift
//  ShuffleEat
//
//  Created by Malek BARKAOUI on 21/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit

class ViewControllerFactory {
    // MARK: - Main StoryBoard ViewControllers
    func instantiateRestaurantsViewController() -> RestaurantViewController {
        let restaurantVC = UIStoryboard.main.instantiateViewController(withIdentifier: "RestaurantsViewController") as! RestaurantViewController
        restaurantVC.viewModel = RestaurantViewModel()
        return restaurantVC
    }
    
    func instantiateRestaurantsListViewController() -> RestaurantsListViewController {
        let restaurantsListVC = UIStoryboard.main.instantiateViewController(withIdentifier: "RestaurantsListViewController") as! RestaurantsListViewController
        restaurantsListVC.viewModel = RestaurantViewModel()
        return restaurantsListVC
    }
    
    func instantiateSettingsViewController() -> GeneralSettingsViewController {
        let settingsVC = UIStoryboard.main.instantiateViewController(withIdentifier: "SettingsViewController") as! GeneralSettingsViewController
        settingsVC.viewModel = SettingsViewModel()
        return settingsVC
    }
    
    
    func instantiatePreferenceChoiceViewController() -> PreferenceChoiceViewController {
        let preferenceChoiceVC = UIStoryboard.main.instantiateViewController(withIdentifier: "PreferenceChoiceViewController") as! PreferenceChoiceViewController
        return preferenceChoiceVC
    }
    
    
    // MARK: - OnBoarding StoryBoard ViewControllers
    
    func instantiateOnBoardingViewController() -> OnBoardingViewController {
        let onboardingVC = UIStoryboard.onBoarding.instantiateViewController(withIdentifier: "OnBoardingViewController") as! OnBoardingViewController
        return onboardingVC
    }
    
}
