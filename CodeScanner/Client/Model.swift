//
//  Model.swift
//  CodeScanner
//
//  Created by Fahath Rajak on 26/07/20.
//  Copyright © 2020 Taby. All rights reserved.
//

import Foundation

struct QRModel: ResultModel {
    let name: String
    let qr: String
}

struct BarCodeModel: ResultModel {
    let name: String
    let barcode: String
}
