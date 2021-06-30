//
//  LaunchInstructor.swift
//  ShuffleEat
//
//  Created by Malek BARKAOUI on 21/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.

import Foundation

fileprivate var onboardingWasShown = false
fileprivate var isAutorized = true

enum LaunchInstructor {
    
    case main
    case auth
    case onboarding
    
    // MARK: - Public methods
    
    static func configure( tutorialWasShown: Bool = onboardingWasShown, isAutorized: Bool = isAutorized) -> LaunchInstructor {
        let defaults = UserDefaults.standard

        let onBoardingShown =  defaults.bool(forKey: Constants.UserDefaults.onBoardingShown.rawValue)
        if onBoardingShown {
            return .main
        }
        
        switch (tutorialWasShown, isAutorized) {
        case (true, false), (false, false): return .auth
        case (false, true): return .onboarding
        case (true, true): return .main
        }
    }
}
