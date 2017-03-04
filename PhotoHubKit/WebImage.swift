//
//  WebImage.swift
//  PhotoHub
//
//  Created by Igor Camilo on 03/03/17.
//
//

import Marshal

public struct WebImage {
  
  public var url: URL
  public var size: CGSize
}

extension WebImage: Unmarshaling {
  
  public init(object: MarshaledObject) throws {
    
    let insecureUrl: URL = try object.value(for: "cdnUrl")
    url = insecureUrl.secured
    size = try CGSize(width: object.value(for: "width") as Int, height: object.value(for: "height") as Int)
  }
}
