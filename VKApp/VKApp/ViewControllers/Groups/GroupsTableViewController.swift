//
//  GroupsTableViewController.swift
//  VKApp
//
//  Created by User on 01.02.2021.
//

import UIKit
import RealmSwift

class GroupsTableViewController: UITableViewController {

    let networkManager = Session.shared
    let photoCache = PhotoCache.shared
    let realmManager = RealmManager.shared
    var userGroups: [Group] = []
    
    var token: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadListOfGroupsFromNetwork()
        updateView()
        
        tableView.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "groupsCell")
    }
    
    deinit {
        self.token?.invalidate()
    }
    
    //MARK: - Private functions
    
    private func loadListOfGroupsFromNetwork () {
        
        let userGroups: [Group] = []
        
        self.networkManager.loadUserGroups { [weak self] (listOfGroups) in
            listOfGroups.response?.items?.forEach({ (groups) in
                let group = Group(id: groups.id!, name: groups.name!, avatarURL: groups.photo200URL!, userIn: (groups.isMember! != 0))
                self?.userGroups.append(group)
            })
            
            DispatchQueue.main.async {
                try? self?.realmManager?.add(objects: userGroups)
            }
        }
    }
    
    func updateView() {
        let userGroups: Results<Group>? = realmManager?.getObjects()
        
        userGroups?.forEach({ (group) in
            self.userGroups.append(group)
        })
        
        self.token = userGroups?.observe({ (changes) in
            switch changes {
            case .initial(let groups):
                print("Initial groups: \(groups)")
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                
                self.tableView.beginUpdates()
                
                let deletionsIndexPath = deletions.map { IndexPath(row: $0, section: 0) }
                let insertionsIndexPath = insertions.map { IndexPath(row: $0, section: 0) }
                let modificationsIndexPath = modifications.map { IndexPath(row: $0, section: 0) }
                
                self.tableView.deleteRows(at: deletionsIndexPath, with: .automatic)
                self.tableView.insertRows(at: insertionsIndexPath, with: .automatic)
                self.tableView.reloadRows(at: modificationsIndexPath, with: .automatic)
                
                self.tableView.endUpdates()
                
            case .error(let error):
                print(error.localizedDescription)
            }
        })
        
        
    }

    @IBAction func searchGroups(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "searchGroups")
        vc.modalPresentationStyle = .fullScreen

        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupsCell", for: indexPath) as! GroupsTableViewCell
        
        cell.groupNameLabel.text = userGroups[indexPath.row].name
        
        let image = photoCache.cachedPhotoDictionary[userGroups[indexPath.row].avatarURL]
        
        if image != nil {
            cell.groupsAvatarView.groupAvatar.image = image
        } else {
            cell.groupsAvatarView.groupAvatar.image = UIImage(named: "defaultGroupAvatar")
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
