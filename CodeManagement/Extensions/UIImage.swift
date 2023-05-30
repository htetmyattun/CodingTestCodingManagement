//
//  UIImage.swift
//  CodeManagement
//
//  Created by Htet Myat Tun on 30/05/2023.
//

import UIKit
import RealmSwift

extension UIImageView {
    func load(url: URL, id: String) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                
                let realm = try! Realm()
                let scope = realm.objects(Movies.self).filter("id == %@", id)
                let movie: Movies? = scope.first
                
                do {
                try realm.write {
                    movie?.image = data
                    }
                } catch {
                    print("Something went wrong \(error)")
                }
                
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
