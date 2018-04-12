//
//  ChannelCell.swift
//  IngresseChallenge
//
//  Created by Luana on 11/04/18.
//  Copyright © 2018 lccj. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {

        let newValue = !sender.isSelected
        sender.isSelected = newValue

        UserDefaults.standard.set(newValue, forKey: "isFavorited")

        // TODO: save and retrieve favorite state
        
        if sender.isSelected {
            favoriteButton.setImage(UIImage(named: "empty_star"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "filled_star"), for: .selected)
        }
    }
}
