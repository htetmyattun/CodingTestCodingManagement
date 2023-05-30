//
//  Logger.swift
//  CodeManagement
//
//  Created by Htet Myat Tun on 30/05/2023.
//

import Foundation

class Logger {

    static let shared = Logger()

    var shouldPrint: Bool = false

    init() {
        let configuration = Bundle.main.infoDictionary?["Configuration"]  as? String
        shouldPrint = (configuration == "QA") ? false : true
    }

    public func print(from: String, message: String) {
        if shouldPrint {
            debugPrint("\(from) -> \(message)")
        }
    }
}
