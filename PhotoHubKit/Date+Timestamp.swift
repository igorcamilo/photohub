//
//  Date+Timestamp.swift
//  PhotoHub
//
//  Created by Igor Camilo on 03/03/17.
//
//

extension Date {
  init(milisecondsSince1970: Double) {
    self.init(timeIntervalSince1970: milisecondsSince1970 / 1000)
  }
}
