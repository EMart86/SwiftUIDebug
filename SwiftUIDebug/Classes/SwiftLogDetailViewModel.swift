//
//  SwiftLogDetailViewModel.swift
//  Pods
//
//  Created by Martin Eberl on 14.08.17.
//
//

import Foundation

public final class SwiftLogDetailViewModel: SwiftLogDetailViewModelProtocol {
    private let log: SwiftLogProtocol
    private let formatter = DateFormatter()
    
    init(_ log: SwiftLogProtocol) {
        self.log = log
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
    }
    
    public var title: String? {
        guard let date = log.date else {
            return nil
        }
        return formatter.string(from: date)
    }
    
    public var text: String {
        return log.text
    }
}
