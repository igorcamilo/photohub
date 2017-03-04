//
//  PostHeaderView.swift
//  PhotoHub
//
//  Created by Igor Camilo on 03/03/17.
//
//

import UIKit
import SnapKit

class PostHeaderView: UITableViewHeaderFooterView {
  
  let avatarView = UIImageView()
  let userDisplayNameLabel = UILabel()
  
  public override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    initialize()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }
  
  private func initialize() {
    
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
    
    avatarView.backgroundColor = .red
    wrapper.addSubview(avatarView)
    avatarView.snp.makeConstraints { (make) in
      make.leading.equalToSuperview().inset(LayoutConstants.bigMargin)
      make.top.equalToSuperview().inset(LayoutConstants.bigMargin)
      make.bottom.equalToSuperview().inset(LayoutConstants.bigMargin)
      make.size.equalTo(CGSize(width: 48, height: 48))
    }
  }
}
