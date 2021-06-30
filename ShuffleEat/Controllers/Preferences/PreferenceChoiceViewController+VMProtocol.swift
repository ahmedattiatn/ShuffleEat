//
//  PreferenceChoice+VMProtocol.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 03/09/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit

extension PreferenceChoiceViewController: PreferenceViewModelProtocol {
    func showMinimumFavoritePreferenceAlert() {
        let alert = UIAlertController(title: NSLocalizedString("prefErrorTitle", comment: ""), message: NSLocalizedString("prefError", comment: ""), preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated:true, completion: nil)
    }
    
    
}
