//
//  Notification.swift
//  ShuffleEat
//
//  Created by Ahmed ATIA on 24/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import UIKit

struct NotificationSettings  {
    var title: String
    var body: String
    
    init(){
        self.title = NSLocalizedString("notifTitle", comment: "")
        self.body = NSLocalizedString("notifBody", comment: "")
    }
}
