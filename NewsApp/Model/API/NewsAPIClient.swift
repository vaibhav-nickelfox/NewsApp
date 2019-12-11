//
//  NewsAPIClient.swift
//  NewsApp
//
//  Created by Vaibhav Parmar on 09/11/17.
//  Copyright © 2017 Vaibhav Parmar. All rights reserved.
//

import Foundation
import FoxAPIKit

class NewsAPIClient: APIClient<AuthHeaders, ErrorResponse> {
    static let shared = NewsAPIClient()
    
    override init() {
        super.init()
        self.enableLogs = false
    }
}
