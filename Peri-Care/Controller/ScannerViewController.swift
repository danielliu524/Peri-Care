//
//  ScannerViewController.swift
//  Pericare
//
//  Created by Daniel Liu on 10/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController {
    var homeView: CareViewController!
    var tabView: TabBarController!
    var codeString: String!
    var scannerConfirmViewController: ScannerConfirmViewController?
    @IBOutlet var scanButton: UIButton!
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    @IBAction func scanButtonPressed(withSender: UIButton!) {
        if withSender.titleLabel?.text != "No QR Code Detected" {
            performSegue(withIdentifier: "confirmSegue", sender: nil)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
//        navigationController?.navigationBar.shadowImage = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "confirmSegue" {
            scannerConfirmViewController = segue.destination as? ScannerConfirmViewController
            scannerConfirmViewController?.codeString = codeString
            scannerConfirmViewController?.homeView = homeView
            scannerConfirmViewController?.tabView = tabView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanButton.layer.cornerRadius = 25.0
        scanButton.layer.masksToBounds = true
        //get back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: .video, position: .back)
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get Camera Device")
            return
        }
        do {
            //Get an instance of AVCaptureDeviceInput class using previous device object
            let input = try AVCaptureDeviceInput(device: captureDevice)
            //Set the device input on the capture session
            captureSession.addInput(input)
            //Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            //Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            //Initialize video preview layer and add it as a sublayer to the viewPreview view's layer
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            //Start video capture
            captureSession.startRunning()
            //Initialize QR Code fram to highlight QR code
            qrCodeFrameView = UIView()
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubviewToFront(qrCodeFrameView)
            }
            view.bringSubviewToFront(scanButton)
        } catch {
            print(error)
            return
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        //Check if metadataobject is not nil and at least contains one object
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            scanButton.setTitle("No QR Code Detected", for: .normal)
            scanButton.backgroundColor = UIColor(red: 111.0/255.0, green: 113.0/255.0, blue: 121.0/255.0, alpha: 1.0)
            return
        }
        //Get the metadata object
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            scanButton.setTitle("Scan", for: .normal)
            scanButton.backgroundColor = UIColor(red: 38.0/255.0, green: 162.0/255.0, blue: 78.0/255.0, alpha: 1.0)
            //format:
            codeString = metadataObj.stringValue
        }
    }
}
