//
//  BubblesViewModel.swift
//  BubblesViewModel
//
//  Created by Vincio on 8/31/21.


import Foundation
import Firebase

class BubblesViewModel: ObservableObject {
    @Published var bubbles = [Bubble]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser


    func fetchData() {
        if user != nil {
        db.collection("bubbles").order(by: "timeStamp", descending: true).addSnapshotListener({(snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("no docs")
                return
            }

            self.bubbles = documents.map({docSnapshot -> Bubble in
                let data = docSnapshot.data()
                let docId = docSnapshot.documentID
                let text = data["text"] as? String ?? ""
                let likedBy = data["likedBy"] as? [String] ?? [""]
                let likes = data["likes"] as? Int ?? 0
                let createdBy = data["createdBy"] as? String ?? ""
                let timePosted = data["timeStamp"] as? Timestamp ?? nil
                let timeStamp = timePosted!.dateValue()
                return Bubble(id: docId, text: text, likedBy: likedBy, likes: likes, createdBy: createdBy, timeStamp: timeStamp)

            })
        })
        }
    }

    func createBubble(text: String, username: String, handler: @escaping () -> Void) {

        db.collection("bubbles").addDocument(data:
                                                    [
                                                        "text": text,
                                                        "likedBy": FieldValue.arrayUnion([self.user!.uid]),
                                                        "likes": 1,
                                                        "createdBy": username,
                                                        "timeStamp" : Date()
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
