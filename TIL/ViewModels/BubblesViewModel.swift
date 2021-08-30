//
//  BubblesViewModel.swift
//  BubblesViewModel
//
//  Created by Vincio on 8/31/21.
//

import Foundation
import Firebase

class BreakoutRoomsViewModel: ObservableObject {
    @Published var bubbles = [Bubble]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser

    init() {
        fetchData()
    }

    func fetchData() {
        db.collection("bubbles").addSnapshotListener({(snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("no docs")
                return
            }

            self.bubbles = documents.map({docSnapshot -> Bubble in
                let data = docSnapshot.data()
                let docId = docSnapshot.documentID
                let text = data["text"] as? String ?? ""
                let likedBy = data["likedBy"] as? [String] ?? [""]
                let likes = data ["likes"] as? Int ?? 0
                return Bubble(id: docId, text: text, likedBy: likedBy)

            })
        })
    }

    func createBubble(text: String, handler: @escaping () -> Void) {

        db.collection("bubbles").addDocument(data:
                                                    [
                                                        "text": text,
                                                        "likes": 0,
                                                        ]) { err in
            if let err = err {
                print(err)

            } else {
                handler()

            }

        }

    }

    func likeBubble(text: String, handler: @escaping () -> Void) {
        if user != nil {
            db.collection("bubbles").whereField("text", isEqualTo: text).getDocuments() { (snapshot, error)  in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    for document in snapshot!.documents {

                        self.db.collection("bubbles").document(document.documentID).updateData([
                            "likedBy": FieldValue.arrayUnion([self.user!.uid]),
                            "likes": FieldValue.increment(Int64(1))
                        ])


                    }
                }
            }
        }
    }

    func unlikeBubble(text: String, handler: @escaping () -> Void) {
        if user != nil {
            db.collection("bubbles").whereField("text", isEqualTo: text).getDocuments() { (snapshot, error)  in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    for document in snapshot!.documents {

                        self.db.collection("bubbles").document(document.documentID).updateData([
                            "likedBy": FieldValue.arrayRemove([self.user!.uid]),
                            "likes": FieldValue.increment(Int64(-1))
                        ])


                    }
                }
            }
        }
    }
}
