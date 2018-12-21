//
//  NewsError.swift
//  NewsApp
//
//  Created by Vaibhav Parmar on 09/11/17.
//  Copyright © 2017 Vaibhav Parmar. All rights reserved.
//

import Foundation
import FoxAPIKit

public struct NewsError: AnyError {
    public var domain: String {
        return ""
    }
    public var code: Int
    public var title: String
    public var message: String
}
