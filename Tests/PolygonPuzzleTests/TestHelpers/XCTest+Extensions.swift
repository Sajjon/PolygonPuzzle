//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2020-07-05.
//

import Foundation
import XCTest

public extension XCTestCase {
    
    /// Asserts that a `result` is not `successful`, and returns its wrapped value.
    ///
    /// Generates a failure when `result == .failure`.
    ///
    /// - Parameters:
    ///   - result: A Result of type `Result<T, some Error>` to try to retrive successful data from. Its type will determine the type of the returned value.
    ///   - message: An optional description of the failure.
    ///   - file: The file in which failure occurred. Defaults to the file name of the test case in which this function was called.
    ///   - line: The line number on which failure occurred. Defaults to the line number on which this function was called.
    /// - Returns: A value of type `T`, the succesfully scenario of the `result`
    /// - Throws: An error when `result == .failure(let failureError)`. It will `XCTFail`  and also rethrow the `failureError` thrown while evaluating
    func XCTGet<T, E>(
        _ result: Swift.Result<T, E>,
        _ makeMessage: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws -> T where E: Swift.Error {
        let message = makeMessage()
        do {
            return try result.get()
        } catch {
            XCTAssertNoThrow(try result.get(), message, file: file, line: line)
            throw error
        }
    }
}
