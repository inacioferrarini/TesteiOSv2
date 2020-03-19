//
//  StatementListViewController.swift
//  BankApp
//
//  Created by José Inácio Athayde Ferrarini on 17/03/20.
//  Copyright (c) 2020 br.com.solutis.inacioferrarini. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol StatementListDisplayLogic: class {
    func fetchStatementsComplete(viewModel: StatementList.Statements.ViewModel)
}

class StatementListViewController: UIViewController, StatementListDisplayLogic {

    var interactor: StatementListBusinessLogic?
    var router: (NSObjectProtocol & StatementListRoutingLogic & StatementListDataPassing)?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = StatementListInteractor()
        let presenter = StatementListPresenter()
        let router = StatementListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if
            let dataStore = self.router?.dataStore,
            let userData = dataStore.userData,
            let statementsView = self.view as? StatementListView {
            
            let statementData = StatementListViewModel(userData: userData)
            statementsView.configure(with: statementData)
        }
        
        fetchStatements()
    }
    
    // MARK: - Fetching Data
    
    func fetchStatementsComplete(viewModel: StatementList.Statements.ViewModel) {
        
        toastEnd()
        
        if viewModel.errorMessage != nil {
            
        }
        
        if let statements = viewModel.statementList {
            (view as! StatementListView).statements = statements
        }
    }
    
    func fetchStatements() {
        toast(withMessage: "Atualizando ...")        
        interactor?.fetchStatements()
    }
    
}
