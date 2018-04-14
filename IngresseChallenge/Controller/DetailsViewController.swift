//
//  DetailsViewController.swift
//  IngresseChallenge
//
//  Created by Luana on 11/04/18.
//  Copyright © 2018 lccj. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var selectedChannel: Show?
    var userDefaults = UserDefaults()
    var favID = 0

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var synopsisTextField: UITextView!
    @IBOutlet weak var releaseDayLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = selectedChannel?.name
        self.titleLabel.text = selectedChannel?.name
        self.genreLabel.text =  selectedChannel?.genres?.compactMap{$0}.joined(separator: ", ")
        self.releaseDayLabel.text = selectedChannel?.premiered

        let synopsis = selectedChannel?.summary
        self.synopsisTextField.text = synopsis?.removeHtmlFromString(inPutString: synopsis!)


        if let imageString = selectedChannel?.image?.original {
            if let imageURL = URL(string: imageString) {
                imageView.af_setImage(withURL: imageURL)
            }
        }

        guard let favID = selectedChannel?.id else { return }

        favoriteButton.isSelected = userDefaults.bool(forKey: "\(favID)")
        favoriteButton.setImage(#imageLiteral(resourceName: "filled_star"), for: .selected)
        favoriteButton.setImage(#imageLiteral(resourceName: "empty_star"), for: .normal)
    }

    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingToParentViewController {
            selectedChannel = nil
        }
    }

    @IBAction func favoriteButton(_ sender: UIButton) {

        favoriteButton.setImage(#imageLiteral(resourceName: "filled_star"), for: .selected)
        favoriteButton.setImage(#imageLiteral(resourceName: "empty_star"), for: .normal    )

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
