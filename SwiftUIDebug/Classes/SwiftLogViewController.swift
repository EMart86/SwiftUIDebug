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
    internal var viewModel: SwiftLogViewModelProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    public class func create(_ viewModel: SwiftLogViewModelProtocol) -> SwiftLogViewController {
        let viewController = SwiftLogViewController(style: .plain)
        viewController.viewModel = viewModel
        return viewController
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: - UITableView DataSource
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LogTableViewCell.nibName) as? LogTableViewCell else {
            return UITableViewCell()
        }
        cell.content = viewModel?.cellItem(for: indexPath)
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectItem(at: indexPath)
    }
    
    //MARK: - Private
    
    private func setupUI() {
        
        tableView.register(
            UINib(
                nibName: LogTableViewCell.nibName,
                bundle: nil),
            forCellReuseIdentifier: LogTableViewCell.nibName)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
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
