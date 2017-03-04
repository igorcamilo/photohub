//
//  URL+secure.swift
//  PhotoHub
//
//  Created by Igor Camilo on 03/03/17.
//
//

extension URL {
  var secured: URL {
    guard scheme == "http" else {
      return self
    }
    var components = URLComponents(url: self, resolvingAgainstBaseURL: true)!
    components.scheme = "https"
    return components.url!
  }
}
