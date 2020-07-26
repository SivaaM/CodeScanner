//
//  ScanController.swift
//  CodeScanner
//
//  Created by Sivakumar Muniappan on 7/26/20.
//  Copyright © 2020 Taby. All rights reserved.
//

import UIKit

protocol ScanControllerProtocol: class {
    func udpateScannedData(data: String)
}

final class ScanController: UIViewController {
    
    weak var scanControllerDelegate: ScanControllerProtocol?
    var scanViewModel: ScanViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanViewModel = ScanViewModel(bounds: self.view.layer.bounds)
        if scanViewModel.isScanSupported {
            view.layer.addSublayer(scanViewModel.previewLayer)
            scanViewModel.startScanning { (readableObject) in
                if let readableObject = readableObject {
                    self.scanControllerDelegate?.udpateScannedData(data: readableObject)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            failedToScan()
        }
        
        scanControllerDelegate?.udpateScannedData(data: "No Code Scanned")
    }
    
    func failedToScan() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
