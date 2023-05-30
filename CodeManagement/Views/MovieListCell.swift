//
//  MovieListCell.swift
//  CodeManagement
//
//  Created by Htet Myat Tun on 30/05/2023.
//

import UIKit
import RealmSwift

class MovieListCell: UITableViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbPopularity: UILabel!
    @IBOutlet weak var lbReleasedDate: UILabel!
    @IBOutlet weak var lbVotes: UILabel!
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var btnAddToFavourit: UIButton!
    var id = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(title: String, popularity: String, releasedDate: String, votes: String, urlString: String, id: String) {
        lbTitle.text = title
        lbPopularity.text = popularity
        lbReleasedDate.text = releasedDate
        lbVotes.text = votes
        self.id = id
        
        let imageURL = "https://image.tmdb.org/t/p/w500" + urlString
        let url = URL(string: imageURL)!
        showSavedImage(id: id)
        imgPoster.load(url: url, id: id)
    }
    
    func showSavedImage(id: String) {
        
        let realm = try! Realm()
        let scope = realm.objects(Movies.self).filter("id == %@", id)
        let movie: Movies? = scope.first
        
        if movie?.isFavourit ?? false {
            btnAddToFavourit.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
        if let image = UIImage(data: movie?.image ?? Data()) {
            DispatchQueue.main.async {
                self.imgPoster.image = image
            }
        } else {
            self.imgPoster.image = UIImage()
        }
    }
    
    @IBAction func addToFavourit(_ sender: UIButton) {
        let realm = try! Realm()
        let scope = realm.objects(Movies.self).filter("id == %@", self.id)
        let movie = scope.first
        do {
        try realm.write {
            movie?.isFavourit = !(movie?.isFavourit ?? true)
            if movie?.isFavourit ?? false {
                sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                sender.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            }
        } catch {
            print("Something went wrong \(error)")
        }
    }
}
