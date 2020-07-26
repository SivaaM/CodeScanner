//
//  BarCodeHandler.swift
//  CodeScanner
//
//  Created by Fahath Rajak on 26/07/20.
//  Copyright © 2020 Taby. All rights reserved.
//

import Foundation

struct BarCodeDataHandler: ScanModelDelegate {
    func parseScannedString(_ string: String) -> ResultModel? {
        return BarCodeModel(name: "Fahath", barcode: "Barcode")
    }
}

struct QRModelDataHandler: ScanModelDelegate {
    func parseScannedString(_ string: String) -> ResultModel? {
        return QRModel(name: "Fahath", qr: "QR")
    }
}
