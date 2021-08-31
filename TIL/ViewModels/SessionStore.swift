//
//  SessionStore.swift
//  SessionStore
//
//  Created by Vincio on 8/30/21.
//

//import Foundation
//import Firebase
//
//class SessionStore: ObservableObject {
//    @Published var session: User?
//    @Published var isAnon: Bool = false
//@Published var alertMessage = ""
//@Published var showAlert = false
//    var handle: AuthStateDidChangeListenerHandle?
//    let authRef = Auth.auth()
//
//    func listen() {
//        handle = authRef.addStateDidChangeListener({(auth, user) in
//            if let user = user {
//                self.isAnon = false
//                self.session = User(uid: user.uid, email: user.email!)
//            } else {
//                self.isAnon = true
//                self.session = nil
//            }
//        })
//    }
//
//    func signIn(email: String, password: String) {
//        authRef.signIn(withEmail: email, password: password) { (result, error)  in
//            if error != nil {
//                self.alertMessage = error?.localizedDescription ?? "no error"
//                self.showAlert = true
//
//            } else {
//
//
//            }
//
//        }
//    }
//
//    func signUp(email: String, name: String, password: String) {
//        authRef.createUser(withEmail: email, password: password) { (result, error) in
//            if error != nil {
//                self.alertMessage = error?.localizedDescription ?? "no error"
//                self.showAlert = true
//
//            } else {
//                let user = Auth.auth().currentUser
//
//                UsersViewModel().addUser(email: user!.email!, uid: user!.uid , name: name, handler: {})
//
//            }
//
//        }
//    }
//
//    func signOut() -> Bool {
//        do {
//            try authRef.signOut()
//            self.session = nil
//            self.isAnon = true
//            return true
//        } catch {
//            return false
//        }
//    }
//
//    func unbind() {
//        if let handle = handle {
//            authRef.removeStateDidChangeListener(handle)
//        }
//    }
//
//
//}
