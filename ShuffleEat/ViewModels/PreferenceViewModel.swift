//
//  PreferenceViewModel.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 01/09/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit


class PreferenceViewModel {
    
    // MARK: - Proprities
    var delegate : PreferenceViewModelProtocol? = nil
    var preferenceFoodList: [Preference] = []
    private var foodfavoritePref : [String] = []
    var favoritePreferences = Constants.UserDefaults.favoritePreferences.rawValue
    
    // MARK: - Init
    init() {
        // We are calling the VM from RestaurantAPI and we d'ont need to call the getPreferenceFoodList()
        if preferenceFoodList.isEmpty {
            self.preferenceFoodList =  getPreferenceFoodList()
        }
    }
    
    // MARK: - Private methods
    private func getPreferenceFoodList() -> [Preference] {
        preferenceFoodList.append(Preference(name: "Burger", image: R.image.burger(), cardImage: R.image.brown()))
        preferenceFoodList.append(Preference(name: "Italian", image: R.image.pizza(), cardImage: R.image.greyCard()))
        preferenceFoodList.append(Preference(name: "Japonais", image: R.image.asian(), cardImage: R.image.pinkCard()))
        preferenceFoodList.append(Preference(name: "Kabab", image: R.image.kabab(), cardImage: R.image.bleuCard()))
        preferenceFoodList.append(Preference(name: "Libanais", image: R.image.lebanese(), cardImage: R.image.greenCard()))
        preferenceFoodList.append(Preference(name: "Brasseries", image: R.image.salade(), cardImage: R.image.greyCard()))
        preferenceFoodList.append(Preference(name: "Indien", image: R.image.indian(), cardImage: R.image.purpleCard()))
        preferenceFoodList.append(Preference(name: "Thai", image: R.image.marocain(), cardImage: R.image.tealCard())) // Brasserie or Marocain
        return preferenceFoodList
    }
    
    func saveFavoritePreferencesChoiceIfNeeded() -> Bool  {
        print("Food Favorite Preferences Choice : ",foodfavoritePref)
        let minchoice = foodfavoritePref.count >= 2
        if  minchoice {
            UserDefaults.standard.set(foodfavoritePref, forKey: favoritePreferences)
        }
        else {
            self.delegate?.showMinimumFavoritePreferenceAlert()
        }
        return minchoice
    }
    
    
    
    func setPreviousPreferencesChoice() {
        if let getPreferencesFavorite: [String] = UserDefaults.standard.array(forKey: favoritePreferences) as? [String] {
            foodfavoritePref.removeAll()
            for pref in getPreferencesFavorite {
                foodfavoritePref.append(pref)
            }
        }
    }
    
    func updateFavoritePreferencesArray(_ prefName:String) {
        if foodfavoritePref.contains(prefName),let index = foodfavoritePref.firstIndex(of: prefName) {
            foodfavoritePref.remove(at: index)
        }
        else {
            foodfavoritePref.append(prefName)
        }
    }
    
    func getFavoritePreferences()-> String {
        let standard = UserDefaults.standard
        var preferenceFavorite : String = "pizza"
        if let getPreferencesFavorite = standard.array(forKey: favoritePreferences),let pref = getPreferencesFavorite.randomElement() as? String {
            standard.set(pref, forKey: Constants.UserDefaults.favoritePreferenceOfTheDay.rawValue)
            print("User Favorite Preference ToDay is :", pref)
            preferenceFavorite = pref
        }
        return preferenceFavorite
    }
    
}
