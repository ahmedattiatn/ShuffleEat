//
//  Restaurant.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 25/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit

protocol ToPresentable {
    func handleError(error: Error)
}

protocol RestaurantViewModelProtocol: ToPresentable {
    func restaurantListReturned()
    func showMapErrorAlert()
}
