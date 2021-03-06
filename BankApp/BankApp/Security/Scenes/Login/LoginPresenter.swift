//
//  LoginPresenter.swift
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

protocol LoginPresentationLogic {
    func loginSuccess(response: Login.Authentication.Response?)
    func loginError(error: String?)
}

class LoginPresenter: LoginPresentationLogic {

    weak var viewController: LoginDisplayLogic?
    
    // MARK: Do something

    func loginSuccess(response: Login.Authentication.Response?) {
        let viewModel = Login.Authentication.ViewModel(userData: response?.userAccount,
                                                       errorMessage: nil)
        viewController?.authenticationComplete(viewModel: viewModel)
    }

    func loginError(error: String?) {
        let viewModel = Login.Authentication.ViewModel(userData: nil,
                                                       errorMessage: error)
        viewController?.authenticationComplete(viewModel: viewModel)
    }

}
