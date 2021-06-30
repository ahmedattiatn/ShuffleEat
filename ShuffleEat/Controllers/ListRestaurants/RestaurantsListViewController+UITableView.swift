//
//  RestaurantsListViewController+UITableView.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 09/09/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit


extension RestaurantsListViewController:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Constants.ConstCellID.restaurantsCell.rawValue  , for: indexPath)
        if viewModel.restaurantArray.count != 0 {
            if  let cellRestaurant  = cell as? RestaurantsListTableViewCell {
                
                let distance = viewModel.distanceInMetersFrom(viewModel.restaurantArray[indexPath.row].location)
                cellRestaurant.updateContent( viewModel.restaurantArray[indexPath.row],distance)
                return cellRestaurant
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 30, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.50) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        hideOrShowNoRestaurantLabel()
        return viewModel.restaurantArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.dimensions.tableViewCellHeight.rawValue
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openMapAndShow(viewModel.restaurantArray[indexPath.row])
    }
    
}


