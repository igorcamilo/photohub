//
//  PostsViewModel.swift
//  PhotoHub
//
//  Created by Igor Camilo on 03/03/17.
//
//

import Alamofire
import PhotoHubKit

class PostsViewModel {
  
  private var forumModel: Forum?
  private var postsModel: [Post]? {
    didSet {
      let formatter = DateFormatter()
      formatter.dateStyle = .full
      formatter.timeStyle = .full
      formatter.doesRelativeDateFormatting = true
      postsDateCache = postsModel?.map({ formatter.string(from: $0.createdAt) })
    }
  }
  private var postsDateCache: [String]?
  
  private(set) var busy = false
  
  var forumHeader: (slug: String, title: String, description: String, headerImageURL: URL, imageURL: URL)? {
    guard let forum = forumModel else {
      return nil
    }
    return (forum.slug, forum.title, forum.description, forum.headerImageURL, forum.imageURL)
  }
  
  var numberOfPosts: Int {
    return postsModel?.count ?? 0
  }
  
  func postHeader(section: Int) -> (userDisplayName: String, userAvatarURL: URL, text: String)? {
    guard let post = postsModel?[section] else {
      return nil
    }
    return (post.createdBy.displayName, post.createdBy.avatarURL, post.rawContent)
  }
  
  func numberOfImages(section: Int) -> Int {
    return postsModel?[section].images.count ?? 0
  }
  
  func image(indexPath: IndexPath, completionHandler: @escaping (Result<UIImage>) -> Void) -> CGSize? {
    guard let webImage = postsModel?[indexPath.section].images[indexPath.row] else {
      completionHandler(.failure(Error.noItem))
      return nil
    }
    request(webImage.url).responseData { (dataResponse) in
      do {
        if let error = dataResponse.error {
          throw error
        }
        guard let data = dataResponse.data else {
          throw NetworkError.noData
        }
        guard let image = UIImage(data: data) else {
          throw Error.invalidData
        }
        completionHandler(.success(image))
        
      } catch {
        completionHandler(.failure(error))
      }
    }
    return webImage.size
  }
  
  func update(completionHandler: @escaping (Result<Void>) -> Void) {
    
    guard busy == false else {
      completionHandler(.failure(Error.busy))
      return
    }
    busy = true
    
    Forum.get(id: "photography") { [weak self] (result) in
      
      switch result {
      case .success(let newForum):
        
        Post.getList(forumId: "photography") { [weak self] (result) in
          
          switch result {
          case .success(let newPosts):
            
            self?.forumModel = newForum
            self?.postsModel = newPosts
            completionHandler(.success())
            
          case .failure(let error):
            completionHandler(.failure(error))
          }
          
          self?.busy = false
        }
        
      case .failure(let error):
        completionHandler(.failure(error))
        self?.busy = false
      }
    }
  }
  
  enum Error: Swift.Error {
    case busy
    case noItem
    case invalidData
  }
}
