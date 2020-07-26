//
//  ScanViewModel.swift
//  CodeScanner
//
//  Created by Sivakumar Muniappan on 7/26/20.
//  Copyright © 2020 Taby. All rights reserved.
//

import Foundation
import AVFoundation

class ScanViewModel: NSObject {
    
    private var captureSession: AVCaptureSession = AVCaptureSession()
    lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        return AVCaptureVideoPreviewLayer(session: captureSession) }()
    
    var isScanSupported: Bool = false
    var readableObject: ((String) -> Void)?
    
    init(bounds: CGRect) {
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
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
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
    
    func startScanning(_ readableObject: @escaping (String?) -> Void) {
        self.readableObject = readableObject
        if !self.captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    
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
            self.readableObject?(stringValue)
        }
    }
}
