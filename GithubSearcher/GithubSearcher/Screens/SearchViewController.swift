//
//  SearchViewController.swift
//  GithubSearcher
//
//  Created by 김지현 on 2022/08/18.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import SafariServices

final class SearchViewController: UIViewController, View {

  var mainView = SearchView()
  var disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view = mainView
    self.reactor = SearchViewReactor()
  }

  func bind(reactor: SearchViewReactor) {

    // ------ 1. Action 바인딩
    mainView.repoSearchBar.rx.text
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .map { Reactor.Action.updateQuery($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    mainView.repoTableView.rx.contentOffset
      .filter { [weak self] offset in
        guard let `self` = self else { return false }
        guard self.mainView.repoTableView.frame.height > 0 else { return false }
        return offset.y + self.mainView.frame.height >= self.mainView.repoTableView.contentSize.height - 100
      }
      .map { _ in Reactor.Action.loadNextPage }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    // ------ 2. State 바인딩
    reactor.state.map { $0.repos }
      .bind(to: mainView.repoTableView.rx.items(cellIdentifier: RepoTableViewCell.identifier, cellType: RepoTableViewCell.self)) { (row, repo, cell) in
        cell.repoNameLabel.text = repo
      }
      .disposed(by: disposeBag)

    // ------ 3. View
    mainView.repoTableView.rx.itemSelected
      .subscribe (onNext: { [weak self, weak reactor] indexpath in
        guard let `self` = self else { return }
        self.view.endEditing(true)
        self.mainView.repoTableView.deselectRow(at: indexpath, animated: false)
        guard let repo = reactor?.currentState.repos[indexpath.row] else { return }
        guard let url = URL(string: "https://github.com/\(repo)") else { return }
        let viewController = SFSafariViewController(url: url)
        self.present(viewController, animated: true)
      })
      .disposed(by: disposeBag)

  }
}
