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
      formatter.dateStyle = .short
      formatter.timeStyle = .short
      formatter.doesRelativeDateFormatting = true
      postsDateCache = postsModel?.map({ formatter.string(from: $0.createdAt) })
    }
  }
  /// Cache for string representations of post dates.
  private var postsDateCache: [String]?
  /// Network request in progress.
  private(set) var isBusy = false
  
  /// Returns information about the current forum.
  var forumHeader: (slug: String, title: String, description: String, headerImageURL: URL, imageURL: URL)? {
    guard let forum = forumModel else {
      return nil
    }
    return (forum.slug, forum.title, forum.description, forum.headerImageURL, forum.imageURL)
  }
  
  var numberOfPosts: Int {
    return postsModel?.count ?? 0
  }
  
  /// Returns information about the post, excluding post images.
  func postHeader(section: Int) -> (userDisplayName: String, userAvatarURL: URL, text: String, date: String, upVotes: String)? {
    guard let post = postsModel?[section] else {
      return nil
    }
    return (post.createdBy.displayName, post.createdBy.avatarURL, post.rawContent, postsDateCache![section], "\(post.upVotes)")
  }
  
  func numberOfImages(section: Int) -> Int {
    return postsModel?[section].images.count ?? 0
  }
  
  /// Returns information about each image of the post.
  func image(indexPath: IndexPath) -> (size: CGSize?, url: URL)? {
    guard let webImage = postsModel?[indexPath.section].images[indexPath.row] else {
      return nil
    }
    return (webImage.size, webImage.url)
  }
  
  /// Requests an updated versioon of Photography's forum and posts.
  func update(completionHandler: @escaping (Result<Void>) -> Void) {
    
    guard isBusy == false else {
      completionHandler(.failure(Error.busy))
      return
    }
    isBusy = true
    
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
          
          self?.isBusy = false
        }
        
      case .failure(let error):
        completionHandler(.failure(error))
        self?.isBusy = false
      }
    }
  }
  
  enum Error: Swift.Error {
    case busy
  }
}
