//
//  OnBoardingViewController.swift
//  ShuffleEat
//
//  Created by Malek BARKAOUI on 24/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit
import paper_onboarding


protocol OnBoardingViewControllerProtocol: class {
    var finishOnBoarding: (() -> Void)? { get set }
}

class OnBoardingViewController: UIViewController , OnBoardingViewControllerProtocol {
    var finishOnBoarding: (() -> Void)?
    
    
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var onBoardingView: OnBoardingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        self.onBoardingView.dataSource = self
        self.onBoardingView.delegate = self
        self.setupUI()
    }
    
    func setupUI() {
        getStartedButton.layer.cornerRadius = 20
        getStartedButton.layer.borderWidth =  2
        getStartedButton.layer.borderColor =  UIColor.white.cgColor
    }
    
    @IBAction func finishOnBoarding(_ sender: Any) {
        self.finishOnBoarding?()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension OnBoardingViewController: PaperOnboardingDelegate {
    
    func onboardingWillTransitonToIndex( _ index :Int) {
        if index == 1 {
            UIView.animate(withDuration: 0.4, animations: {
                self.getStartedButton.alpha = 0
            })
        }
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2 {
            UIView.animate(withDuration: 0.4, animations: {
                self.getStartedButton.alpha = 1
            })
        }
    }
}

extension OnBoardingViewController: PaperOnboardingDataSource {
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let backgroundColorOne = UIColor(red: 217/255, green: 73/255, blue: 89/255, alpha: 1)
        let backgroundColorTwo = UIColor(red: 106/255, green: 166/255, blue: 211/255, alpha: 1)
        let backgroundColorThree = UIColor(red: 168/255, green: 200/255, blue: 78/255, alpha: 1)
        
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let descriptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        
        return [OnboardingItemInfo(informationImage: UIImage(named: "restauPref")!,
                                   title: "Préfèrences",
                                   description: "Choisissez vos préfèrences gastronomiques vos types de cuisines",
                                   pageIcon: UIImage(),
                                   color: backgroundColorOne,
                                   titleColor: UIColor.white,
                                   descriptionColor: UIColor.white,
                                   titleFont: titleFont,
                                   descriptionFont: descriptionFont,
                                   descriptionLabelPadding: 20.0),OnboardingItemInfo(informationImage: UIImage(named: "suggestion")!,
                                                                                     title: "Suggestion d'un restaurant",
                                                                                     description: "Puis un restaurant parmi plusieurs sera choisi et tu seras notifié à une heure précise",
                                                                                     pageIcon: UIImage(),
                                                                                     color: backgroundColorTwo,
                                                                                     titleColor: UIColor.white,
                                                                                     descriptionColor: UIColor.white,
                                                                                     titleFont: titleFont,
                                                                                     descriptionFont: descriptionFont,descriptionLabelPadding: 20.0),
                                                                  OnboardingItemInfo(informationImage: UIImage(named: "ListRestau")!,
                                                                                     title: "Suggestion des restaurants",
                                                                                     description: "Sinon , vous pouvez consultez un large liste des restaurants à tout moment et choisir ton restaurant du jour",
                                                                                     pageIcon: UIImage(),
                                                                                     color: backgroundColorThree,
                                                                                     titleColor: UIColor.white,
                                                                                     descriptionColor: UIColor.white,
                                                                                     titleFont: titleFont,
                                                                                     descriptionFont: descriptionFont,descriptionLabelPadding: 20.0)][index]
    }
}
