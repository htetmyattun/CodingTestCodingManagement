//
//  MoviesList.swift
//  CodeManagement
//
//  Created by Htet Myat Tun on 30/05/2023.
//

import Foundation
import Combine

struct MoviesList: Codable {
    
    var dates        : Dates?     = Dates()
    var page         : Int?       = nil
    var results      : [Results]? = []
    var totalPages   : Int?       = nil
    var totalResults : Int?       = nil
    
    enum CodingKeys: String, CodingKey {
        
        case dates        = "dates"
        case page         = "page"
        case results      = "results"
        case totalPages   = "total_pages"
        case totalResults = "total_results"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        dates        = try values.decodeIfPresent(Dates.self     , forKey: .dates        )
        page         = try values.decodeIfPresent(Int.self       , forKey: .page         )
        results      = try values.decodeIfPresent([Results].self , forKey: .results      )
        totalPages   = try values.decodeIfPresent(Int.self       , forKey: .totalPages   )
        totalResults = try values.decodeIfPresent(Int.self       , forKey: .totalResults )
        
    }
    
    init() {
        
    }
    
    static func getUpcomingMovies() -> AnyPublisher<MoviesList, NetworkErrors> {
        return NetworkManager().fetch(type: MoviesList.self, APIRequest(url: "3/movie/upcoming").query(["api_key" : "8ced47e7d15841eedf3215ea144cac93"]))
    }
    
    static func getPopularMovies() -> AnyPublisher<MoviesList, NetworkErrors> {
        return NetworkManager().fetch(type: MoviesList.self, APIRequest(url: "3/movie/popular").query(["api_key" : "8ced47e7d15841eedf3215ea144cac93"]))
    }
}

import Foundation

struct Dates: Codable {
    
    var maximum : String? = nil
    var minimum : String? = nil
    
    enum CodingKeys: String, CodingKey {
        
        case maximum = "maximum"
        case minimum = "minimum"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        maximum = try values.decodeIfPresent(String.self , forKey: .maximum )
        minimum = try values.decodeIfPresent(String.self , forKey: .minimum )
        
    }
    
    init() {
        
    }
    
}

struct Results: Codable {
    
    var adult            : Bool?   = nil
    var backdropPath     : String? = nil
    var genreIds         : [Int]?  = []
    var id               : Int?    = nil
    var originalLanguage : String? = nil
    var originalTitle    : String? = nil
    var overview         : String? = nil
    var popularity       : Double? = nil
    var posterPath       : String? = nil
    var releaseDate      : String? = nil
    var title            : String? = nil
    var video            : Bool?   = nil
    var voteAverage      : Double? = nil
    var voteCount        : Int?    = nil
    
    enum CodingKeys: String, CodingKey {
        
        case adult            = "adult"
        case backdropPath     = "backdrop_path"
        case genreIds         = "genre_ids"
        case id               = "id"
        case originalLanguage = "original_language"
        case originalTitle    = "original_title"
        case overview         = "overview"
        case popularity       = "popularity"
        case posterPath       = "poster_path"
        case releaseDate      = "release_date"
        case title            = "title"
        case video            = "video"
        case voteAverage      = "vote_average"
        case voteCount        = "vote_count"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        adult            = try values.decodeIfPresent(Bool.self   , forKey: .adult            )
        backdropPath     = try values.decodeIfPresent(String.self , forKey: .backdropPath     )
        genreIds         = try values.decodeIfPresent([Int].self  , forKey: .genreIds         )
        id               = try values.decodeIfPresent(Int.self    , forKey: .id               )
        originalLanguage = try values.decodeIfPresent(String.self , forKey: .originalLanguage )
        originalTitle    = try values.decodeIfPresent(String.self , forKey: .originalTitle    )
        overview         = try values.decodeIfPresent(String.self , forKey: .overview         )
        popularity       = try values.decodeIfPresent(Double.self , forKey: .popularity       )
        posterPath       = try values.decodeIfPresent(String.self , forKey: .posterPath       )
        releaseDate      = try values.decodeIfPresent(String.self , forKey: .releaseDate      )
        title            = try values.decodeIfPresent(String.self , forKey: .title            )
        video            = try values.decodeIfPresent(Bool.self   , forKey: .video            )
        voteAverage      = try values.decodeIfPresent(Double.self , forKey: .voteAverage      )
        voteCount        = try values.decodeIfPresent(Int.self    , forKey: .voteCount        )
        
    }
    
    init() {
        
    }
}
