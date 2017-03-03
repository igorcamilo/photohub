//
//  Post.swift
//  PhotoHub
//
//  Created by Igor Camilo on 02/03/17.
//
//

import Alamofire
import Marshal

public struct Post {
  
  var rawContent: String
  var imageURLs: [URL]
  var upVotes: Int
  var createdAt: Date
  var id: String
  var createdBy: User
  
  public static func getList(forumId: String, completionHandler: @escaping (Result<[Post]>) -> Void) {
    
    request(Router.posts(forumId: forumId)).responseData { (dataResponse) in
      
      do {
        guard let data = dataResponse.data else {
          throw NetworkError.noData
        }
        let postsJSON: [MarshaledObject] = try JSONParser.JSONObjectWithData(data).value(for: "posts")
        completionHandler(.success(try postsJSON.map(Post.init)))
        
      } catch {
        completionHandler(.failure(error))
      }
    }
  }
}

extension Post: Unmarshaling {
  
  public init(object: MarshaledObject) throws {
    
    rawContent = try object.value(for: "rawContent")
    let rawImages: [MarshaledObject] = try object.value(for: "entities.images")
    imageURLs = try rawImages.map { try $0.value(for: "cdnUrl") }
    upVotes = try object.value(for: "stats.upVotes")
    createdAt = Date(milisecondsSince1970: try object.value(for: "timestamp"))
    id = try object.value(for: "id")
    createdBy = try object.value(for: "createdBy")
  }
}
