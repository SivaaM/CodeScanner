//
//  ContentView.swift
//  CodeScanner
//
//  Created by Sivakumar Muniappan on 7/26/20.
//  Copyright © 2020 Taby. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: BarcodeView()) {
                Text("Scan Your Barcode")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
