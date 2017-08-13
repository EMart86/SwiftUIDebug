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

public final class 
