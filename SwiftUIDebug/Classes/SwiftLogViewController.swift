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
    private var scrollToBottom = true
    
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
        let nib = UINib(
            nibName: LogTableViewCell.nibName,
            bundle: Bundle(for: self.classForCoder))
        tableView.register(
            nib,
            forCellReuseIdentifier: LogTableViewCell.nibName)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    fileprivate func updateUI() {
        tableView.reloadData()
        
        if scrollToBottom {
            let size = tableView.contentSize
            tableView.scrollRectToVisible(CGRect(x: 0, y: size.height - 1,  width: size.width, height: 1), animated: true)
        }
    }
    
    public override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollToBottom = false
    }
    
    public override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollToBottom = scrollView.contentOffset.y + scrollView.bounds.height >= scrollView.contentSize.height
    }
}

extension SwiftLogViewController: SwiftLogViewModelProtocolDelegate {
    public func signalUpdate() {
        updateUI()
    }
    
    public func siganlShowDetail(for item: SwiftLogProtocol) {
        
    }
}
