//
//  MovieDetailModule.swift
//  CodeManagement
//
//  Created by Htet Myat Tun on 30/05/2023.
//

import Foundation
import UIKit

class MovieDetailModule {
    func build(id: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewCotroller") as! MovieDetailsViewCotroller
        view.id = id
        return view
    }
}
