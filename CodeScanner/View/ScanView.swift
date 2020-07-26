//
//  ScanView.swift
//  CodeScanner
//
//  Created by Sivakumar Muniappan on 7/26/20.
//  Copyright © 2020 Taby. All rights reserved.
//

import SwiftUI

struct ScanView: UIViewControllerRepresentable {
    
    @Binding var scannedData: String?
    
    class Coordinator: NSObject, ScanControllerProtocol {
        
        var parent: ScanView
    
        init(_ parent: ScanView) {
            self.parent = parent
        }

        func udpateScannedData(data: String) {
            parent.scannedData = data
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
