//
//  Configuration.swift
//  CodeManagement
//
//  Created by Htet Myat Tun on 30/05/2023.
//

import Foundation

struct Configuration {
    lazy var baseUrl: String = Bundle.main.infoDictionary?["baseUrl"] as! String

    var environment: Env = {

        let configuration = Bundle.main.infoDictionary?["Configuration"]  as? String

        switch configuration {
        case "Debug"?:
            return Env.debug
        case "QA"?:
            return Env.qa
        case "Production"?:
            return Env.production
        default:
            return Env.debug
        }
    }()
}
