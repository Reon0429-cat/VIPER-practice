//
//  GitHubSearchRouter.swift
//  VIPER-practice
//
//  Created by 大西玲音 on 2021/04/30.
//

import UIKit

protocol GitHubSearchWireframe {
    func showWeb(initParameters: WebUsecaseInitParameters)
    func showAlert(error: Error)
}

final class GitHubSearchRouter {
    
    private unowned let viewController: UIViewController
    
    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // Routerが画面遷移を担当しているので、ここに書く
    static func assembleModules() -> UIViewController {
        let view = UIStoryboard.gitHubSearch.instantiateInitialViewController() as! GitHubSearchViewController
        let interactor = GitHubSearchInteractor()
        let router = GitHubSearchRouter(viewController: view)
        // presenterが中継役なので、全てと繋げる
        let presenter = GitHubSearchPresenter(view: view,
                                              interactor: interactor,
                                              router: router)
        // viewからpresenterに通知する必要があるため繋ぐ
        // viewとpresenterは互いが互いを知っている
        view.inject(presenter: presenter)
        return view
    }
    
}

// MARK: - GitHubSearchWireframe
extension GitHubSearchRouter: GitHubSearchWireframe {
    
    func showWeb(initParameters: WebUsecaseInitParameters) {
        let next = WebRouter.assembleModules(initParameters: initParameters)
        viewController.show(next: next)
    }
    
    func showAlert(error: Error) {
        print(error.localizedDescription)
    }
    
}
