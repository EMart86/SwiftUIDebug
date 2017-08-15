//
//  SwiftLogDetailViewController.swift
//  Pods
//
//  Created by Martin Eberl on 14.08.17.
//
//

import Foundation

public protocol SwiftLogDetailViewModelProtocol {
    var title: String? { get }
    var text: String { get }
}

public final class SwiftLogDetailViewController: UIViewController {
    private static let nibName = "SwiftLogDetailViewController"
    @IBOutlet weak var textView: UITextView!
    
    var viewModel: SwiftLogDetailViewModelProtocol? {
        didSet {
            updateUI()
        }
    }
    
    public class func create(with viewModel: SwiftLogDetailViewModelProtocol) -> SwiftLogDetailViewController {
        let viewController = SwiftLogDetailViewController(nibName: nibName,
                                                          bundle: Bundle(for: self.classForCoder()))
        viewController.viewModel = viewModel
        return viewController
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    //MARK: - Private
    
    private func updateUI() {
        guard isViewLoaded else { return }
        
        navigationItem.title = viewModel?.title
        textView.text = viewModel?.text
    }
}
