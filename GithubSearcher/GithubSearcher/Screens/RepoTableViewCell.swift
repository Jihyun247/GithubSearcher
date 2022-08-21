//
//  RepoTableViewCell.swift
//  GithubSearcher
//
//  Created by 김지현 on 2022/08/18.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

  static let identifier = "RepoTableViewCell"

  let repoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .black
    return imageView
  }()

  let repoNameLabel: UILabel = {
    let label = UILabel()
    label.text = "repo name"
    label.textAlignment = .left
    label.font = .systemFont(ofSize: 15, weight: .medium)
    return label
  }()

  let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "description name"
    label.textAlignment = .left
    label.font = .systemFont(ofSize: 13, weight: .regular)
    return label
  }()

  let starIconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "star.fill")
    return imageView
  }()

  let starCountLabel: UILabel = {
    let label = UILabel()
    label.text = "15"
    label.textAlignment = .left
    label.font = .systemFont(ofSize: 12, weight: .regular)
    return label
  }()

  let issueIconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "exclamationmark.circle")
    return imageView
  }()

  let issueCountLabel: UILabel = {
    let label = UILabel()
    label.text = "24"
    label.textAlignment = .left
    label.font = .systemFont(ofSize: 12, weight: .regular)
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


}

