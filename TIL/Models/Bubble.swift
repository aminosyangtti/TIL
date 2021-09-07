//
//  Bubble.swift
//  Bubble
//
//  Created by Vincio on 8/31/21.
//

import Foundation

struct Bubble: Hashable{
    var id: String
    var text: String
    var likedBy: [String]
    var likes: Int
    var createdBy: String
    var timeStamp: Date
}
