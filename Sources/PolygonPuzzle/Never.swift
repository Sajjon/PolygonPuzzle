//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-03.
//

import Foundation

public func implementMe(
    _ line: Int = #line, _ file: String = #file
) -> Never {
    fatalError("Implement me - \(line)@\(file)")
}

public func unexpectedlyCaught(
    error: Swift.Error,
    _ line: Int = #line, _ file: String = #file
) -> Never {
    fatalError("Unexpectedly caught error: \(error) - \(line)@\(file)")
}

public func incorrectImplementation(
    reason: String,
    _ line: Int = #line, _ file: String = #file
) -> Never {
    fatalError("Incorrect implementation: \(reason) - \(line)@\(file)")
}

public func incorrectImplementation(
    shouldAlwaysBeAbleTo action: String,
    _ line: Int = #line, _ file: String = #file
) -> Never {
    let message = "Should always  be able to \(action)"
    incorrectImplementation(reason: message, line, file)
}
