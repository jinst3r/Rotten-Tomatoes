//
//  MoviesViewController.swift
//  Rotten Tomatoes
//
//  Created by Jon Choi on 5/6/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var refreshControl: UIRefreshControl!
    var sourceURL = ""
    
    @IBOutlet weak var networkErrorLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [NSDictionary]?
    
    override func viewWillAppear(animated: Bool) {
        // network error label stays hidden unless there's no internet
        networkErrorLabel.hidden = true
        
        var reachability = Reachability.reachabilityForInternetConnection()
        reachability.whenUnreachable = { reachability in
            self.networkErrorLabel.hidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        //let url = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json")!
        let url = NSURL(string: sourceURL)
        let request = NSURLRequest(URL: url!)
        
        // HUD
        let progressHUD = JGProgressHUD(style: JGProgressHUDStyle.Dark)
        progressHUD.showInView(view, animated: true)
        progressHUD.dismissAfterDelay(3.0)
        println("HUD")
        
        // Static API Call
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary
            if let json = json {
                self.movies = json["movies"] as? [NSDictionary]
                self.tableView.reloadData()
            }
            
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
                return movies.count
            } else {
                return 0
            }
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        let movie = movies![indexPath.row]
        let runtime = movie["runtime"] as? Int
        let runtimeString = String(stringInterpolationSegment: runtime!)
        let ratingsDictionary = movie["ratings"] as! NSDictionary
        
        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        cell.mpaaRatingLabel.text = movie["mpaa_rating"] as? String
        cell.movieLengthLabel.text = "\(runtimeString) min"
        cell.movieScoreLabel.text = ratingsDictionary["critics_rating"] as? String
        
        let url = NSURL(string: movie.valueForKeyPath("posters.thumbnail") as! String)!
        var urlString = url.absoluteString
        // get high res photo
        var transform = urlString!.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let transform = transform {
            urlString = urlString!.stringByReplacingCharactersInRange(transform, withString: "https://content6.flixster.com/")
        }
        let urlObject = NSURL(string: urlString!)
        
        cell.posterView.setImageWithURL(urlObject)
        var rating = ratingsDictionary["critics_rating"] as! String
        cell.movieScoreImage.image = UIImage(named: "fresh")
        println(rating)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        
        let movie = movies![indexPath!.row]

        let movieDetailsViewController = segue.destinationViewController as! MovieDetailsViewController
        movieDetailsViewController.movie = movie
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        delay(2, closure: {
            self.refreshControl.endRefreshing()
        })
    }

}
