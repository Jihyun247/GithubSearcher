//
//  UIView+.swift
//  GithubSearcher
//
//  Created by 김지현 on 2022/08/21.
//

import UIKit

extension UIView {
  func addSubViews<T: UIView>(_ subviews: [T], completionHandler closure: (([T]) -> Void)? = nil) {
      subviews.forEach { addSubview($0) }
      closure?(subviews)
  }

  func makeRounded(cornerRadius : CGFloat?) {
      if let cornerRadius_ = cornerRadius {
          self.layer.cornerRadius = cornerRadius_
      }  else {
          // cornerRadius 가 nil 일 경우의 default
          self.layer.cornerRadius = self.layer.frame.height / 2
      }

      self.layer.masksToBounds = true
  }
}
