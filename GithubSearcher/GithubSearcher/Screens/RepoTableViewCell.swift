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

    render()
    configUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func render() {
    self.contentView.addSubViews([repoImageView, repoNameLabel, descriptionLabel, starIconImageView, starCountLabel, issueIconImageView, issueCountLabel])

    repoImageView.snp.makeConstraints { make in
      make.top.left.bottom.equalToSuperview().inset(16)
      make.size.equalTo(90)
    }

    repoNameLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(24)
      make.leading.equalTo(repoImageView.snp.trailing).offset(8)
    }
    descriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(repoNameLabel.snp.bottom).offset(4)
      make.leading.equalTo(repoNameLabel.snp.leading)
    }

    starIconImageView.snp.makeConstraints { make in
      make.size.equalTo(15)
      make.leading.equalTo(repoNameLabel.snp.leading)
      make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
    }
    starCountLabel.snp.makeConstraints { make in
      make.leading.equalTo(starIconImageView.snp.trailing).offset(2)
      make.centerY.equalTo(starIconImageView.snp.centerY)
    }

    issueIconImageView.snp.makeConstraints { make in
      make.size.equalTo(15)
      make.leading.equalTo(starCountLabel.snp.trailing).offset(8)
      make.centerY.equalTo(starIconImageView.snp.centerY)
    }
    issueCountLabel.snp.makeConstraints { make in
      make.leading.equalTo(issueIconImageView.snp.trailing).offset(2)
      make.centerY.equalTo(starIconImageView.snp.centerY)
    }
  }

  private func configUI() {
    repoImageView.makeRounded(cornerRadius: 45)
  }
}

