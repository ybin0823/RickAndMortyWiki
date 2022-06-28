//
//  TableView+LoadMore.swift
//  RickAndMortyWiki
//
//  Created by jyb on 2022/06/28.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {
    public var loadMore: Observable<Bool> {
        let proxy = RxScrollViewDelegateProxy.proxy(for: base)
        
        if let scrollView = proxy.scrollView {
            return self.base.rx.contentOffset.map { point in
                scrollView.contentSize.height != 0 && point.y > scrollView.contentSize.height - scrollView.frame.height
            }
        }
        
        return BehaviorSubject<Bool>(value: false)
    }
}
