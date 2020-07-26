//
//  ScanViewModel.swift
//  CodeScanner
//
//  Created by Sivakumar Muniappan on 7/26/20.
//  Copyright © 2020 Taby. All rights reserved.
//

import Foundation
import AVFoundation
import Combine

class ScanViewModel: NSObject {
        
    private var captureSession: AVCaptureSession = AVCaptureSession()
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        return AVCaptureVideoPreviewLayer(session: captureSession)
    }()
    
    var isScanSupported: Bool = false
    //var readableObject: ((String) -> Void)?
    
    private var resultPublisher: PassthroughSubject<String, CustomError>
    var publisher: AnyPublisher<String, CustomError>

    
    init(bounds: CGRect) {
        resultPublisher = PassthroughSubject<String, CustomError>()
        publisher = resultPublisher.eraseToAnyPublisher()
        
        super .init()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
            isScanSupported = true
        } else {
            isScanSupported = false
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = metadataOutput.availableMetadataObjectTypes
            isScanSupported = true
        } else {
            isScanSupported = false
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = bounds
        previewLayer.videoGravity = .resizeAspectFill
        captureSession.startRunning()
    }
    
    func toggleScan() {
        !self.captureSession.isRunning ? captureSession.startRunning() : captureSession.stopRunning()
    }
    
    func startScanning() {
        if !self.captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    
//    func startScanning(_ readableObject: @escaping (String?) -> Void) {
//        self.readableObject = readableObject
//        if !self.captureSession.isRunning {
//            captureSession.startRunning()
//        }
//    }
    
    func stopScanning() {
        if self.captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
}

extension ScanViewModel: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            //self.readableObject?(stringValue)
//            if let resultModel = scanDelegate?.parseScannedString(stringValue) {
//                resultPublisher.send(resultModel)
//            } else {
//                resultPublisher.send(completion: Subscribers.Completion.failure(.unsupported))
//            }
            resultPublisher.send(stringValue)

        } else {
            stopScanning()
            resultPublisher.send(completion: Subscribers.Completion.failure(.notscanned))
        }
    }
    
    
}
