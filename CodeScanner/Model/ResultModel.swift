//
//  ScanModel.swift
//  CodeScanner
//
//  Created by Fahath Rajak on 26/07/20.
//  Copyright © 2020 Taby. All rights reserved.
//

import Foundation

public protocol ScanModelDelegate {
    func parseScannedString(_ string: String) -> ResultModel?
}

public protocol ResultModel {}
