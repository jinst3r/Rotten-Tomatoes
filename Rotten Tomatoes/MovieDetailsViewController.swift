//
//  MovieDetailsViewController.swift
//  Rotten Tomatoes
//
//  Created by Jon Choi on 5/6/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mpaaRatingLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let runtime = movie["runtime"] as? Int
        let runtimeString = String(stringInterpolationSegment: runtime!)
        let ratingsDictionary = movie["ratings"] as! NSDictionary
        
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["synopsis"] as? String
        mpaaRatingLabel.text = movie["mpaa_rating"] as? String
        runtimeLabel.text = "\(runtimeString) min"
        scoreLabel.text = ratingsDictionary["critics_rating"] as? String
        
        // get high res image
        var originalURL = movie.valueForKeyPath("posters.original") as! String
        var transform = originalURL.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let transform = transform {
            originalURL = originalURL.stringByReplacingCharactersInRange(transform, withString: "https://content6.flixster.com/")
        }
        let urlObject = NSURL(string: originalURL)
        imageView.setImageWithURL(urlObject)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
