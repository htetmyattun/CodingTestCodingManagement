//
//  MoviesListViewCotroller.swift
//  CodeManagement
//
//  Created by Htet Myat Tun on 30/05/2023.
//

import Foundation
import UIKit

class MoviesListViewController: UIViewController {
    @IBOutlet weak var tbUpComingMovies: UITableView!
    @IBOutlet weak var tbPopularMovies: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel = MoviesListViewModel()
    var loadingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbUpComingMovies.dataSource =  self
        tbUpComingMovies.delegate = self
        tbUpComingMovies.register(UINib.init(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: "MovieListCell")
        
        tbPopularMovies.dataSource =  self
        tbPopularMovies.delegate = self
        tbPopularMovies.register(UINib.init(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: "MovieListCell")
        viewModel.fetchMovies()
        viewModel.viewCotroller = self
        
        startLoadingAnimation()
        initViewModel()
    }
    
    func initViewModel(){
        viewModel.reloadUpcomingTableView = {
            DispatchQueue.main.async { self.tbUpComingMovies.reloadData() }
        }
        
        viewModel.reloadPopularTableView = {
            DispatchQueue.main.async { self.tbPopularMovies.reloadData() }
        }
        
        viewModel.showError = {
            DispatchQueue.main.async { self.showAlert(self.viewModel.errorStr) }
        }
        viewModel.showLoading = {
            DispatchQueue.main.async { self.startLoadingAnimation() }
        }
        viewModel.hideLoading = {
            DispatchQueue.main.async { self.stopLoadingAnimation() }
        }
        viewModel.getData()
    }
    
    func startLoadingAnimation() {
        loadingView = showLoading(onView: self.view)
    }
    
    func stopLoadingAnimation() {
        if loadingView != nil {
            removeLoading(loadingView: loadingView)
        }
    }
}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbUpComingMovies {
            return viewModel.upcomingMovies.count
        } else {
            return viewModel.popularMovies.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tbUpComingMovies {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
            cell.setData(title: viewModel.upcomingMovies[indexPath.row].title ?? "", popularity: String(viewModel.upcomingMovies[indexPath.row].popularity ?? 0.0), releasedDate: viewModel.upcomingMovies[indexPath.row].releaseDate ?? "", votes: String(viewModel.upcomingMovies[indexPath.row].voteAverage ?? 0.0), urlString: viewModel.upcomingMovies[indexPath.row].posterPath ?? "", id: String(viewModel.upcomingMovies[indexPath.row].id ?? 0))
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
            cell.setData(title: viewModel.popularMovies[indexPath.row].title ?? "", popularity: String(viewModel.popularMovies[indexPath.row].popularity ?? 0.0), releasedDate: viewModel.popularMovies[indexPath.row].releaseDate ?? "", votes: String(viewModel.popularMovies[indexPath.row].voteAverage ?? 0.0), urlString: viewModel.popularMovies[indexPath.row].posterPath ?? "", id: String(viewModel.popularMovies[indexPath.row].id ?? 0))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tbUpComingMovies {
            viewModel.goToMovieDetails(id: String(viewModel.upcomingMovies[indexPath.row].id ?? 0))
        } else {
            viewModel.goToMovieDetails(id: String(viewModel.popularMovies[indexPath.row].id ?? 0))
        }
    }
}
