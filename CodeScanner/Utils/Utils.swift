//
//  Utils.swift
//  CodeScanner
//
//  Created by Fahath Rajak on 26/07/20.
//  Copyright © 2020 Taby. All rights reserved.
//

import Foundation


enum CustomError: Error {
    case notscanned
    case unsupported
    
    func message() -> String {
        switch self {
        case .notscanned:
            return "Not scanned"
        default:
            return "Unsupported"
        }
    }
}
