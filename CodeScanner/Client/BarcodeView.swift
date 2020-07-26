//
//  BarcodeView.swift
//  CodeScanner
//
//  Created by Sivakumar Muniappan on 7/26/20.
//  Copyright © 2020 Taby. All rights reserved.
//

import SwiftUI

struct BarcodeView: View {
        
    @State private var showScanView = false
    @State var scannedData: BarCodeModel?
    
    var body: some View {
        NavigationView {
            Button("Scan") {
                self.showScanView.toggle()
            }
            .sheet(isPresented: $showScanView, onDismiss: displayScannedData) {
                //ScanView<BarCodeModel>(scannedData: self.$scannedData)
                ScanView<BarCodeModel>(scannedData: self.$scannedData, scanModelDelegate: BarCodeDataHandler())
            }
        }
    }
    
    private func displayScannedData() {
        print("Final Result: \(self.scannedData?.barcode ?? "No Data Retrieved")")
    }
}

struct BarcodeView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeView()
    }
}
