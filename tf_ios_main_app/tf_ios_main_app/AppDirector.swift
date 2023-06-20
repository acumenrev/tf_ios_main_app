//
//  AppDirector.swift
//  tf_ios_main_app
//
//  Created by AL-TVO163 on 20/06/2023.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa
import UIKit
import tf_ios_app_flows
import tf_ios_module_a
import tf_ios_module_b
import URLNavigator


class AppDirector {
    var flowCoordinator = FlowCoordinator()
    let disposeBag = DisposeBag()
    weak var mainWindow : UIWindow?
    fileprivate var appNavigator : NavigatorProtocol?
    
    init(window : UIWindow?) {
        mainWindow = window
        setupRouting()
    }
}


/*
 - MARK: RxFlow methods
 */
extension AppDirector {
    fileprivate func setupFlow() {
        self.flowCoordinator.rx.willNavigate.subscribe(onNext: { (flow, step) in
            print("will navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: self.disposeBag)
        
        self.flowCoordinator.rx.didNavigate.subscribe(onNext: { (flow, step) in
            print("did navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: self.disposeBag)
        
        let moduleAFlow = ModuleAFlow.init(service: "Service", coordinator: self.flowCoordinator)
        self.flowCoordinator.coordinate(flow: moduleAFlow, with: ModuleAStepper())
        let moduleBFlow = ModuleBFlow.init(appService: "ServiceB")
        self.flowCoordinator.coordinate(flow: moduleBFlow, with: ModuleBStepper())
        print("setup coordinator")
        weak var weakSelf = self
        Flows.use(moduleAFlow, when: .created) { root in
            print("Flow init with root view controller: \(root)")
            weakSelf?.mainWindow?.rootViewController = root
            weakSelf?.mainWindow?.makeKeyAndVisible()
            print("Flow finish")
        }
    }
}

extension AppDirector {
    fileprivate func setupRouting() {
        let navigator = Navigator()
        
        
        // register navigator
        ModuleANavigator.initialize(navigator: navigator)
        ModuleBRouter.initialize(navigator: navigator)
        
        // present view controller
        let vc = LoginViewController.instantiate(navigator: navigator)
        mainWindow?.rootViewController = UINavigationController(rootViewController: vc)
        
        self.appNavigator =  navigator
    }
}
