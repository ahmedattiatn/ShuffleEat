//
//  ViewController+UITableView.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 05/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit


extension RestaurantsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Constants.ConstCellID.restaurantsCell.rawValue  , for: indexPath)
        if  let cellRestaurant  = cell as? RestaurantsTableViewCell {
            let distance = viewModel.distanceInMetersFrom(viewModel.restaurantArray[indexPath.row].location)
            cellRestaurant.updateContent( viewModel.restaurantArray[indexPath.row],distance)
            return cellRestaurant
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.restaurantArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openMapAndShow(viewModel.restaurantArray[indexPath.row])
    }
}
