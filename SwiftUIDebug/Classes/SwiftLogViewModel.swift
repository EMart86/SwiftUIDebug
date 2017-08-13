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
    private var cellItems = [SwiftLogProtocol]()
    
    init(cellItems: [SwiftLogProtocol]? = nil) {
        if let newCellItems = cellItems {
            self.cellItems.append(contentsOf: newCellItems)
        }
    }
    
    public func add(_ item: SwiftLogProtocol) {
        cellItems.append(item)
        notifySignalUpdate()
    }
    
    public func add(_ items: [SwiftLogProtocol]) {
        cellItems.append(contentsOf: items)
        notifySignalUpdate()
    }
    
    //MARK: - SwiftLogViewModelProtocol
    
    public var numberOfRows: Int? {
        return cellItems.count
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
    
    private func notifySignalUpdate() {
        delegate?.signalUpdate()
    }
    
    private func notifyShowDetail(for item: SwiftLogProtocol) {
        delegate?.siganlShowDetail(for: item)
    }
    
    private func item(for rowAtIndexPath: IndexPath) -> SwiftLogProtocol? {
        guard cellItems.indices.contains(rowAtIndexPath.row) else {
            return nil
        }
        
        return cellItems[rowAtIndexPath.row]
    }
}
