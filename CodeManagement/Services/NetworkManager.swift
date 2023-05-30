//
//  NetworkManager.swift
//  CodeManagement
//
//  Created by Htet Myat Tun on 30/05/2023.
//

import Foundation
import Combine

class NetworkManager {
    
    var statusCode: Int?
    
    func fetch<T: Codable>(type: T.Type, _ request: APIRequest, base: String? = nil) -> AnyPublisher<T, NetworkErrors> {
        return request.session.dataTaskPublisher(for: request.getURLRequest(base))
          .tryMap { response -> Data in
            guard
              let httpURLResponse = response.response as? HTTPURLResponse,
              httpURLResponse.statusCode >= 200 && httpURLResponse.statusCode < 300
              else {
                self.statusCode = (response.response as? HTTPURLResponse)?.statusCode
                throw try JSONDecoder().decode(ErrorResponse.self, from: response.data)
            }
            Logger.shared.print(from: "\(Self.self)", message: "Response -> \(response)")
            return response.data
          }
          .decode(type: T.self, decoder: JSONDecoder())
          .mapError {
              if self.statusCode == nil {
                  print("Error occured -> ", $0)
                  return NetworkErrors.map(Int(0), $0)
              } else {
              return NetworkErrors.map(self.statusCode, $0) }
          }
          .eraseToAnyPublisher()
    }
    
    func test() {
        
    }
}

struct ErrorResponse: Codable, Error {
    let error_msg: String
}
