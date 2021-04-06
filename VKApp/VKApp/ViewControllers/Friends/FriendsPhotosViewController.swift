//
//  FriendsCollectionViewController.swift
//  VKApp
//
//  Created by User on 01.02.2021.
//

import UIKit


class FriendsPhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,  PassFriendInforamtionDelegate {
    
    @IBOutlet var photosCollectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var transitionDelegate = ViewControllerTransitionDelegate()
    var friend: User!
    var delegate: SetOfImagesDelegate!
    var coordinatesArray: [(Int, Int, Int, Int)] = []
    var userImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photosCollectionView.register(UINib(nibName: "FriendsPhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "friendPhotoReusableCell")
        
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        
        coordinatesArray.removeAll()

    }
    
    func passedFriendData(_ friendPassed: User) {
        friend = friendPassed
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return userImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendPhotoReusableCell", for: indexPath) as! FriendsPhotosCollectionViewCell
        
        cell.friendImage.image = userImages[indexPath.row]
        
        let attributes = collectionView.layoutAttributesForItem(at: indexPath)
        coordinatesArray.append((Int(attributes?.frame.origin.x ?? 0), Int(attributes?.frame.origin.y ?? 0), Int(attributes?.frame.height ?? 0), Int(attributes?.frame.width ?? 0)))
    
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: "imageViewer")
        viewcontroller.modalPresentationStyle = .fullScreen
        
        viewcontroller.transitioningDelegate = transitionDelegate
        
        let attributes = collectionView.layoutAttributesForItem(at: indexPath)

        transitionDelegate.photoXPosition = Int(attributes?.frame.origin.x ?? 0)
        transitionDelegate.photoYPosition = Int(attributes?.frame.origin.y ?? 0)
        transitionDelegate.photoHeight = Int(attributes?.frame.height ?? 0)
        transitionDelegate.photoWidth = Int(attributes?.frame.width ?? 0)

        self.present(viewcontroller, animated: true, completion: nil)
        
        self.delegate = viewcontroller as? SetOfImagesDelegate
        
        delegate?.passedSetOfImages(userImages)
        delegate?.passedNumberOfPickedImage(indexPath.row)
        delegate?.passedSetOfCoordinates(coordinatesArray)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: ((collectionView.frame.width - 15) / 2), height: 200)
    }
    
}

protocol PassFriendInforamtionDelegate {
    func passedFriendData (_ friendPassed: User)
}
