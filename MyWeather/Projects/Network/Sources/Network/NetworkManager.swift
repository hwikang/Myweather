//
//  NetworkManager.swift
//  Network
//
//  Created by hwikang on 10/15/24.
//  Copyright © 2024 HwiKang. All rights reserved.
//

import Foundation
import Alamofire
import Entity

public struct NetworkManager {
    public init() {}

    private let session: Session = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        return Session(configuration: config)
         
    }()

    public func fetchData<T:Decodable> (url: String, method: HTTPMethod, parameters: Parameters? = nil,
                                 encoding: ParameterEncoding = URLEncoding.default) async -> Result<T, NetworkError> {
        guard let url = URL(string: url) else {
            return .failure(NetworkError.urlError)
        }
        print("url - \(url)")
        
        let result = await session.request(url, method: method, parameters: parameters, encoding: encoding)
            .validate().serializingData().response
        if let error = result.error { return .failure(NetworkError.requestFailed(error.errorDescription ?? ""))}
        guard let data = result.data else { return .failure(NetworkError.dataNil) }
        guard let response =  result.response else { return .failure(NetworkError.invalid) }
    
        if 200..<400 ~= response.statusCode {
            do {
                
                let networkResponse = try JSONDecoder().decode(T.self, from: data)
                
                return .success(networkResponse)
            } catch {
                print(error)
                return .failure(NetworkError.failToDecode(error.localizedDescription))

            }
        } else {
            return .failure(NetworkError.serverError(response.statusCode))
        }
    }
}
