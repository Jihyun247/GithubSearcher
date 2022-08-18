//
//  SearchViewReactor.swift
//  GithubSearcher
//
//  Created by 김지현 on 2022/08/18.
//

import ReactorKit
import RxSwift
import RxCocoa
<<<<<<< HEAD
import Foundation

final class SearchViewReactor: Reactor {

  // ----------------- 1. Action, Mutation, State 정의

  enum Action {
    // 검색한 String
    case updateQuery(String?)
    // 무한스크롤
    case loadNextPage
  }

  enum Mutation {
    // 비즈니스 로직으로 들어갈 쿼리값을 의미
    case setQuery(String?)
    // 검색 결과인 Github의 repo 데이터
    case setRepos([String], nextPage: Int?)
    // 무한스크롤로 받은 새로운 데이터들을 append
    case appendRepos([String], nextPage: Int?)
    // 다음 페이지를 로딩할 수 있는지 여부 확인
    case setLoadingNextPage(Bool)
  }

  struct State {
    // 현재 검색한 String
    var query: String?
    // 검색 결과 데이터
    var repos: [String] = []
    // 다음 페이지 숫자
    var nextPage: Int?
    // 다음 페이지 로딩중인지
    var isLoadingNextPage: Bool = false
  }

  let initialState = State()

  // ----------------- 2. View에서 받아온 Action stream을 Mutation stream으로 바꾸기 위한 mutate() 구현

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {

      // .updateQuery 일 때의 로직 ->
      // 1) setQuery, 2) setRepos mutation에 넣어줌
    case let .updateQuery(query):

      // concat을 통해 순차적으로 Mutation으로 변경
      return Observable.concat([

        // 1) action으로 받아온 query를 mutation .setQuery 매개변수에 넣어줌
        Observable.just(Mutation.setQuery(query)),

        // 2) API를 호출하고 (호출 메서드 : search) setRepos에 설정
        // search 메서드가 api 호출 메서드
        self.search(query: query, page: 1)
        // cancel previous request when the new `.updateQuery` action is fired
          .take(until: self.action.filter(Action.isUpdateQueryAction))
          .map { Mutation.setRepos($0, nextPage: $1) },
      ])

      // .loadNextPage 일 때의 로직 -> 무한 스크롤을 사용하기 위해 다음 페이지를 로딩
      // 1) setLoadingNextPage, 2,3) setLoadingNextPage mutation에 넣어줌
    case .loadNextPage:

      guard !self.currentState.isLoadingNextPage else { return Observable.empty() } // prevent from multiple requests 넥스트페이지 로딩중이라면 옵저버블 초기화, 로딩중 아닐 때만 밑의 구문 실행됨
      guard let page = self.currentState.nextPage else { return Observable.empty() } // 페이지 없으면 초기화

      // concat을 통해 순차적으로 Mutation으로 변경
      return Observable.concat([

        // 1) set loading status to true
        Observable.just(Mutation.setLoadingNextPage(true)),

        // 2) call API and append repos
        self.search(query: self.currentState.query, page: page)
          .take(until: self.action.filter(Action.isUpdateQueryAction))
          .map { Mutation.appendRepos($0, nextPage: $1) },

        // 3) set loading status to false
        Observable.just(Mutation.setLoadingNextPage(false)),
      ])
    }
  }

  // ----------------- 3. 2에서 받아온 Mutation stream을 바탕으로 State를 방출하는 reduce() 구현
  func reduce(state: State, mutation: Mutation) -> State {
    switch mutation {
    case let .setQuery(query):
      var newState = state
      newState.query = query
      return newState

    case let .setRepos(repos, nextPage):
      var newState = state
      newState.repos = repos
      newState.nextPage = nextPage
      return newState

    case let .appendRepos(repos, nextPage):
      var newState = state
      newState.repos.append(contentsOf: repos)
      newState.nextPage = nextPage
      return newState

    case let .setLoadingNextPage(isLoadingNextPage):
      var newState = state
      newState.isLoadingNextPage = isLoadingNextPage
      return newState
    }
  }



  private func url(for query: String?, page: Int) -> URL? {
    guard let query = query, !query.isEmpty else { return nil }
    return URL(string: "https://api.github.com/search/repositories?q=\(query)&page=\(page)")
  }

  private func search(query: String?, page: Int) -> Observable<(repos: [String], nextPage: Int?)> {
    let emptyResult: ([String], Int?) = ([], nil)
    guard let url = self.url(for: query, page: page) else { return .just(emptyResult) }
    return URLSession.shared.rx.json(url: url)
      .map { json -> ([String], Int?) in
        guard let dict = json as? [String: Any] else { return emptyResult }
        guard let items = dict["items"] as? [[String: Any]] else { return emptyResult }
        let repos = items.compactMap { $0["full_name"] as? String }
        let nextPage = repos.isEmpty ? nil : page + 1
        return (repos, nextPage)
      }
      .do(onError: { error in
        if case let .some(.httpRequestFailed(response, _)) = error as? RxCocoaURLError, response.statusCode == 403 {
          print("⚠️ GitHub API rate limit exceeded. Wait for 60 seconds and try again.")
        }
      })
      .catchAndReturn(emptyResult)
  }
}

extension SearchViewReactor.Action {
  static func isUpdateQueryAction(_ action: SearchViewReactor.Action) -> Bool {
    if case .updateQuery = action {
      return true
    } else {
      return false
    }
  }
}
=======

>>>>>>> 90f751b... :tada: 라이브러리 import 및 Screen 파일
