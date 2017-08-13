//
//  SwiftUIDebug.swift
//  Pods
//
//  Created by Martin Eberl on 09.08.17.
//
//

import Foundation
import EMTransformableNavigationController

public final class SwiftUIDebug {
    enum ViewController {
        case log
        
        func viewController(with viewModel: Any) -> UIViewController? {
            switch self {
            case .log:
                guard let viewModel = viewModel as? SwiftLogViewModelProtocol else {
                    return nil
                }
                return SwiftLogViewController.create(viewModel)
            }
        }
    }
    
    @discardableResult public static func debugController(
        with parentViewController: UIViewController,
        viewModel: SwiftLogViewModelProtocol = SwiftLogViewModel()) -> EMTransformableNavigationController? {
        
        guard let viewController = ViewController.log.viewController(with: viewModel) else {
            return nil
        }
        let navigationController = EMTransformableNavigationController(
            rootViewController: viewController
        )
        navigationController.add(to: parentViewController)
        return navigationController
    }
}
