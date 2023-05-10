//
//  RoomType.swift
//  HotelManzana
//
//  Created by H.Namikawa on 2023/05/07.
//

import Foundation

struct RoomType: Equatable, Codable {
  var id: Int
  var name: String
  var shortName: String
  var price: Int
  
  static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.id == rhs.id
  }
  
  static var all: [RoomType] {
    return [RoomType(id: 0, name: "Two Queens",
                     shortName: "2Q", price: 179),
            RoomType(id: 1, name: "One King",
                     shortName: "K", price: 209),
            RoomType(id: 2, name: "Penthouse Suite",
                     shortName: "PHS", price: 309)]
    
  }
}
