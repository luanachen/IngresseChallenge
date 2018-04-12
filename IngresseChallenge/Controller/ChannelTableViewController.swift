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

    // MARK: Properties
    var channelsArray = [Channel]()
//    var imagesArray = [Image]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ChannelCell", bundle: nil), forCellReuseIdentifier: "customCell")

        GetAPIData().fetchChannels { (channels) in
            self.channelsArray = channels
            self.tableView.reloadData()
        }

    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! ChannelCell
        cell.titleLabel.text = channelsArray[indexPath.row].name
        let genres = channelsArray[indexPath.row].genres.compactMap{$0.rawValue}.joined(separator: ", ")
        cell.genreLabel.text = genres
        let imageURL = URL(string: channelsArray[indexPath.row].image.medium)
        cell.posterImage.af_setImage(withURL: imageURL!)
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
