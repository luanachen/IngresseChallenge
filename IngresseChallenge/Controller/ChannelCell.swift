//
//  ChannelCell.swift
//  IngresseChallenge
//
//  Created by Luana on 11/04/18.
//  Copyright © 2018 lccj. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    // MARK: - Properties
    var favID = 0
    let userDefaults = UserDefaults.standard
    var index: IndexPath!

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!

    // MARK: - View Cicle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Action
    @IBAction func favoriteButton(_ sender: UIButton) {
        favoriteButton.setImage(#imageLiteral(resourceName: "filled_star"), for: .selected)
        favoriteButton.setImage(#imageLiteral(resourceName: "empty_star"), for: .normal	)

        sender.isSelected = !sender.isSelected
        let key = "\(favID)"
        userDefaults.set(sender.isSelected, forKey: key)
        userDefaults.synchronize()
    }

    // MARK: - Methods
    func updateSelection() {
        let key = "\(favID)"
        let isFav = userDefaults.bool(forKey: key)
        favoriteButton.isSelected = isFav
    }
    
}
