//
//  MainViewController.swift
//  SearchDaumBlog
//
//  Created by 김성준 on 2022/08/08.
//

import RxSwift
import RxCocoa
import UIKit

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let searBar = SearchBar()
    let listView = BlogListView()
    
    let alertActionTapped = PublishRelay<AlertAction>()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super .init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(){
        let alertsheetForSorting = listView.headerView.sorButtonTapped
            .map { _ -> Alert in
                return (title: nil, message: nil, actions:[.title, .datetime, .cancel], style: .actionSheet)
            }
        
        alertsheetForSorting
            .asSignal(onErrorSignalWith: .empty())
            .flatMapLatest { alert -> Signal<AlertAction> in
                let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: alert.style)
                return self.presentAlertController(alertController, actions: alert.actions)
            }
            .emit(to: alertActionTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute(){
        title = "다음 블로그 검색"
        view.backgroundColor = .white
        
    }
    
    private func layout(){
        [searBar, listView].forEach {
            view.addSubview($0)
        }
            searBar.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide)
                $0.leading.trailing.equalToSuperview()
            }

            listView.snp.makeConstraints{
                $0.top.equalTo(searBar.snp.bottom)
                $0.leading.trailing.bottom.equalToSuperview()
            }
    }
}

//Alert
extension MainViewController {
    typealias Alert = (title: String?, message: String?, actions:[AlertAction], style: UIAlertController.Style)
    
    enum AlertAction: AlertActionConvertible{
        case title, datetime, cancel
        case confirm
        
        var title: String {
            switch self {
            case .title :
                return "Title"
            case .datetime:
                return "Datetime"
            case .cancel :
                return "Cancel"
            case .confirm:
                return "confirm"
            }
        }
        
        var style : UIAlertAction.Style {
            switch self{
            case .title, .datetime:
                return .default
                
            case .cancel, .confirm:
                return .cancel
            }
        }
    }
    
    func presentAlertController<Action: AlertActionConvertible>(_ alertController: UIAlertController, actions: [Action]) -> Signal<Action> {
        if actions.isEmpty {  return .empty() }
        return Observable
            .create{  [weak self] observer in
                guard let self = self else { return Disposables.create() }
                for action in actions {
                    alertController.addAction(
                        UIAlertAction(
                            title: action.title,
                            style: action.style,
                            handler: {_ in
                                observer.onNext(action)
                                observer.onCompleted()
                        })
                    )
                }
                self.present(alertController, animated: true, completion: nil)
                
                return Disposables.create {
                    alertController.dismiss(animated: true, completion: nil)
                }
            }
            .asSignal(onErrorSignalWith: .empty())
    }
}

