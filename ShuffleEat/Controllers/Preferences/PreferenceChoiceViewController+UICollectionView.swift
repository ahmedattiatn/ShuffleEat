//
//  RestaurantsViewController+UICollectionView.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 27/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit

extension PreferenceChoiceViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //UICollectionViewDelegateFlowLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //UICollectionViewDatasource methods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.preferenceFoodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ConstCellID.preferenceCell.rawValue, for: indexPath as IndexPath)
        if  let preferenceCell  = cell as? PreferenceChoiceCollectionViewCell {
            
            if let getPreferencesFavorite:[String] = UserDefaults.standard.array(forKey: Constants.UserDefaults.favoritePreferences.rawValue) as? [String]
                                                       {
               
                                                           preferenceCell.updateCell(viewModel.preferenceFoodList[indexPath.row], isSelected: getPreferencesFavorite.contains(viewModel.preferenceFoodList[indexPath.row].name))
               
                                                  } else {
                preferenceCell.updateCell(viewModel.preferenceFoodList[indexPath.row], isSelected: false)

            }
            return preferenceCell
        }
        return cell
        
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PreferenceChoiceCollectionViewCell, let name = cell.name.text {
            viewModel.updateFavoritePreferencesArray(name)
            cell.updatefavoriteIcon()
        }
    }
    
    // ScrollView methods
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        for cell: UICollectionViewCell in collectionView.visibleCells {
            if  let preferenceCell = cell as? PreferenceChoiceCollectionViewCell {
                preferenceCell.animateView()
            }
        }
    }
    
    /*func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
     if  let preferenceCell = cell as? PreferenceChoiceCollectionViewCell {
     preferenceCell.animateView()
     }
     }*/
    
    /* func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
     {
     return CGSize(width: 100.0, height: 100.0)
     }*/
}
