//
//  ViewController.swift
//  Junk4Dollars-app
//
//  Created by John Riccardi on 10/23/19.
//  Copyright © 2019 John Riccardi. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    struct Auction {
        var title: String
        var description: String
        var starting_price: Int
        var ends_at: String
    }
        
    var auctions: [Auction] = [
        Auction(title: "Throne of Eldraine Booster Box", description: "New: A brand-new, unused, unopened, undamaged item (including handmade items).", starting_price: 8500, ends_at: "2019-11-01 15:35:21 -0500"),
        Auction(title: "Oko, Theif of Crowns", description: "Brand new. Single card", starting_price: 1000, ends_at: "2019-11-01 15:35:21 -0500"),
        Auction(title: "MTG M20 Booster Box", description: "Magic the Gathering MTG Core Set 2020 Booster Box", starting_price: 9000, ends_at: "2019-11-01 15:35:21 -0500")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return auctions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Auction", for: indexPath)
        cell.textLabel?.text = auctions[indexPath.row].title
        return cell
    }
}
