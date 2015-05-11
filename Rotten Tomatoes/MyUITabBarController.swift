//
//  MyUITabBarController.swift
//  Rotten Tomatoes
//
//  Created by Jon Choi on 5/10/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class MyUITabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var i = 0
        
        // per ming
        var boxOfficeNavController: UINavigationController = self.viewControllers![0] as! UINavigationController
        var boxOfficeViewController: MoviesViewController = boxOfficeNavController.viewControllers![0] as! MoviesViewController
        var dvdNavController: UINavigationController = self.viewControllers![1] as! UINavigationController
        var dvdViewController: MoviesViewController = dvdNavController.viewControllers![0] as! MoviesViewController
        
        // per ming
        boxOfficeViewController.title = "In Theatres"
        dvdViewController.title = "On DVD"
        var theatreImage = UIImage(named: "movieImage")
        var dvdImage = UIImage(named: "CDImage")

        
        boxOfficeViewController.tabBarItem = UITabBarItem(title: "In Theatres", image: theatreImage, selectedImage: theatreImage)
        dvdViewController.tabBarItem = UITabBarItem(title: "On DVD", image: dvdImage, selectedImage: dvdImage)
        boxOfficeViewController.sourceURL = "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json"
        dvdViewController.sourceURL = "https://gist.githubusercontent.com/timothy1ee/e41513a57049e21bc6cf/raw/b490e79be2d21818f28614ec933d5d8f467f0a66/gistfile1.json"
        
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
