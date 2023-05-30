//
//  Environment.swift
//  CodeManagement
//
//  Created by Htet Myat Tun on 30/05/2023.
//

import Foundation
enum Env: String {
    
    case debug = "dev"
    case qa = "qa"
    case production = "production"
    
    var baseURL: String {
        switch self {
        case .debug: return "https://api.themoviedb.org/"
        case .qa: return "https://api.themoviedb.org/"
        case .production: return "https://api.themoviedb.org/"
        }
    }
    
}
