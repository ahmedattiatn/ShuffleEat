//
//  PreferenceChoiceCollectionViewCell.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 27/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit

class PreferenceChoiceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var backgroundCard: UIImageView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var favoriteIcon: UIImageView!

    func updateCell(_ preference :Preference, isSelected:Bool) {
        name.text = preference.name
        backgroundCard.image = preference.cardImage
        icon.image = preference.image
        if let iconFav = UIImage(systemName: "heart"), let icon = UIImage(systemName: "heart.fill")  {
                 favoriteIcon.image = isSelected ? icon : iconFav
             }


    }
    
    func updatefavoriteIcon() {
        if let iconFav = UIImage(systemName: "heart.fill"), let icon = UIImage(systemName: "heart")  {
            favoriteIcon.image = (favoriteIcon.image == iconFav) ? icon : iconFav
        }
        
    }
    
    // MARK: - Animation
    func animateView() {
        let animatedAlpha: CGFloat  = 0.3
        let animatedXorY: CGFloat  = 25
        name.alpha = animatedAlpha
        name.center.y -= animatedXorY
        
        icon.alpha = animatedAlpha
        icon.center.y -= animatedXorY
        
        favoriteIcon.alpha = animatedAlpha
        UIView.animate(withDuration: 1) {
            self.name.center.y += animatedXorY
            self.icon.center.y += animatedXorY
            
            self.name.alpha = 1
            self.icon.alpha = 1
            self.favoriteIcon.alpha = 1
        }
    }
    
}
