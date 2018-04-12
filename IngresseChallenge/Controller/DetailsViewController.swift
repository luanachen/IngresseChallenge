//
//  DetailsViewController.swift
//  IngresseChallenge
//
//  Created by Luana on 11/04/18.
//  Copyright © 2018 lccj. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var selectedChannel: Channel?

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
        self.genreLabel.text =  selectedChannel?.genres.compactMap{$0.rawValue}.joined(separator: ", ")
        let synopsis = selectedChannel?.summary
        self.synopsisTextField.text = synopsis?.removeHtmlFromString(inPutString: synopsis!)
        self.releaseDayLabel.text = selectedChannel?.premiered
        let imageURL = URL(string: (selectedChannel?.image.original)!)
        self.imageView.af_setImage(withURL: imageURL!)
    }

}
// MARK: Extension - String
extension String{

    func removeHtmlFromString(inPutString: String) -> String{

        return inPutString.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
