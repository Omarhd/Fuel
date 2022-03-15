//
//  ScanerViewController.swift
//  Fuel
//
//  Created by Omar Abdulrahman on 3/2/22.
//

import UIKit
import AVFoundation
import ScannerOverlay

class ScanerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var scanerView: UIView!
    var video = AVCaptureVideoPreviewLayer()
    let session = AVCaptureSession()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SetUPScanner()
    }
    
    fileprivate func SetUPScanner() {
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        } catch {
            print("\(error.localizedDescription)")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
//        video = AVCaptureVideoPreviewLayer(session: session)
        
        let scannerOverlayPreviewLayer = ScannerOverlayPreviewLayer(session: session)
        scannerOverlayPreviewLayer.frame = self.scanerView.frame
        scannerOverlayPreviewLayer.maskSize = CGSize(width: 240, height: 240)
        scannerOverlayPreviewLayer.cornerRadius = 10
        scannerOverlayPreviewLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(scannerOverlayPreviewLayer)
        
        session.startRunning()
        
    }
}

extension ScanerViewController {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
       
        if metadataObjects != [] && metadataObjects.count != 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == AVMetadataObject.ObjectType.qr {
                   
                    let alertController = UIAlertController (
                        title: "Scan Done",
                        message: object.stringValue,
                        preferredStyle: UIAlertController.Style.alert
                    )
                    let cancelAction = UIAlertAction(title: "Re Scan", style: .cancel) { (action) in
                    }
                    let okayAction = UIAlertAction(title: "Get Shipment Data", style: .default) { (action) in
                        
                        let shipmentDetails = ShipmentQRCodeViewController.instantiate()
                        shipmentDetails.shipmentID = object.stringValue

                        self.navigationController?.modalPresentationStyle = .popover
                        self.navigationController?.pushViewController(shipmentDetails, animated: true)
                        
//                        self.session.stopRunning()


                    }
                    
                    alertController.addAction(okayAction)
                    alertController.addAction(cancelAction)
                                        
                    self.present(alertController, animated: true) {
                        
                    }
                }
            }
        }
    }
}
