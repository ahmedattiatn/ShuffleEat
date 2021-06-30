//
//  PreferenceChoiceViewController.swift
//  ShuffleEat
//
//  Created by Malek BARKAOUI on 25/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit
protocol PreferenceChoiceViewControllerProtocol: class {
    var choiceDone: (() -> Void)? { get set }
}

class PreferenceChoiceViewController: UIViewController, PreferenceChoiceViewControllerProtocol {
    var choiceDone: (() -> Void)?
    
    @IBOutlet weak var validateBtn: DCButton!
    @IBOutlet var collectionView: UICollectionView!
    lazy var viewModel = PreferenceViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.alpha = 0
        UIView.animate(withDuration: 1.2) {
            self.collectionView.alpha = 1
        }
        
        viewModel.setPreviousPreferencesChoice()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        validateBtn.setTitle(NSLocalizedString("btnValider",  comment: ""), for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func validateChoice(_ sender: Any) {
        print(viewModel.saveFavoritePreferencesChoiceIfNeeded())
        if viewModel.saveFavoritePreferencesChoiceIfNeeded() {
            UserDefaults.standard.set(true, forKey: "onboardingWasShown")
            self.choiceDone?()
        }
    }
}
