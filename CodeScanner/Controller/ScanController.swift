//
//  ScanController.swift
//  CodeScanner
//
//  Created by Sivakumar Muniappan on 7/26/20.
//  Copyright © 2020 Taby. All rights reserved.
//

import UIKit
import Combine

protocol ScanControllerProtocol: class {
    func udpateScannedData(data: String)
}

final class ScanController: UIViewController {
    var resultSubscriber: AnyCancellable?
    weak var scanControllerDelegate: ScanControllerProtocol?
    var scanViewModel: ScanViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanViewModel = ScanViewModel(bounds: self.view.layer.bounds)
        if scanViewModel.isScanSupported {
            view.layer.addSublayer(scanViewModel.previewLayer)
            let scanSubscriber = scanViewModel
                .publisher
                .print("headingSubscriber")
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { completion in },
                      receiveValue: { someValue in
                        //self.headingLabel.text = String(someValue.trueHeading)
                        self.updateStatus(with: someValue)
                        print(someValue)
                })

            resultSubscriber = AnyCancellable(scanSubscriber)
            
            scanViewModel.startScanning()
//            scanViewModel.startScanning { (readableObject) in
//                if let readableObject = readableObject {
//                    self.scanControllerDelegate?.udpateScannedData(data: readableObject)
//                    self.dismiss(animated: true, completion: nil)
//                }
//            }
        } else {
            failedToScan()
        }
        
    }
    
    private func updateStatus(with result: String) {
        scanControllerDelegate?.udpateScannedData(data: result)
    }
    
    func failedToScan() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
