//
//  Router.swift
//  PhotoHub
//
//  Created by Igor Camilo on 02/03/17.
//
//

import Alamofire

enum Router: URLRequestConvertible {
  
  static let baseURLString = "https://api.hubchat.com/v1/"
  
  case forum(id: String)
  case posts(forumId: String)
  
  func asURLRequest() throws -> URLRequest {
    
    let url: URL
    
    switch self {
    case .forum(let id):
      url = URL(string: Router.baseURLString + "forum/\(id)")!
    case .posts(let forumId):
      url = URL(string: Router.baseURLString + "forum/\(forumId)/post")!
    }
    
    return URLRequest(url: url)
  }
}
