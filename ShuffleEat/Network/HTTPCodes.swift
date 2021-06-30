//
//  HTTPCodes.swift
//  ShuffleEat
//
//  Created by Malek BARKAOUI on 19/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import Foundation

public enum HTTPCodes: Int {
  case unauthorized = 401
  case internalServer = 402
  case notFound = 404
  case serviceDown = 500
  case noInternet = -1009
}
