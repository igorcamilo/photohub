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
  
  public var rawContent: String
  public var images: [WebImage]
  public var upVotes: Int
  public var createdAt: Date
  public var id: String
  public var createdBy: User
  
  public static func getList(forumId: String, completionHandler: @escaping (Result<[Post]>) -> Void) {
    
    request(Router.posts(forumId: forumId)).responseData { (dataResponse) in
      
      do {
        if let error = dataResponse.error {
          throw error
        }
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
    images = try object.value(for: "entities.images")
    upVotes = try object.value(for: "stats.upVotes")
    createdAt = Date(milisecondsSince1970: try object.value(for: "timestamp"))
    id = try object.value(for: "id")
    createdBy = try object.value(for: "createdBy")
  }
}
