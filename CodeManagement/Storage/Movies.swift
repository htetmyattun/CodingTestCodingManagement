//
//  Movies.swift
//  CodeManagement
//
//  Created by Htet Myat Tun on 30/05/2023.
//

import Foundation
import RealmSwift

class Movies: Object {
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var pouplarity = 0.0
    @objc dynamic var releasedDate = ""
    @objc dynamic var rating = 0.0
    @objc dynamic var isFavourit = false
    @objc dynamic var isPopular = false
    @objc dynamic var originalTitle = ""
    @objc dynamic var overview = ""
    @objc dynamic var originalLanguage = ""
    @objc dynamic var voteCount = 0
    @objc dynamic var image = Data()
}
