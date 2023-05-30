//
//  Prefix.swift
//  CodeManagement
//
//  Created by Htet Myat Tun on 30/05/2023.
//

import Foundation
enum Prefix {
    case image
    case icon
    case text
    
    var prefix: String {
        switch self {
        case .image: return "t/p/w500"
        case .icon: return "t/p/original"
        case .text: return ""
        }
    }
}
