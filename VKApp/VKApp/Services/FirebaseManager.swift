//
//  FirebaseManager.swift
//  VKApp
//
//  Created by User on 14.04.2021.
//

import Foundation
import FirebaseFirestore

final class FirebaseManager {
    static let shared = FirebaseManager()
    
    private init() {
        
    }
    
    func saveLoginDateToFirestore() {
        let database = Firestore.firestore()
        let settings = database.settings
        database.settings = settings
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        let dateString = dateFormatter.string(from: Date())
        
        let dataToSend: [String : Any] = ["User" : dateString]
        
        database.collection("UserLogins").document("Login").setData(dataToSend, merge: false) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("data saved")
            }
        }
    }
    
    func saveSearchNameGroupsToFirestore(results: String) {
        let database = Firestore.firestore()
        let settings = database.settings
        database.settings = settings
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        let dateString = dateFormatter.string(from: Date())
        
        let dataToSend: [String : Any] = [dateString : results]
        
        database.collection("SearchGroupsResults").document("SearchText").setData(dataToSend, merge: false) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("data saved")
            }
        }
    }
    
}
