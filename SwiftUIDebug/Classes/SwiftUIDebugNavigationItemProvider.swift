//
//  SwiftUIDebugNavigationItemProvider.swift
//  Pods
//
//  Created by Martin Eberl on 13.08.17.
//
//

import UIKit

public protocol SwiftUIDebugNavigationItemProviderProtocol {
    var navigationItem: UINavigationItem? { get set }
    weak var navigationController: UINavigationController? { get set }
}

public final class SwiftUIDebugNavigationItemProvider: SwiftUIDebugNavigationItemProviderProtocol {
    enum NavigationItem {
        case close
    }
    
    public var navigationItem: UINavigationItem? {
        didSet {
            if navigationItem != nil {
                injectNavigationItems()
            }
        }
    }
    
    public weak var navigationController: UINavigationController?
    
    public init() {
    }
    
    //MARK: - Private
    
    private func injectNavigationItems() {
        navigationItem?.leftBarButtonItem = UIBarButtonItem(
            image:  UIImage(named: "close-button.png"),
            style: .plain,
            target: self,
            action: #selector(close))
    }
    
    @objc private func close() {
        navigationController?.removeFromParentViewController()
    }
}
