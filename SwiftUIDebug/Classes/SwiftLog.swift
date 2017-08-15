//
//  SwiftLogProtocol.swift
//  Pods
//
//  Created by Martin Eberl on 11.08.17.
//
//

import Foundation

public protocol SwiftLogProtocol {
    var text: String { get }
    var date: Date? { get }
}

public protocol SwiftLogObserver: class {
    func didAdd(items: [SwiftLogProtocol])
}

public struct WeakObserver: Equatable {
    public static func ==(lhs: WeakObserver, rhs: WeakObserver) -> Bool {
        return lhs.observer === rhs.observer
    }

    weak var observer: SwiftLogObserver?
}

public protocol SwiftLogProviderProtocol {
    var logs: [SwiftLogProtocol] { get }
    func add(_ observer: SwiftLogObserver)
    func remove(_ observer: SwiftLogObserver)
}

public struct SwiftLog: SwiftLogProtocol {
    public let date: Date?
    public let text: String
    
    public init(_ date: Date?, _ text: String) {
        self.date = date
        self.text = text
    }
}

public final class SwiftLogProvider: SwiftLogProviderProtocol {
    public static var shared: SwiftLogProvider = {
        return SwiftLogProvider()
    }()
    
    private var observers = [WeakObserver]()
    public private(set) var logs = [SwiftLogProtocol]() {
        didSet {
            if logs.count > maxEntries {
                logs.removeFirst(logs.count - maxEntries)
            }
        }
    }
    public var maxEntries = 200
    
    internal init() {}
    
    public func add(_ log: SwiftLogProtocol) {
        logs.append(log)
        
        notifyAsyncDid(add: [log])
    }
    
    public func add(_ logs: [SwiftLogProtocol]) {
        self.logs.append(contentsOf: logs)
        notifyAsyncDid(add: logs)
    }
    
    public func add(_ observer: SwiftLogObserver) {
        guard nil == observers.index(where: { $0.observer === observer }) else {
            return
        }
        observers.append(WeakObserver(observer: observer))
    }
    
    public func remove(_ observer: SwiftLogObserver) {
        guard let index = observers.index(where: { $0.observer === observer }) else {
            return
        }
        observers.remove(at: index)
        removeUnusedObservers()
    }
    
    //MARK: - Private
    
    private func notifyAsyncDid(add item: [SwiftLogProtocol]) {
        DispatchQueue.main.async {[weak self] in
            self?.notifyDidAdd(items: item)
        }
    }
    
    private func index(of weakObserver: WeakObserver) -> Int? {
        return observers.index(where: { $0 == weakObserver })
    }
    
    private func remove(_ weakObserver: WeakObserver) {
        guard let index = index(of: weakObserver) else {
            return
        }
        observers.remove(at: index)
    }
    
    public func removeUnusedObservers() {
        let unused = observers.filter({ $0.observer == nil })
        for observer in unused {
            remove(observer)
        }
    }
    
    private func notifyDidAdd(items: [SwiftLogProtocol]) {
        removeUnusedObservers()
        observers.forEach({
            $0.observer?.didAdd(items: items)
        })
    }
}
