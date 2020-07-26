//
//  ScanView.swift
//  CodeScanner
//
//  Created by Sivakumar Muniappan on 7/26/20.
//  Copyright © 2020 Taby. All rights reserved.
//

import SwiftUI

struct ScanView<T: ResultModel>: UIViewControllerRepresentable {
    
    @Binding var scannedData: T?
    
    var scanModelDelegate: ScanModelDelegate?
    
    class Coordinator: NSObject, ScanControllerProtocol {
        
        var parent: ScanView
        var scanModelDelegate: ScanModelDelegate?

        init(_ parent: ScanView) {
            self.parent = parent
        }

        func udpateScannedData(data: String) {
            scanModelDelegate = parent.scanModelDelegate
            guard let genericScanModel = scanModelDelegate?.parseScannedString(data) else {
                parent.scannedData = nil
                return
            }
        
            parent.scannedData = genericScanModel as? T
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ScanView>) -> ScanController {
        let scanController = ScanController()
        scanController.scanControllerDelegate = context.coordinator
        return scanController
    }
    
    func updateUIViewController(_ uiViewController: ScanController, context: UIViewControllerRepresentableContext<ScanView>) {
    }
    
}
