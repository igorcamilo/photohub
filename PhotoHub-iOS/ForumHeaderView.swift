//
//  ForumHeaderView.swift
//  PhotoHub
//
//  Created by Igor Camilo on 03/03/17.
//
//

import UIKit
import SnapKit

class ForumHeaderView: UIView {
  
  let headerView = UIImageView()
  let avatarView = UIImageView()
  
  
  override init(frame: CGRect = .zero) {
    super.init(frame: frame)
    initialize()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }
  
  private func initialize() {
    
    backgroundColor = .yellow
    
    let wrapper = UIView()
    wrapper.backgroundColor = .green
    addSubview(wrapper)
    wrapper.snp.makeConstraints { (make) in
      make.leading.greaterThanOrEqualToSuperview()
      make.top.equalToSuperview()
      make.bottom.equalToSuperview()
      make.width.equalTo(LayoutConstants.maxWidth).priority(.high)
      make.centerX.equalToSuperview()
    }
    
    headerView.backgroundColor = .blue
    wrapper.addSubview(headerView)
    headerView.snp.makeConstraints { (make) in
      make.top.equalToSuperview()
      make.left.equalToSuperview()
      make.right.equalToSuperview()
      make.bottom.equalToSuperview().inset(32)
    }
    
    avatarView.backgroundColor = .red
    wrapper.addSubview(avatarView)
    avatarView.snp.makeConstraints { (make) in
      make.size.equalTo(CGSize(width: 64, height: 64))
      make.left.equalToSuperview().inset(10)
      make.bottom.equalToSuperview()
    }
  }
}
