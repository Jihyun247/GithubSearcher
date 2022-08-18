//
//  SearchView.swift
//  GithubSearcher
//
//  Created by 김지현 on 2022/08/18.
//

import UIKit
import SnapKit

class SearchView: UIView {

  enum Size {

  }

<<<<<<< HEAD
  let repoSearchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.returnKeyType = .done
    return searchBar
  }()
  let repoTableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .white
    tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: RepoTableViewCell.identifier)
    return tableView
  }()

=======
>>>>>>> 90f751b... :tada: 라이브러리 import 및 Screen 파일
  override init(frame: CGRect) {
    super.init(frame: frame)
    render()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func render() {

<<<<<<< HEAD
    self.addSubview(repoSearchBar)
    self.addSubview(repoTableView)

    repoSearchBar.snp.makeConstraints { make in
      make.top.equalTo(safeAreaLayoutGuide)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(50)
    }

    repoTableView.snp.makeConstraints { make in
      make.top.equalTo(repoSearchBar.snp.bottom)
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(safeAreaLayoutGuide)
    }

=======
>>>>>>> 90f751b... :tada: 라이브러리 import 및 Screen 파일
  }
}

