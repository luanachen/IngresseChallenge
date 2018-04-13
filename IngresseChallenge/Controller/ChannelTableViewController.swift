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
    var channelsArray = [Show]()

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
        if (searchBar.text?.isEmpty)! {
            channelsArray = []
            return 1
        }
        return channelsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? ChannelCell else { return UITableViewCell() }

        if (searchBar.text?.isEmpty)! {
            cell.titleLabel.text = ""
            cell.genreLabel.text = "Looking for something? :)"
            cell.posterImage.isHidden = true
            cell.favoriteButton.isHidden = true
            tableView.allowsSelection = false
            return cell
        }
        
        cell.titleLabel.text = channelsArray[indexPath.row].name

        let genres = channelsArray[indexPath.row].genres.compactMap{$0}.joined(separator: ", ")
        cell.genreLabel.text = genres

        let imageURL = URL(string: channelsArray[indexPath.row].image.medium)
        cell.posterImage.isHidden = false
        cell.posterImage.af_setImage(withURL: imageURL!)

        cell.favoriteButton.isHidden = false

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        destinationVC.selectedChannel = self.channelsArray[indexPath.row]
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }

}
extension ChannelTableViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        GetAPIData().fetchChannels(by: searchText) { (channels) in
            self.channelsArray = channels.compactMap { $0.show }
        }
        tableView.allowsSelection = true
        tableView.reloadData()
    }

}



