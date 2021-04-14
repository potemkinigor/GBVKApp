//
//  SearchGroupsTableViewController.swift
//  VKApp
//
//  Created by User on 01.02.2021.
//

import UIKit

class SearchGroupsTableViewController: UITableViewController {
    
    @IBOutlet weak var groupsSearchBar: UISearchBar!
    let networkManager = Session.shared
    let photoCache = PhotoCache.shared
    let firebaseManager = FirebaseManager.shared
    
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.groupsSearchBar.delegate = self
        
        tableView.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "searchGroupsCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchGroupsCell", for: indexPath) as! GroupsTableViewCell
        
        cell.groupsAvatarView.groupAvatar.image = photoCache.cachedPhotoDictionary[groups[indexPath.row].avatarURL]
        cell.groupNameLabel.text = groups[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        groups[indexPath.row].userIn = true
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

//MARK: - Search bar delegate

extension SearchGroupsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        self.groups.removeAll()
        
        DispatchQueue.global(qos: .background).async {
            self.networkManager.loadFilteredGroups(filterText: searchText) { (listOfGroups) in
                
                listOfGroups.response?.items?.forEach({ (group) in
                    
                    let id = group.id!
                    let name = group.name!
                    let avatarURL = group.photo200URL!
                    let userIn = (group.isMember != nil) ? group.isMember! : 0
                    
                    let group = Group(id: id, name: name, avatarURL: avatarURL, userIn: userIn != 0)
                    
                    self.groups.append(group)
                })
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.firebaseManager.saveSearchNameGroupsToFirestore(results: searchText)
                }
            }
        }
    }
    
    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        
        self.groups.forEach { [weak self] (group) in
            self?.photoCache.cachedPhotoDictionary.removeValue(forKey: group.avatarURL)
        }

        self.groups.removeAll()
        
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
}
