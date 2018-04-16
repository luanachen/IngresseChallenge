//
//  DetailsViewController.swift
//  IngresseChallenge
//
//  Created by Luana on 11/04/18.
//  Copyright © 2018 lccj. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    // MARK: - Properties
    var favID = 0
    var userDefaults = UserDefaults.standard
    var selectedChannel: Show?

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var synopsisTextField: UITextView!
    @IBOutlet weak var releaseDayLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    // MARK: - View Cicle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = selectedChannel?.name

        self.title = selectedChannel?.name
        self.titleLabel.text = selectedChannel?.name
        self.genreLabel.text =  selectedChannel?.genres?.compactMap{$0}.joined(separator: " | ")
        self.releaseDayLabel.text = selectedChannel?.premiered

        let synopsis = selectedChannel?.summary
        self.synopsisTextField.text = synopsis?.removeHtmlFromString(inPutString: synopsis!)

        if let imageString = selectedChannel?.image?.original {
            if let imageURL = URL(string: imageString) {
                imageView.af_setImage(withURL: imageURL)
            }
        }

        guard let id = selectedChannel?.id else { return }
        favID = id

        favoriteButton.isSelected = userDefaults.bool(forKey: "\(favID)")

        favoriteButton.setImage(#imageLiteral(resourceName: "filled_star"), for: .selected)
        let tintedStar = UIImage(named: "empty_star")?.tinted(with: .lightGray)
        favoriteButton.setImage(tintedStar, for: .normal)
    }

    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingToParentViewController {
            selectedChannel = nil
        }
    }

    // MARK: - Action
    @IBAction func favoriteButton(_ sender: UIButton) {

        favoriteButton.setImage(#imageLiteral(resourceName: "filled_star"), for: .selected)
        let tintedStar = UIImage(named: "empty_star")?.tinted(with: .lightGray)
        favoriteButton.setImage(tintedStar, for: .normal)

        sender.isSelected = !sender.isSelected
        userDefaults.set(sender.isSelected, forKey: "\(favID)")
        userDefaults.synchronize()
    }

}
// MARK: Extension - String
extension String{

    func removeHtmlFromString(inPutString: String) -> String{
        return inPutString.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}

