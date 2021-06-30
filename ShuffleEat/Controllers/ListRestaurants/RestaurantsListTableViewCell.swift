//
//  PlaceTableViewCell.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 05/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit
import MapleBacon
import Cosmos

class RestaurantsListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var adresseLabel: UILabel!
    @IBOutlet weak var usersRatingLabel: UILabel!
    @IBOutlet weak var mainphoto: ImageCardView!
    @IBOutlet weak var ratingValue: CosmosView!
    
    
    lazy  var viewModel = RestaurantViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateContent(_ restaurant: Restaurant, _ distance : Double) {
        nameLabel.text = restaurant.name
        ratingValue.rating = restaurant.rating
        usersRatingLabel.text = "(\(restaurant.usersRating ))"
        adresseLabel.text = restaurant.adresse
        distanceLabel.text = (distance >= 1000) ? "\(String(format: "%.2f", distance/1000) ) km" : "\(Int(distance)) m"
        if let photoInfo = restaurant.photosInfo?.first, let stringUrl = viewModel.buildPhotoUrl(photoInfo) {
            mainphoto.setImage(with: URL(string: stringUrl),placeholder: R.image.defaultFood())
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
