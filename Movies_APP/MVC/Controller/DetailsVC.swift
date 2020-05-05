//
//  DetailsVC.swift
//  Movies_APP
//
//  Created by Hany Karam on 5/3/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
class DetailsVC: UIViewController {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rate: UILabel!
    
    var delegate: DelegateItemSelected?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let movies = delegate {
            self.name.text = movies.name
            self.rate.text = "Rate: \(movies.rate ?? 0)"
            self.img.setImage(imageUrl: movies.image!)
            
        }
        
    }
    
    @IBAction func Back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
}
