//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public func incorrectImplementation(
    reason: String,
    _ line: Int = #line, _ file: String = #file
) -> Never {
    fatalError("Incorrect implementation: \(reason)")
}

public func incorrectImplementation(
    shouldAlwaysBeAbleTo action: String,
    _ line: Int = #line, _ file: String = #file
) -> Never {
    let message = "Should always  be able to \(action)"
    incorrectImplementation(reason: message, line, file)
}
