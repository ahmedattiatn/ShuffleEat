//
//  RestaurantsListViewController.swift
//  ShuffleEat
//
//  Created by Malek BARKAOUI on 08/09/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit

protocol RestaurantsListProtocol: class {
    var finishRestaurantsList: (() -> Void)? { get set }
    var showSettings: (() -> Void)? { get set }
}


class RestaurantsListViewController: UIViewController, RestaurantsListProtocol {
    
    let refreshControl = UIRefreshControl()
    
    var finishRestaurantsList: (() -> Void)?
    var showSettings: (() -> Void)?
    
    var viewModel = RestaurantViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noRestaurantLabel: UILabel!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var noRestoLabel: UILabel!
    @IBOutlet weak var shuffleBtn: DCButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        noRestoLabel.text = NSLocalizedString("LabelNoResto", comment: "")
        // Do any additional setup after loading the view.
    }
    
    func initView() {
        self.viewModel.delegate = self
        self.tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.ConstCellID.RestaurantsListTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier:Constants.ConstCellID.restaurantsCell.rawValue)
        tableView.separatorColor = UIColor.clear
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshRestaurantListData(_:)), for: .valueChanged)
        
        self.setupNavigationBar()
    }
    
    @objc private func refreshRestaurantListData(_ sender: Any) {
        viewModel.getNearByRestaurants()
    }
    
    func setupNavigationBar() {
        guard let font = UIFont(name: "Avenir Next Medium", size: 24) else { return  }
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white,
        ]
        let choice = UserDefaults.standard.string(forKey: Constants.UserDefaults.favoritePreferenceOfTheDay.rawValue)
        self.title = "\(choice ?? "Restaurants")"
        
        navigationController?.navigationBar.barTintColor = Colors.primaryColor
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        
        let buttonIcon = UIImage(named: "left_side")?.withRenderingMode(.alwaysTemplate)
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(RestaurantsListViewController.back))
        newBackButton.image = buttonIcon
        newBackButton.tintColor = UIColor.white
        
        let settingsIcon = R.image.menu()?.withRenderingMode(.alwaysTemplate)
        
        let rightbaritem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector((RestaurantsListViewController.showSettings)))
        
        rightbaritem.image = settingsIcon
        rightbaritem.tintColor = UIColor.white
        
        self.navigationItem.rightBarButtonItem = rightbaritem
        
        self.navigationItem.leftBarButtonItem = newBackButton
        
    }
    
    func hideOrShowNoRestaurantLabel() {
        if viewModel.restaurantArray.count == 0 {
            noRestaurantLabel.isHidden = false
        }
        else {
            noRestaurantLabel.isHidden = true
        }
    }
    
    
    @objc func showSettings(sender: UIBarButtonItem) {
        self.showSettings?()
    }
    
    @objc func back(sender: UIBarButtonItem) {
        self.finishRestaurantsList?()
    }
    
}

