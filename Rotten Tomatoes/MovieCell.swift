//
//  MovieCell.swift
//  Rotten Tomatoes
//
//  Created by Jon Choi on 5/6/15.
//  Copyright (c) 2015 Jon Choi. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var mpaaRatingLabel: UILabel!
    @IBOutlet weak var movieLengthLabel: UILabel!
    @IBOutlet weak var movieScoreLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var movieScoreImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
