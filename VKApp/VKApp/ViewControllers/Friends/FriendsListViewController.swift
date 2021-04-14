//
//  FriendsListTableViewController.swift
//  VKApp
//
//  Created by User on 01.02.2021.
//

import UIKit
import Foundation
import RealmSwift

enum TypeOfPresentation {
    case showAll
    case showFiltered
}

class FriendsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var alphabetFrindsSearch: AlphabetFriendsSearch!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presentedListOfFriends: [[User]] = [[]]
    var presentedSectionsNames: [Character] = []
    
    var delegate: PassFriendInforamtionDelegate?
    
    let networkManager = Session.shared
    let photoCache = PhotoCache.shared
    let realmManager = RealmManager.shared
    let firebaseManager = FirebaseManager.shared
    
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareListOfFriendsToPresent(typeOfPresentation: .showAll)
        
        tableView.register(UINib(nibName: "FriendsTableViewCell", bundle: nil), forCellReuseIdentifier: "friendsReuseIdentifier")
        
        tableView.register(UINib(nibName: "FriendsUITableViewHeaderFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "friendsListHeader")
        
        alphabetFrindsSearch.addTarget(self, action: #selector(changeActiveSections), for: .valueChanged)
        
        firebaseManager.saveLoginDateToFirestore()
   
    }
    
    deinit {
        self.token?.invalidate()
    }
    
    //MARK: - Private functions
    
    @objc func changeActiveSections () {
        
        var index = 0
        
        for element in presentedSectionsNames {
            if element == self.alphabetFrindsSearch.selectedChar {
                break
            }
            index += 1
        }
        
        if index > presentedSectionsNames.count - 1 {
            index = presentedSectionsNames.count - 1
        }
        
        let indexPath = IndexPath(row: 0, section: index)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func loadListOfFriendsFromNetwork () {
        
        var friends: [User] = []
            
        self.networkManager.loadUserFriends { [weak self] (friendsList) in
            friendsList.response?.items!.forEach({ (friend) in
                friends.append(User(id: friend.id!, name: friend.firstName!, surname: friend.lastName!, avatarURL: friend.photoURL!))
            })

            DispatchQueue.main.async {
                try? self?.realmManager?.add(objects: friends)
                
                self?.prepareListOfFriendsToPresent(typeOfPresentation: .showAll)
            }
        }
    }
    
    private func prepareListOfFriendsToPresent(typeOfPresentation: TypeOfPresentation, searchText: String = "") {
        
        presentedListOfFriends.removeAll()
        presentedSectionsNames.removeAll()
        
        var sectionsFriendsArray: [User] = []
        var nameContainsSearchText: Bool = false
        var surnameContainsSearchText: Bool = false
        var friends: [User] = []
        
        let friendsRealm: Results<User>? = realmManager?.getObjects()
        
        subscribeForFriendsRealmUpdate(friends: friendsRealm)
        
        friendsRealm!.forEach { (user) in
            friends.append(user)
        }

        let sortedFriends = sortFriendsArray(friendsList: friends)
        
        (0..<alphabetArray.count).forEach { charIndex in
            (0..<sortedFriends.count).forEach { friendIndex in
                
                switch typeOfPresentation {
                case .showFiltered:
                    nameContainsSearchText = sortedFriends[friendIndex].name.contains(searchText)
                    surnameContainsSearchText = sortedFriends[friendIndex].surname.contains(searchText)
                case .showAll:
                    nameContainsSearchText = true
                    surnameContainsSearchText = true
                }
                
                let firstCharOfSurname: Character = sortedFriends[friendIndex].surname.first ?? "!"
                
                if firstCharOfSurname == alphabetArray[charIndex] && (nameContainsSearchText || surnameContainsSearchText) {
                    sectionsFriendsArray.append(sortedFriends[friendIndex])
                }
            }
            
            if sectionsFriendsArray.count != 0 {
                presentedListOfFriends.append(sectionsFriendsArray)
                presentedSectionsNames.append(alphabetArray[charIndex])
                sectionsFriendsArray.removeAll()
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func sortFriendsArray (friendsList: [User]) -> [User] {
        let newArray = friendsList.sorted(by: { $0.surname < $1.surname })
        
        return newArray
    }
    
    func subscribeForFriendsRealmUpdate(friends: Results<User>?) {
        self.token = friends?.observe({ [self] (changes) in
            switch changes {
            case .initial(let friends):
                print("Initial list: \(friends)")
            case .update(let friends, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                
                self.tableView.beginUpdates()
                
                var deletionsIndexPath: [IndexPath] = []
                var insertionsIndexPath: [IndexPath] = []
                var modificationsIndexPath: [IndexPath] = []
                
                for section in 0..<self.presentedListOfFriends.count {
                    for row in 0..<self.presentedListOfFriends[section].count {
                        deletions.forEach { (friendIndex) in
                            if friends[friendIndex].id == presentedListOfFriends[section][row].id {
                                deletionsIndexPath.append(IndexPath(row: section, section: row))
                            }
                        }
                        
                        insertions.forEach { (friendIndex) in
                            if friends[friendIndex].id == presentedListOfFriends[section][row].id {
                                insertionsIndexPath.append(IndexPath(row: section, section: row))
                            }
                        }
                        
                        modifications.forEach { (friendIndex) in
                            if friends[friendIndex].id == presentedListOfFriends[section][row].id {
                                modificationsIndexPath.append(IndexPath(row: section, section: row))
                            }
                        }
                    }
                }
                
                self.tableView.deleteRows(at: deletionsIndexPath, with: .automatic)
                self.tableView.insertRows(at: insertionsIndexPath, with: .automatic)
                self.tableView.reloadRows(at: modificationsIndexPath, with: .automatic)
                
                self.tableView.endUpdates()
                
            case .error(let error):
                print(error.localizedDescription)
            }
        })
    }

}

// MARK: - Table view Data source and Delegate

extension FriendsListViewController: UITableViewDataSource, UITableViewDelegate {
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return presentedListOfFriends.count
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presentedListOfFriends[section].count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsReuseIdentifier", for: indexPath) as! FriendsTableViewCell
        
        cell.userName.text = presentedListOfFriends[indexPath.section][indexPath.row].name + " " + presentedListOfFriends[indexPath.section][indexPath.row].surname
        
        let image = photoCache.cachedPhotoDictionary[presentedListOfFriends[indexPath.section][indexPath.row].avatarURL]
        
        if image != nil {
            cell.userAvatarView.avatarImage.image = image
        } else {
            cell.userAvatarView.avatarImage.image = UIImage(named: "defaultUserAvatar")
        }
            
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "FriendsCollectionView") as FriendsPhotosViewController
        vc.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        self.networkManager.getUsersPhoto(ownerID: (self.presentedListOfFriends[indexPath.section][indexPath.row].id)) { (images) in
                vc.userImages = images
                vc.loadingIndicator.isHidden = true
                DispatchQueue.main.async {
                    vc.photosCollectionView.reloadData()
                }
            }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate = vc as PassFriendInforamtionDelegate
        
        delegate?.passedFriendData(presentedListOfFriends[indexPath.section][indexPath.row])
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "friendsListHeader") as! FriendsUITableViewHeaderFooterView
        
        let surnameChar = presentedListOfFriends[section][0].surname.first
        
        view.headerTextLabel.text = String(surnameChar!)
        
        view.layer.backgroundColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "friendsListHeader") as! FriendsUITableViewHeaderFooterView
        
        return view.layer.frame.height
    }

}

extension FriendsListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        prepareListOfFriendsToPresent(typeOfPresentation: .showFiltered, searchText: searchText)
               
        self.tableView.reloadData()
    }
    
    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        prepareListOfFriendsToPresent(typeOfPresentation: .showAll)
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
}
