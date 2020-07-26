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
    @State var scannedData: String?
    
    var body: some View {
        NavigationView {
            Button("Scan") {
                self.showScanView.toggle()
            }
            .sheet(isPresented: $showScanView, onDismiss: displayScannedData) {
                ScanView(scannedData: self.$scannedData)
            }
        }
    }
    
    private func displayScannedData() {
        print("Final Result: \(self.scannedData ?? "No Data Retrieved")")
    }
}

struct BarcodeView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeView()
    }
}
