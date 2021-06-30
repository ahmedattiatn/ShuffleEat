//
//  Agent.swift
//  ShuffleEat
//
//  Created by Malek BARKAOUI on 18/08/2020.
//  Copyright © 2020 Ahmed ATIA. All rights reserved.
//

import Foundation
import Combine


public enum ResponseError: Error {
    case noInternet
    case statusCode
    case unauthorized //401
    case notFound // 404
    case serviceDown // 500
    case internalServer // 402
    case decoding
    case invalidURL
    case other(Error)
    
    static func map(_ error: Error) -> ResponseError {
      return (error as? ResponseError) ?? .other(error)
    }
  }

struct Agent {
    // 1
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
        
    // 2
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
             // 3
            .tryMap { result -> Response<T> in
                
                  // 3
                 if let httpURLResponse = result.response as? HTTPURLResponse
                  
                   {
                    switch httpURLResponse.statusCode {
                    case  200:
                         let value = try decoder.decode(T.self, from: result.data) // 4
                                    return Response(value: value, response: result.response)
                        
                    case  HTTPCodes.unauthorized.rawValue:
                    throw ResponseError.unauthorized
                    
                    case  HTTPCodes.internalServer.rawValue:
                    throw ResponseError.internalServer
  
                    case  HTTPCodes.notFound.rawValue:
                    throw ResponseError.notFound
                        
                    case  HTTPCodes.serviceDown.rawValue:
                    throw ResponseError.serviceDown
                        
                    default:
                    throw ResponseError.statusCode

                    }
                    // 4
                    
                 } else {
                    throw ResponseError.statusCode
                }
                
                 // 5
            }
        .mapError{
            // to check for internet Connection
            guard let error = $0 as? (URLError) else {
                return ResponseError.statusCode
            }
            switch  error.code.rawValue {
            case HTTPCodes.noInternet.rawValue:
                return  ResponseError.noInternet
            default:
                return ResponseError.statusCode
            }
            }
            .receive(on: DispatchQueue.main) // 6
            .eraseToAnyPublisher() // 7
    }
}
