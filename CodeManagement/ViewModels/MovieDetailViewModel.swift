//
//  MovieDetailViewModel.swift
//  CodeManagement
//
//  Created by Htet Myat Tun on 30/05/2023.
//

import Foundation
import RealmSwift

class MovieDetailViewModel {
    var title: String
    var releasedDate: String
    var rating: String
    var popularity: String
    var originalTitle: String
    var overview: String
    var voteCount: String
    var originalLaguage: String
    var image: Data
    
    init(id: String) {
        let realm = try! Realm()
        let movies = realm.objects(Movies.self).filter("id == %@", id)
        let movie = movies.first
        
        self.title = movie?.title ?? ""
        self.releasedDate = movie?.releasedDate ?? ""
        self.rating = String(movie?.rating ?? 0.0)
        self.popularity = String(movie?.pouplarity ?? 0.0)
        self.originalTitle = movie?.originalTitle ?? ""
        self.overview = movie?.overview ?? ""
        self.voteCount = String(movie?.voteCount ?? 0)
        self.originalLaguage = movie?.originalLanguage ?? ""
        self.image = movie?.image ?? Data()
    }
}
