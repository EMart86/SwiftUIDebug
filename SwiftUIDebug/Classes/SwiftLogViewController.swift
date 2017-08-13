//
//  LogViewController.swift
//  Pods
//
//  Created by Martin Eberl on 09.08.17.
//
//

import Foundation

public protocol SwiftLogViewModelProtocolDelegate: class {
    func signalUpdate()
    func siganlShowDetail(for item: SwiftLogProtocol)
}

public protocol SwiftLogViewModelProtocol {
    weak var delegate: SwiftLogViewModelProtocolDelegate? { get set }
    var numberOfRows: Int? { get }
    func cellItem(for indexPath: IndexPath) -> SwiftLogProtocol?
    func didSelectItem(at indexPath: IndexPath)
}

public final class SwiftLogViewController: UITableViewController {
    internal var viewModel: SwiftLogViewModelProtocol?
    
    public class func create(_ viewModel: SwiftLogViewModelProtocol) -> SwiftLogViewController {
        let viewController = SwiftLogViewController(style: .plain)
        viewController.viewModel = viewModel
        return viewController
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(
            UINib(
                nibName: LogTableViewCell.nibName,
                bundle: nil),
                           forCellReuseIdentifier: LogTableViewCell.nibName)
    }
    
    //MARK: - Private
    
    fileprivate func updateUI() {
        tableView.reloadData()
    }
}

extension SwiftLogViewController: SwiftLogViewModelProtocolDelegate {
    public func signalUpdate() {
        updateUI()
    }
    
    public func siganlShowDetail(for item: SwiftLogProtocol) {
        
    }
}
