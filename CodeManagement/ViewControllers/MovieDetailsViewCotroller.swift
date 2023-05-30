//
//  MovieDetails.swift
//  CodeManagement
//
//  Created by Htet Myat Tun on 30/05/2023.
//

import Foundation
import UIKit

class MovieDetailsViewCotroller: UIViewController {
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbReleasedDate: UILabel!
    @IBOutlet weak var lbRating: UILabel!
    @IBOutlet weak var lbPopularity: UILabel!
    @IBOutlet weak var lbOriginalTitle: UILabel!
    @IBOutlet weak var lbOverview: UILabel!
    @IBOutlet weak var lbOriginalLaguage: UILabel!
    @IBOutlet weak var lbVoteCount: UILabel!
    
    var viewModel: MovieDetailViewModel?
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        display()
    }
    
    func display() {
        viewModel = MovieDetailViewModel(id: id)
        lbTitle.text = viewModel?.title
        if let image = UIImage(data: viewModel?.image ?? Data()) {
            DispatchQueue.main.async {
                self.imgPoster.image = image
            }
        }
        lbReleasedDate.text = viewModel?.releasedDate
        lbRating.text = viewModel?.rating
        lbPopularity.text = "Popularity = " + (viewModel?.popularity ?? "")
        lbOriginalTitle.text = "Original Title = " + (viewModel?.originalTitle ?? "")
        lbOverview.text = viewModel?.overview
        lbOriginalLaguage.text = viewModel?.originalLaguage
        lbVoteCount.text = "Total Votes = " + (viewModel?.voteCount ?? "")
    }
    
    @IBAction func _back(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
