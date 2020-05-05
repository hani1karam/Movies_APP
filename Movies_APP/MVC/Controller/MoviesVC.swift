//
//  ViewController.swift
//  Movies_APP
//
//  Created by Hany Karam on 5/2/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
protocol DelegateItemSelected {
    var name: String? {get set}
    var rate: Double? {get set}
    var image: URL? {get set}
    
}
class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate, DelegateItemSelected{
    
    @IBOutlet weak var HomeTV: UICollectionView!
    
    var MoviesArray = [Result]()
    var rate: Double?
    var name: String?
    var image: URL?
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
        HomeTV.delegate = self
        HomeTV.dataSource = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let Deatils = segue.destination as! DetailsVC
        Deatils.delegate = self
        Deatils.delegate?.name = MoviesArray[index].title
        Deatils.delegate?.rate = MoviesArray[index].voteAverage
        let poster_base_url = "https://image.tmdb.org/t/p/w500"
        let postpath = MoviesArray[index].posterPath ?? ""

        Deatils.delegate?.image = URL(string: poster_base_url + postpath)
    
              }
    
    func loadMovies(){
        NetworkApi.sendRequest(method: .get, url: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed", completion:
            
            {(err,response: Movies?) in
                
                if err == nil{
                    guard let data = response.self else{return}
                    self.MoviesArray = data.results;
                    self.HomeTV.reloadData()
                    
                }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MoviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.name.text = MoviesArray[indexPath.row].title
        cell.rate.text = "Rate:  \(MoviesArray[indexPath.row].voteAverage ?? 0)"
        DispatchQueue.main.async {
            cell.configure(movies: self.MoviesArray[indexPath.row])
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "Home", sender: self)
        
    }
}

 
