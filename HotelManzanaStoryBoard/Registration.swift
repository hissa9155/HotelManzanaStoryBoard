//
//  Registration.swift
//  HotelManzana
//
//  Created by H.Namikawa on 2023/05/07.
//

import Foundation

struct Registration: Codable {
  var firstName: String
  var lastName: String
  var emailAddress: String
  
  var checkInDate: Date
  var checkOutDate: Date
  var numberOfAdults: Int
  var numberOfChildren: Int
  
  var roomType: RoomType
  var wifi: Bool
}
