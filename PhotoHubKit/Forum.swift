//
//  Forum.swift
//  PhotoHub
//
//  Created by Igor Camilo on 02/03/17.
//
//

import Alamofire
import Marshal

public struct Forum {
  
  var slug: String
  var title: String
  var headerImageURL: URL
  var imageURL: URL
  var id: String
  
  public static func get(id: String, completionHandler: @escaping (Result<Forum>) -> Void) {
    
    request(Router.forum(id: id)).responseData { (dataResponse) in
      
      do {
        guard let data = dataResponse.data else {
          throw NetworkError.noData
        }
        let forumJSON: MarshaledObject = try JSONParser.JSONObjectWithData(data).value(for: "forum")
        completionHandler(.success(try Forum(object: forumJSON)))
        
      } catch {
        completionHandler(.failure(error))
      }
    }
  }
}

extension Forum: Unmarshaling {
  
  public init(object: MarshaledObject) throws {
    
    slug = try object.value(for: "slug")
    title = try object.value(for: "title")
    headerImageURL = try object.value(for: "headerImage.url")
    imageURL = try object.value(for: "image.url")
    id = try object.value(for: "id")
  }
}
