//
//  SwiftLogViewModel.swift
//  Pods
//
//  Created by Martin Eberl on 09.08.17.
//
//

import Foundation

open class SwiftLogViewModel: SwiftLogViewModelProtocol {
    weak public var delegate: SwiftLogViewModelProtocolDelegate?
    private var provider: SwiftLogProviderProtocol
    
    public init(provider: SwiftLogProviderProtocol) {
        self.provider = provider
       
        addObserverAsync()
    }
    
    deinit {
        provider.remove(self)
    }
    
    //MARK: - SwiftLogViewModelProtocol
    
    public var numberOfRows: Int? {
        return provider.logs.count
    }
    
    public func cellItem(for indexPath: IndexPath) -> SwiftLogProtocol? {
        return item(for: indexPath)
    }
    
    public func didSelectItem(at indexPath: IndexPath) {
        guard let item = item(for: indexPath) else {
            return
        }
        notifyShowDetail(for: item)
    }
    
    //MARK: - Private
    
    fileprivate func addObserverAsync() {
        DispatchQueue.main.async {[weak self] in
            if let strongSelf = self {
                strongSelf.provider.add(strongSelf)
            }
        }
    }
    
    fileprivate func notifySignalUpdate() {
        delegate?.signalUpdate()
    }
    
    private func notifyShowDetail(for item: SwiftLogProtocol) {
        delegate?.siganlShowDetail(for: item)
    }
    
    private func item(for rowAtIndexPath: IndexPath) -> SwiftLogProtocol? {
        guard provider.logs.indices.contains(rowAtIndexPath.row) else {
            return nil
        }
        
        return provider.logs[rowAtIndexPath.row]
    }
}

extension SwiftLogViewModel: SwiftLogObserver {
    public func didAdd(items: [SwiftLogProtocol]) {
        notifySignalUpdate()
    }
}
