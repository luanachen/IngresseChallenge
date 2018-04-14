//
//  ChannelTableViewController.swift
//  IngresseChallenge
//
//  Created by Luana on 11/04/18.
//  Copyright © 2018 lccj. All rights reserved.
//

import UIKit
import AlamofireImage

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

        tableView.register(UINib(nibName: "ChannelCell", bundle: nil), forCellReuseIdentifier: "customCell")

        searchBar.delegate = self
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

            let genres = channel.genres?.compactMap{$0}.joined(separator: ", ")
            cell.genreLabel.text = genres

            if let imageString = channel.image?.original {
                if let imageURL = URL(string: imageString) {
                    cell.posterImage.af_setImage(withURL: imageURL)
                } else {
                    cell.posterImage.image = #imageLiteral(resourceName: "movie_placeholder.png")
                }
            }
            cell.posterImage.isHidden = false
            cell.favoriteButton.isHidden = false

            cell.favID = channel.id
            cell.updateSelection()

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
extension ChannelTableViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        guard !searchText.isEmpty else {
            channelsArray?.removeAll()
            tableView.reloadData()
            return
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        if let text = searchBar.text {
            let text = text.replacingOccurrences(of: " ", with: "+")
            GetAPIData().fetchChannels(by: text) { (channels) in
                self.channelsArray = channels.compactMap { $0.show }
            }
            tableView.allowsSelection = true
            tableView.reloadData()
        }
    }

}








