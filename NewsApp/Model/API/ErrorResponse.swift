//
//  ErrorResponse.swift
//  NewsApp
//
//  Created by Vaibhav Parmar on 09/11/17.
//  Copyright © 2017 Vaibhav Parmar. All rights reserved.
//

import Foundation
import APIClient

private let errorKey = "error"

public struct ErrorResponse: ErrorResponseProtocol {
    public static func parse(_ json: JSON, code: Int) throws -> ErrorResponse {
        return try ErrorResponse(code: json["error_code"]^, messages: [json[errorKey]^])
    }
    
    public var code: Int
    public let messages: [String]
    public var compiledErrorMessage: String{
        return self.messages.joined(separator: ", ")
    }
    
    public var message: String{
        return self.compiledErrorMessage
    }
    
    public var title: String{
        return ""
    }
}
