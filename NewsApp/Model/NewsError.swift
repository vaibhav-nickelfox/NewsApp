//
//  NewsError.swift
//  NewsApp
//
//  Created by Vaibhav Parmar on 09/11/17.
//  Copyright © 2017 Vaibhav Parmar. All rights reserved.
//

import Foundation
import APIClient

public struct NewsError: APIError {
    public var code: Int
    public var title: String
    public var message: String
}
