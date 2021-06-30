//
//  ViewController.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 05/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit
import Combine
import Cosmos

protocol RestaurantViewControllerProtocol: class {
    var showPreferenceChoice: (() -> Void)? { get set }
    var showSettings: (() -> Void)? { get set }
    var showRestaurantsList: ((_ restaurants:[Restaurant]) -> Void)? { get set }
}

class RestaurantViewController: UIViewController, Storyboarded, RestaurantViewControllerProtocol {
    var showRestaurantsList: (([Restaurant]) -> Void)?
    var showSettings: (() -> Void)?
    var showPreferenceChoice: (() -> Void)?
    
    @IBOutlet weak var startAnimationView: UIView!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var randomPlaceFoodView: UIView!
    @IBOutlet weak var nameResLabel: UILabel!
    @IBOutlet weak var distanceResLabel: UILabel!
    @IBOutlet weak var usersRatingResLabel: UILabel!
    @IBOutlet weak var addresseResLabel: UILabel!
    @IBOutlet weak var mapBtn: DCButton!
    @IBOutlet weak var containerRandomFoodView: UIView!
    @IBOutlet weak var goToListBtn: DCButton!
    @IBOutlet weak var ratingValue: CosmosView!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    private var cancellable: AnyCancellable?
    var viewModel = RestaurantViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        viewModel.delegate = self
        mapBtn.setTitle(NSLocalizedString("btnMap",  comment: ""), for: .normal)
        goToListBtn.setTitle(NSLocalizedString("btnGoToListe",  comment: ""), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showchoiceOrRestaurants()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.containerRandomFoodView.isHidden = true
        self.cancellable?.cancel()
    }
    
    @IBAction func btnmorePlaces(_ sender: Any) {
        self.showRestaurantsList?(viewModel.restaurantArray)
    }
    
    @IBAction func showOnTheMap(_ sender: Any) {
        if let  restaurant = viewModel.randomRestaurant {
            viewModel.openMapAndShow(restaurant)
        }
    }
    
    private func setupNavigationBar() {
        guard let font = UIFont(name: "Avenir Next Medium", size: 24) else { return  }
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white,
        ]
        self.title = NSLocalizedString("mainScreenTitle", comment: "")
        navigationController?.navigationBar.barTintColor = Colors.primaryColor
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        let settingsIcon = R.image.menu()?.withRenderingMode(.alwaysTemplate)
        
        let rightbaritem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector((RestaurantViewController.showSettings)))
        
        rightbaritem.image = settingsIcon
        rightbaritem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = rightbaritem
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
    }
    
    @objc func showSettings(sender: UIBarButtonItem) {
        self.showSettings?()
    }
    
    func showRandomRestaurantView() {
        if let  restaurant = viewModel.randomRestaurant {
            animateViewFlipFromBottom()
            nameResLabel.text = restaurant.name
            ratingValue.rating = restaurant.rating
            let distance = viewModel.distanceInMetersFrom(restaurant.location)
            distanceResLabel.text = (distance >= 1000) ? "\(String(format: "%.2f", distance/1000) ) km" : "\(Int(distance)) m"
            if let photoInfo = restaurant.photosInfo?.first, let stringUrl = viewModel.buildPhotoUrl(photoInfo) {
                restaurantImageView.setImage(with: URL(string: stringUrl),placeholder: R.image.defaultFood())
            }
            usersRatingResLabel.text = "(\(restaurant.usersRating ))"
            addresseResLabel.text =  restaurant.adresse
        }
        animateViewCurlDown()
    }
    
    private func animateViewFlipFromBottom() {
        UIView.transition(with: self.containerRandomFoodView,
                          duration: 0.5,
                          options: [.transitionFlipFromBottom],
                          animations: {
                            self.containerRandomFoodView.isHidden = false
        },
                          completion: nil)
    }
    
    private  func animateViewCurlDown() {
        UIView.transition(with: self.containerRandomFoodView,
                          duration: 0.5,
                          options: [.transitionCurlDown],
                          animations: {
                            self.containerRandomFoodView.isHidden = false
        },
                          completion: nil)
        
    }
    
    private func showchoiceOrRestaurants() {
        if UserDefaults.standard.bool(forKey: Constants.UserDefaults.onBoardingShown.rawValue) {
            if viewModel.restaurantArray.isEmpty {
                viewModel.getNearByRestaurants()
            }
            else  {
                showRandomRestaurantView()
            }
        }
        else {
            self.showPreferenceChoice?()
        }
    }
    
}


