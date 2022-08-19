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

final class SearchViewController: UIViewController {

    var mainView = SearchView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
    }
}
