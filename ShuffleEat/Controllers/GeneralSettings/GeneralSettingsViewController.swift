//
//  SettingsViewController.swift
//  ShuffleEat
//
//  Created by Malek BARKAOUI on 27/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit
import Combine
import TagListView

protocol GeneralSettingsProtocol: class {
    var finishSettings: (() -> Void)? { get set }
    var changeNotifTime: (() -> Void)? { get set }
    var showPreferences: (() -> Void)? { get set }
}



class GeneralSettingsViewController: UIViewController, GeneralSettingsProtocol, TagListViewDelegate {
    
    var changeNotifTime: (() -> Void)?
    var finishSettings: (() -> Void)?
    var showPreferences: (() -> Void)?
    
    @IBOutlet weak var datePickerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var gastronimicCriteriaLabel: UILabel!
    @IBOutlet weak var settingsFormTitle: UILabel!
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var activateNotifSwitch: UISwitch!
    @IBOutlet weak var notificationHourView: UIView!
    @IBOutlet weak var timeNotifLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet weak var timeNotifIndicationLabel: UILabel!
    @IBOutlet weak var criteriaSearchLabel: UILabel!
    @IBOutlet weak var criteriaGastroLabel: UILabel!
    @IBOutlet weak var updateBtn: UIButton!
    
    var datePickedHidden = true
    var viewModel:SettingsViewModel = SettingsViewModel()
    
    
    
    @IBOutlet weak var tagListView: TagListView! {
        didSet {
            tagListView.textFont = UIFont.systemFont(ofSize: 15)
            tagListView.delegate = self
        }
    }
    @IBOutlet weak var notifcationSwitch: UISwitch! {
        didSet {
            notifcationSwitch.onTintColor = Colors.primaryColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        datePicker.setValue(UIColor.white, forKey: "textColor")
        criteriaSearchLabel.text = NSLocalizedString("labelCritere", comment: "")
        criteriaGastroLabel.text = NSLocalizedString("labelGastro", comment: "")
        timeNotifIndicationLabel.text = NSLocalizedString("notifTime", comment: "")
        updateBtn.setTitle(NSLocalizedString("labelUpdate", comment: ""), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        
        if let timeNotif =  UserDefaults.standard.string(forKey: Constants.UserDefaults.timeNotif.rawValue) {
            self.timeNotifLabel.text = timeNotif
        } else {
            self.timeNotifLabel.text = "-:-"
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(returnToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        self.setupDatePicker()
        self.setupNavigationBar()
        self.notificationHourView.isHidden = !UserDefaults.standard.bool(forKey: Constants.UserDefaults.notificationActivated.rawValue)
        self.datePickerView.isHidden = true
        self.activateNotifSwitch.setOn(UserDefaults.standard.bool(forKey: Constants.UserDefaults.notificationActivated.rawValue), animated: false)
        activateNotifSwitch.addTarget(self, action: #selector
            (GeneralSettingsViewController.switchChanged), for: UIControl.Event.valueChanged)
    }
    
    
    
    @objc func returnToForeground() {
        let userNotification = UNUserNotificationCenter.current()
        userNotification.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            DispatchQueue.main.async {
                if granted && self.activateNotifSwitch.isOn {
                    
                    self.notificationHourView.isHidden = false
                    
                } else {
                    
                    self.activateNotifSwitch.setOn(false, animated: false)
                    self.notificationHourView.isHidden = true
                    
                }
            }
        }
    }
    
    func setupDatePicker() {
        self.datePicker.addTarget(self, action: #selector(GeneralSettingsViewController.datePickerChangeValue), for: .valueChanged)
    }
    
    @objc func datePickerChangeValue(datePicker: UIDatePicker) {
        
        let date = datePicker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = components.hour!
        let minute = components.minute!
        let completeTime = "\(hour):\(minute)"
        UserDefaults.standard.set(completeTime, forKey: Constants.UserDefaults.timeNotif.rawValue)
        self.timeNotifLabel.text = completeTime
    }
    
    func checkAuthorizationFor(_ userNotification:UNUserNotificationCenter)  {
        userNotification.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                var value = false
                print("Notifications is granted!")
                DispatchQueue.main.async {
                    value = self.activateNotifSwitch.isOn
                }
                
                UIView.animate(withDuration: 0.4, animations: {
                    
                    if value {
                        UserDefaults.standard.set(true, forKey: Constants.UserDefaults.notificationActivated.rawValue)
                        DispatchQueue.main.async {
                            self.notificationHourView.isHidden = false
                            
                        }
                    } else {
                        UserDefaults.standard.set(false, forKey: Constants.UserDefaults.notificationActivated.rawValue)
                        DispatchQueue.main.async {
                            self.viewModel.cancelNotification(notificationID: "reminder")
                            // self.timeNotifLabel.textColor = Colors.secondaryTextColor
                            self.datePickerView.isHidden = true
                            self.notificationHourView.isHidden = true
                        }
                    }
                    
                })
            } else {
                print("Notifications is not granted So please update your settings!")
                
                self.notificationAuthorization()
                
            }
            
        }
    }
    
    @objc func switchChanged(mySwitch: UISwitch) {
        datePickedHidden = !datePickedHidden
        
        let userNotification = UNUserNotificationCenter.current()
        checkAuthorizationFor(userNotification)
        
    }
    
    @objc func back(sender: UIBarButtonItem) {
        self.finishSettings?()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUIandNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func changePreferences(_ sender: Any) {
        self.showPreferences?()
    }
    
    @IBAction func changeNotiTime(_ sender: Any) {
        //self.changeNotifTime?()
        datePickedHidden = !datePickedHidden
        if datePickedHidden {
            viewModel.triggeNotificationAt(date: datePicker.date)
        }
        self.timeNotifLabel.textColor = datePickedHidden ? UIColor.white : UIColor.red
        self.datePickerView.isHidden = datePickedHidden
        
    }
    
    private  func notificationAuthorization() {
        DispatchQueue.main.async {
            self.showAlertPermission()
        }
    }
    
    private func  showAlertPermission() {
        let alertController = UIAlertController (title: NSLocalizedString("notifErrorTitle", comment: "")
            , message: NSLocalizedString("notifError", comment: "") , preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: NSLocalizedString("btnCancel", comment: ""), style: .default, handler: { _ in
            self.activateNotifSwitch.setOn(false, animated: true)
        })
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func setupUIandNotification() {
        let userNotification = UNUserNotificationCenter.current()
        userNotification.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            DispatchQueue.main.async {
                if granted && self.activateNotifSwitch.isOn {
                    self.notificationHourView.isHidden = false
                }
                else {
                    self.activateNotifSwitch.setOn(false, animated: false)
                    self.notificationHourView.isHidden = true
                }
            }
        }
        
        if let getPreferencesFavorite: [String] = UserDefaults.standard.array(forKey: Constants.UserDefaults.favoritePreferences.rawValue) as? [String] {
            self.tagListView.removeAllTags()
            self.tagListView.addTags(getPreferencesFavorite)
        }
    }
    
    private func setupNavigationBar() {
        guard let font = UIFont(name: "Avenir Next Medium", size: 24) else { return  }
               let textAttributes: [NSAttributedString.Key: Any] = [
                   .font: font,
                   .foregroundColor: UIColor.white,
               ]
        self.title = "Settings"
        navigationController?.navigationBar.barTintColor = Colors.primaryColor
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        
        let buttonIcon = UIImage(named: "left_side")?.withRenderingMode(.alwaysTemplate)
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(GeneralSettingsViewController.back))
        newBackButton.image = buttonIcon
        newBackButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = newBackButton
    }
}

