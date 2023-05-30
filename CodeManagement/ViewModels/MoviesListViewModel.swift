//
//  MoviesListViewModel.swift
//  CodeManagement
//
//  Created by Htet Myat Tun on 30/05/2023.
//

import Foundation
import Combine
import RealmSwift
import UIKit

class MoviesListViewModel: ObservableObject {
    
    var upcomingMoviesSubscriptions: AnyCancellable?
    var popularMoviesSubscriptions: AnyCancellable?
    var reloadUpcomingTableView: (()->())?
    var reloadPopularTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    var viewCotroller: UIViewController?
    var errorStr = ""
    
    var upcomingMovies: [Results] = [Results]() {
        didSet {
            hideLoading?()
            self.reloadUpcomingTableView?()
        }
    }
    
    var popularMovies: [Results] = [Results]() {
        didSet {
            hideLoading?()
            self.reloadPopularTableView?()
        }
    }
    
    func fetchMovies() {
        let realm = try! Realm()
        let popularMovies = realm.objects(Movies.self).filter("isPopular == true")
        let upcomingMovies = realm.objects(Movies.self).filter("isPopular == false")
        
        var savedPopularMovies: [Results] = [Results]()
        var savedUpcomingMovies: [Results] = [Results]()
        
        for item in popularMovies {
            var movie = Results()
            movie.title = item.title
            movie.id = Int(item.id)
            movie.popularity = item.pouplarity
            movie.releaseDate = item.releasedDate
            movie.voteAverage = item.rating
            savedPopularMovies.append(movie)
        }
        
        
        for item in upcomingMovies {
            var movie = Results()
            movie.title = item.title
            movie.id = Int(item.id)
            movie.popularity = item.pouplarity
            movie.releaseDate = item.releasedDate
            movie.voteAverage = item.rating
            savedUpcomingMovies.append(movie)
        }
        
        self.popularMovies = savedPopularMovies
        self.upcomingMovies = savedUpcomingMovies
    }
    
    func getData(){
        upcomingMoviesSubscriptions = MoviesList.getUpcomingMovies()
            .receive(on: DispatchQueue.global())
            .sink { error in
                switch error {
                case .finished: print("Getting upcoming movies data finished successfully.")
                case .failure(let error): print(error.getDebugDescription(Self.self))
                    self.errorStr = error.get()
                    self.showError?()
                }
            } receiveValue: { moviesList in
                Logger.shared.print(from: "\(Self.self)", message: "Received Data -> \(moviesList)")
                self.upcomingMovies = moviesList.results ?? []
                self.addMovieList(movies: self.upcomingMovies)
            }
        
        popularMoviesSubscriptions = MoviesList.getPopularMovies()
            .receive(on: DispatchQueue.global())
            .sink { error in
                switch error {
                case .finished: print("Getting popular movies data finished successfully.")
                case .failure(let error): print(error.getDebugDescription(Self.self))
                    self.errorStr = error.get()
                    self.showError?()
                }
            } receiveValue: { moviesList in
                Logger.shared.print(from: "\(Self.self)", message: "Received Data -> \(moviesList)")
                self.popularMovies = moviesList.results ?? []
                self.addMovieList(movies: self.popularMovies, isPopular: true)
            }
    }
    
    func addMovieList(movies: [Results], isPopular: Bool = false) {
        let realm = try! Realm()
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        for i in 0..<movies.count {
            let movie = getMovieById(id: String(movies[i].id ?? 0))
            if movie == nil {
                do {
                    try realm.write {
                        let movie = Movies()
                        
                        movie.id = String(movies[i].id ?? 0)
                        movie.title = movies[i].title ?? ""
                        movie.releasedDate = movies[i].releaseDate ?? ""
                        movie.rating = movies[i].voteAverage ?? 0.0
                        movie.pouplarity = movies[i].popularity ?? 0.0
                        movie.isPopular = isPopular
                        movie.originalTitle = movies[i].originalTitle ?? ""
                        movie.overview = movies[i].overview ?? ""
                        movie.voteCount = movies[i].voteCount ?? 0
                        movie.originalLanguage = movies[i].originalLanguage ?? ""
                        
                        realm.add(movie)
                    }
                } catch {
                    print("Something went wrong \(error)")
                }
            } else {
                do {
                try realm.write {
                    movie?.rating = movies[i].voteAverage ?? 0.0
                    movie?.pouplarity = movies[i].popularity ?? 0.0
                    movie?.isPopular = isPopular
                    }
                } catch {
                    print("Something went wrong \(error)")
                }
            }
        }
    }
    
    func getMovieById(id: String) -> Movies? {
        let realm = try! Realm()
        let scope = realm.objects(Movies.self).filter("id == %@", id)
        return scope.first
    }
    
    func goToMovieDetails(id: String) {
        let view = MovieDetailModule().build(id: id)
        view.modalPresentationStyle = .fullScreen
        viewCotroller?.present(view, animated: true)
    }
}
