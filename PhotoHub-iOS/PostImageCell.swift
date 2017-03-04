//
//  PostImageCell.swift
//  PhotoHub
//
//  Created by Igor Camilo on 03/03/17.
//
//

import UIKit
import SnapKit

class PostImageCell: UITableViewCell {
  
  var indexPath: IndexPath?
  let postImageView = UIImageView()
  
  func adjust(for size: CGSize) {
    postImageView.snp.remakeConstraints { (make) in
      make.leading.greaterThanOrEqualToSuperview()
      make.top.equalToSuperview()
      make.bottom.equalToSuperview()
      make.width.equalTo(LayoutConstants.maxWidth).priority(.high)
      make.height.equalTo(postImageView.snp.width).multipliedBy(size.height / size.width).priority(.high)
      make.centerX.equalToSuperview()
    }
  }
  
  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    initialize()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }
  
  private func initialize() {
    addSubview(postImageView)
  }
}
