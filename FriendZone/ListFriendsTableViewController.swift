//
//  ListFriendsTableViewController.swift
//  FriendZone
//
//  Created by Han Luong on 5/22/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import UIKit

class ListFriendsTableViewController: UITableViewController {

    var friends = [Friend]()
    var selectedFriend: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()

        title = "Friend Zone"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = friends[indexPath.row]
        cell.textLabel?.text = friend.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = friend.timeZone
        dateFormatter.timeStyle = .short
        cell.detailTextLabel?.text = dateFormatter.string(from: Date())
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        configure(friend: friends[indexPath.row], position: indexPath.row)
    }
    
    func loadData() {
        let defaults = UserDefaults.standard
        guard let savedData = defaults.value(forKey: "Friend") as? Data else { return }
        let decoder = JSONDecoder()
        guard let savedFriends = try? decoder.decode([Friend].self, from: savedData) else { return }
        friends = savedFriends
    }
    
    func saveData() {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        guard let savedData = try? encoder.encode(friends) else { fatalError("Unable to encode friends data") }
        defaults.set(savedData, forKey: "Friend")
    }
    
    @objc func addFriend() {
        let friend = Friend()
        friends.append(friend)
        tableView.insertRows(at: [IndexPath(row: friends.count - 1, section: 0)], with: .automatic)
        saveData()
        configure(friend: friend, position: friends.count - 1)
    }
    
    func configure(friend: Friend, position: Int) {
        guard let vc = storyboard?.instantiateViewController(identifier: "FriendTableViewController") as? FriendTableViewController else {
            fatalError("Unable to create FriendTableViewController")
        }
        selectedFriend = position
        vc.delegate = self
        vc.friend = friend
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func update(friend: Friend) {
        guard let selectedFriend = selectedFriend else { return }
        friends[selectedFriend] = friend
        tableView.reloadData()
        saveData()
    }
}
