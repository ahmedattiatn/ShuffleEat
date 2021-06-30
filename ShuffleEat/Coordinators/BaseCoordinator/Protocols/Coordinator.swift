//
//  Coordinator.swift
//  ShuffleEat
//
//  Created by Malek BARKAOUI on 21/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    func start()
    func start(with option: DeepLinkOption?)
}
