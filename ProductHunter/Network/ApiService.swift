//
//  ApiService.swift
//  ProductHunter
//
//  Created by User on 6/11/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import Alamofire

class ApiService {
    static let shared = ApiService()
    
    //MARK: Session Managers
    var defaultSM = SessionManager()
    
    private init() {
        setupAdapters()
    }
    
    private func setupAdapters() {
        defaultSM.adapter = DefaultAdapter(bearerToken: AppConstants.BEARER_TOKEN)
    }
}

