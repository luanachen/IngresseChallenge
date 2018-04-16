//
//  ChannelTableViewController.swift
//  IngresseChallenge
//
//  Created by Luana on 11/04/18.
//  Copyright © 2018 lccj. All rights reserved.
//

import UIKit
import AlamofireImage
import SVProgressHUD

class ChannelTableViewController: UITableViewController {

    // MARK: - Properties
    var channelsArray: [Show]?
    let favoriteKey = "favorites"
    var favorites = [Int]()
    let userDefaults = UserDefaults.standard

    // MARK: - Outlets
    @IBOutlet var searchBar: UISearchBar!

    // MARK: - View Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.black
        tableView.register(UINib(nibName: "ChannelCell", bundle: nil), forCellReuseIdentifier: "customCell")
        searchBar.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.channelsArray?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? ChannelCell else { return UITableViewCell() }

        if let channel = channelsArray?[indexPath.row] {

            cell.titleLabel.text = channel.name

            let genres = channel.genres?.compactMap{$0}.joined(separator: " | ")
            cell.genreLabel.text = genres

            if let imageString = channel.image?.original {
                if let imageURL = URL(string: imageString) {
                    cell.posterImage.af_setImage(withURL: imageURL)
                } else {
                    cell.posterImage.image = UIImage(named: "movie_placeholder")
                }
            }
            cell.posterImage.isHidden = false
            cell.favoriteButton.isHidden = false
            
            cell.favID = channel.id
            cell.updateSelection()
            cell.favoriteButton.setImage(#imageLiteral(resourceName: "filled_star"), for: .selected)

            let tintedStar = UIImage(named: "empty_star")?.tinted(with: .lightGray)
            cell.favoriteButton.setImage(tintedStar, for: .normal)

            return cell
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        guard let channel = self.channelsArray?[indexPath.row] else { return }
        destinationVC.selectedChannel = channel
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }

}

// MARK: - UISearchBarDelegate
extension ChannelTableViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        guard !searchText.isEmpty else {
            channelsArray?.removeAll()
            tableView.reloadData()
            return
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        SVProgressHUD.show()
        if let text = searchBar.text {
            let text = text.replacingOccurrences(of: " ", with: "+")
            GetAPIData().fetchChannels(by: text) { (channels) in
                self.channelsArray = channels.compactMap { $0.show }
                self.tableView.reloadData()
                self.tableView.allowsSelection = true
            }
            SVProgressHUD.dismiss()
        }
    }

}
// MARK: Extension - UIImage
extension UIImage {
    func tinted(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        color.set()
        withRenderingMode(.alwaysTemplate)
            .draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}








