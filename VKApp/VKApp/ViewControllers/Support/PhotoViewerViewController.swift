//
//  PhotoViewerViewController.swift
//  VKApp
//
//  Created by User on 20.02.2021.
//

import UIKit

class PhotoViewerViewController: UIViewController, SetOfImagesDelegate {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var headTextLabel: UILabel!
    var imagesArray: [UIImage] = []
    var coordinatesArray: [(Int, Int, Int, Int)] = []
    var numberOfCurrentPresentedPhoto: Int = 0
    
    func passedSetOfCoordinates(_ coordinates: [(Int, Int, Int, Int)]) {
        self.coordinatesArray = coordinates
    }

    func passedSetOfImages(_ images: [UIImage]) {
        imagesArray = images
        activatePhoto()
    }
    
    func passedNumberOfPickedImage(_ number: Int) {
        numberOfCurrentPresentedPhoto = number
        activatePhoto()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureRecognezers()
    }
    
    @IBAction func pushBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func activatePhoto() {
        if imagesArray.count != 0 {
            photoImageView.image = imagesArray[numberOfCurrentPresentedPhoto]
            headTextLabel.text = "Фото \(numberOfCurrentPresentedPhoto + 1) из \(imagesArray.count)"
        }
    }
    
    //MARK: - Working with gestures
    
    func addGestureRecognezers() {
        let photoTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handlePhotoTap))
        photoTapGestureRecognizer.numberOfTapsRequired = 1
        photoTapGestureRecognizer.numberOfTouchesRequired = 1
        photoImageView.isUserInteractionEnabled = true
        photoImageView.addGestureRecognizer(photoTapGestureRecognizer)
        
        let photoLeftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handlePhotoSwipeLeft))
        photoLeftSwipeGestureRecognizer.direction = .left
        photoImageView.addGestureRecognizer(photoLeftSwipeGestureRecognizer)
        
        
        let photoRightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handlePhotoSwipeRight))
        photoRightSwipeGestureRecognizer.direction = .right
        photoImageView.addGestureRecognizer(photoRightSwipeGestureRecognizer)
        
        let photoDownSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handlePhotoSwipeDown(_:)))
        photoDownSwipeGestureRecognizer.direction = .down
        photoImageView.addGestureRecognizer(photoDownSwipeGestureRecognizer)
        
        
    }
    
    @objc func handlePhotoTap (_ sender: UITapGestureRecognizer) {
        let leftBorder = CGFloat(Double(photoImageView.frame.width) / 3)
        let rightBorder = CGFloat(Double(photoImageView.frame.width) / 3 * 2)
    
        let touchPoint = sender.location(in: self.view)
        
        if touchPoint.x < leftBorder {
            if numberOfCurrentPresentedPhoto != 0 {
                numberOfCurrentPresentedPhoto -= 1
                photoImageView.image = imagesArray[numberOfCurrentPresentedPhoto]
            }
        }
        
        if touchPoint.x > rightBorder {
            if numberOfCurrentPresentedPhoto < imagesArray.count - 1 {
                numberOfCurrentPresentedPhoto += 1
                photoImageView.image = imagesArray[numberOfCurrentPresentedPhoto]
            }
            
        }
        
        headTextLabel.text = "Фото \(numberOfCurrentPresentedPhoto + 1) из \(imagesArray.count)"
        updatePhotoCoordinates()
    }
    
    @objc func handlePhotoSwipeLeft (_ sender: UIPanGestureRecognizer) {
        if numberOfCurrentPresentedPhoto < imagesArray.count - 1 {
            numberOfCurrentPresentedPhoto += 1
            animatedNextPhoto()
        }
        updatePhotoCoordinates()
    }
    
    @objc func handlePhotoSwipeRight (_ sender: UISwipeGestureRecognizer) {
        if numberOfCurrentPresentedPhoto != 0 {
            numberOfCurrentPresentedPhoto -= 1
            animatedPreviousPhoto()
        }
        
        headTextLabel.text = "Фото \(numberOfCurrentPresentedPhoto + 1) из \(imagesArray.count)"
        updatePhotoCoordinates()
    }
    
    @objc func handlePhotoSwipeDown (_ sender: UISwipeGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func animatedNextPhoto () {
        
        let newImage = UIImageView()
        newImage.image = imagesArray[numberOfCurrentPresentedPhoto]
        newImage.frame = CGRect(x: photoImageView.frame.width, y: photoImageView.frame.origin.y, width: photoImageView.frame.width, height: photoImageView.frame.height)
        newImage.contentMode = .scaleAspectFit
        
        self.view.addSubview(newImage)
        
        self.headTextLabel.text = "Фото \(self.numberOfCurrentPresentedPhoto + 1) из \(self.imagesArray.count)"
        
        UIView.animateKeyframes(withDuration: 0.5,
                                delay: 0,
                                options: [],
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: { [self] in
                                        self.photoImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                                        self.photoImageView.alpha = 0
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: { [self] in
                                        newImage.center.x = photoImageView.center.x
                                    })
                                },
                                completion: {_ in
                                    self.photoImageView.image = self.imagesArray[self.numberOfCurrentPresentedPhoto]
                                    self.photoImageView.alpha = 1
                                    self.photoImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                                    newImage.removeFromSuperview()
                                })
        updatePhotoCoordinates()
    }
    
    func animatedPreviousPhoto () {
        let newImage = UIImageView()
        newImage.image = imagesArray[numberOfCurrentPresentedPhoto]
        newImage.frame = CGRect(x: photoImageView.frame.origin.x, y: photoImageView.frame.origin.y, width: photoImageView.frame.width, height: photoImageView.frame.height)
        newImage.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        newImage.contentMode = .scaleAspectFit
        
        self.view.addSubview(newImage)
        
        self.headTextLabel.text = "Фото \(self.numberOfCurrentPresentedPhoto + 1) из \(self.imagesArray.count)"
        
        UIView.animateKeyframes(withDuration: 0.5,
                                delay: 0,
                                options: [],
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: { [self] in
                                        self.photoImageView.center.x -= photoImageView.frame.width
                                        self.photoImageView.alpha = 0
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
                                        newImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                                    })
                                },
                                completion: {_ in
                                    self.photoImageView.image = self.imagesArray[self.numberOfCurrentPresentedPhoto]
                                    self.photoImageView.alpha = 1
                                    self.photoImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                                    newImage.removeFromSuperview()
                                })
        updatePhotoCoordinates()
    }
    
    func updatePhotoCoordinates() {
        guard let transitionDelegate = self.transitioningDelegate as? ViewControllerTransitionDelegate else { return }
        
        if numberOfCurrentPresentedPhoto < coordinatesArray.count {
            transitionDelegate.updatePhotoParameters(photoXPosition: coordinatesArray[numberOfCurrentPresentedPhoto].0, photoYPosition: coordinatesArray[numberOfCurrentPresentedPhoto].1, photoHeight: coordinatesArray[numberOfCurrentPresentedPhoto].2, photoWidth: coordinatesArray[numberOfCurrentPresentedPhoto].3)
        }
    }

}


extension PhotoViewerViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

protocol SetOfImagesDelegate {
    func passedSetOfImages (_ images: [UIImage])
    func passedSetOfCoordinates(_ coordinates: [(Int, Int, Int, Int)])
    func passedNumberOfPickedImage (_ number: Int)
}
