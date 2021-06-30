//
//  RestaurantsViewController+VMProtocol.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 27/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit

extension RestaurantViewController : RestaurantViewModelProtocol {
    
    func showMapErrorAlert() {
        let alert = UIAlertController(title: NSLocalizedString("mapErrorTitle", comment: ""), message: NSLocalizedString("mapError", comment: ""), preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated:true, completion: nil)
    }
    
    func handleError(error: Error) {
        switch error {
        case ResponseError.noInternet:
            print("probleme de connexion")
        default:
            print("unknow problem")
        }
    }
    
    func restaurantListReturned() {
        blurView.isHidden = true
        self.loaderIndicator.stopAnimating()
        self.showRandomRestaurantView()
    }
}

