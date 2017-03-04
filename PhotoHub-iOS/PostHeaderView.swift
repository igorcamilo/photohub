//
//  PostHeaderView.swift
//  PhotoHub
//
//  Created by Igor Camilo on 03/03/17.
//
//

import UIKit
import SnapKit

/// Presents information about posts, except post images.
class PostHeaderView: UITableViewHeaderFooterView {
  
  let avatarView = UIImageView()
  let userDisplayNameLabel = UILabel()
  let dateLabel = UILabel()
  let upVotesLabel = UILabel()
  let contentLabel = UILabel()
  
  // MARK: - Initialization
  
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
    addSubview(wrapper)
    wrapper.snp.makeConstraints { (make) in
      make.leading.greaterThanOrEqualToSuperview()
      make.top.equalToSuperview()
      make.bottom.equalToSuperview()
      make.width.equalTo(LayoutConstants.maxWidth).priority(999)
      make.centerX.equalToSuperview()
    }
    
    let topContainer = UIView()
    wrapper.addSubview(topContainer)
    topContainer.snp.makeConstraints { (make) in
      make.top.equalToSuperview().inset(LayoutConstants.bigMargin)
      make.leading.equalToSuperview().inset(LayoutConstants.bigMargin)
      make.trailing.equalToSuperview().inset(LayoutConstants.bigMargin)
    }
    
    avatarView.contentMode = .scaleAspectFill
    avatarView.clipsToBounds = true
    topContainer.addSubview(avatarView)
    avatarView.snp.makeConstraints { (make) in
      make.leading.equalToSuperview()
      make.top.equalToSuperview()
      make.bottom.lessThanOrEqualToSuperview()
      make.size.equalTo(CGSize(width: 48, height: 48)).priority(999)
    }
    
    userDisplayNameLabel.text = "Display name"
    userDisplayNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    topContainer.addSubview(userDisplayNameLabel)
    userDisplayNameLabel.snp.makeConstraints { (make) in
      make.leading.equalTo(avatarView.snp.trailing).offset(LayoutConstants.smallMargin)
      make.top.equalToSuperview()
    }
    
    dateLabel.text = "Date"
    dateLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
    topContainer.addSubview(dateLabel)
    dateLabel.snp.makeConstraints { (make) in
      make.leading.equalTo(avatarView.snp.trailing).offset(LayoutConstants.smallMargin)
      make.top.equalTo(userDisplayNameLabel.snp.bottom)
      make.bottom.greaterThanOrEqualToSuperview()
    }
    
    let upVotesIconLabel = UILabel()
    upVotesIconLabel.text = "🔼"
    upVotesIconLabel.font = UIFont.preferredFont(forTextStyle: .body)
    topContainer.addSubview(upVotesIconLabel)
    upVotesIconLabel.snp.makeConstraints { (make) in
      make.trailing.equalToSuperview()
      make.centerY.equalToSuperview()
    }
    
    upVotesLabel.text = "0"
    upVotesLabel.font = UIFont.preferredFont(forTextStyle: .body)
    topContainer.addSubview(upVotesLabel)
    upVotesLabel.snp.makeConstraints { (make) in
      make.trailing.equalTo(upVotesIconLabel.snp.leading)
      make.leading.greaterThanOrEqualTo(userDisplayNameLabel.snp.trailing).offset(LayoutConstants.bigMargin)
      make.leading.greaterThanOrEqualTo(dateLabel.snp.trailing).offset(LayoutConstants.bigMargin)
      make.centerY.equalToSuperview()
    }
    
    contentLabel.text = "Content"
    contentLabel.font = UIFont.preferredFont(forTextStyle: .body)
    contentLabel.numberOfLines = 0
    wrapper.addSubview(contentLabel)
    contentLabel.snp.makeConstraints { (make) in
      make.top.equalTo(topContainer.snp.bottom).offset(LayoutConstants.smallMargin)
      make.leading.equalToSuperview().inset(LayoutConstants.bigMargin)
      make.trailing.equalToSuperview().inset(LayoutConstants.bigMargin)
      make.bottom.equalToSuperview().inset(LayoutConstants.bigMargin)
    }
  }
}
