//
//  DefaultHeaders.swift
//  CodeManagement
//
//  Created by Htet Myat Tun on 30/05/2023.
//

import Foundation
import UIKit

struct DefaultHeaders {
    static var headers: [String: String] = [
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4Y2VkNDdlN2QxNTg0MWVlZGYzMjE1ZWExNDRjYWM5MyIsInN1YiI6IjY0NzVhY2M2ZGQyNTg5MDBlMjBjYjIxZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.e6gMWFRps_awhJqOgJFZqoV1j3sWZm4bBct-aGttXqY"
    ]
    
    static func addAdditionalHeaders(_ headers: [String:String]) {
        for (key, value) in headers {
            self.headers[key] = value
        }
    }
}
