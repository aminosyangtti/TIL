//
//  UsersViewModel.swift
//  UsersViewModel
//
//  Created by Vincio on 9/8/21.
//

import Foundation


import Foundation
import Firebase

class UsersViewModel: ObservableObject {

    @Published var users = [User]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser

    init() {
        fetchData()
    }

    func fetchData() {
            db.collection("users").addSnapshotListener({(snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("no docs")
                    return
                }

                self.users = documents.map({docSnapshot -> User in
                    let data = docSnapshot.data()
                    let uid = data["uid"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let token = data["token"] as? String ?? ""

                    return User(uid: uid, token: token, email: email, username: username)

                })
            })
    }

    func addUser(email: String, uid: String, username: String, handler: @escaping () -> Void) {

            db.collection("users").addDocument(data:
                                                        [
                                                            "uid": uid,
                                                            "email": email,
                                                            "username": username.lowercased()

                                                            ]) { err in
                if let err = err {
                    print(err)

                } else {
                    handler()

                }

            }


    }

    func updateUser(username: String, handler: @escaping () -> Void) {
        if user != nil {
            db.collection("users").whereField("uid", isEqualTo: user!.uid)
                .getDocuments() { (snapshot, error)  in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    for document in snapshot!.documents {

                        self.db.collection("users").document(document.documentID).updateData([
                            "username": username.lowercased()
                        ])


                    }
                }
            }
        }
    }

    func updateToken(token: String, handler: @escaping () -> Void) {
        if user != nil {
            db.collection("users").whereField("uid", isEqualTo: user!.uid)
                .getDocuments() { (snapshot, error)  in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    for document in snapshot!.documents {
                        print(token)

                        self.db.collection("users").document(document.documentID).updateData([
                            "token": token
                        ])



                    }
                }
            }
        }
    }


}
