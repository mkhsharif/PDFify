//
//  CameraViewController.swift
//  PDFify
//
//  Created by MKHS on 4/14/19.
//  Copyright © 2019 mkhs. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    
    @IBOutlet weak var photoPreview: UIImageView!
    
    var session: AVCaptureSession?
    var stillImageOutput: AVCapturePhotoOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSession.Preset.photo
        let backCamera =  AVCaptureDevice.default(for: AVMediaType.video)
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera!)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        if error == nil && session!.canAddInput(input) {
            session!.addInput(input)
            stillImageOutput = AVCapturePhotoOutput()
            //stillImageOutput?.outputSettings = [AVVideoCodecKey:  AVVideoCodecType.jpeg]
            if session!.canAddOutput(stillImageOutput!) {
                session!.addOutput(stillImageOutput!)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session!)
                videoPreviewLayer!.videoGravity =    AVLayerVideoGravity.resizeAspect
                videoPreviewLayer!.connection?.videoOrientation =   AVCaptureVideoOrientation.portrait
                photoPreview.layer.addSublayer(videoPreviewLayer!)
                session!.startRunning()
            }
        }
        
        drawCaptureButton()
    
    }
    
   
   
        
        
        // Do any additional setup after loading the view.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        videoPreviewLayer!.frame = photoPreview.bounds
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func drawCaptureButton() {
        
        // outer circle
        let outerCirclePath = UIBezierPath(arcCenter: CGPoint(x: view.frame.width / 2,y: photoPreview.frame.height * 0.95), radius: CGFloat(30), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let outerShapeLayer = CAShapeLayer()
        outerShapeLayer.path = outerCirclePath.cgPath
        
        //change the fill color
        outerShapeLayer.fillColor = UIColor.clear.cgColor
        //you can change the stroke color
        outerShapeLayer.strokeColor = UIColor(white: 1, alpha: 0.5).cgColor
        //you can change the line width
        outerShapeLayer.lineWidth = 5.0
        
        view.layer.addSublayer(outerShapeLayer)
        
        // inner circle
        let innerCirclePath = UIBezierPath(arcCenter: CGPoint(x: view.frame.width / 2,y: photoPreview.frame.height * 0.95), radius: CGFloat(23), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let innerShapeLayer = CAShapeLayer()
        innerShapeLayer.path = innerCirclePath.cgPath
        
        //change the fill color
        innerShapeLayer.fillColor = UIColor(white: 1, alpha: 0.5).cgColor
        //you can change the stroke color
        innerShapeLayer.strokeColor = UIColor.white.cgColor
        //you can change the line width
        innerShapeLayer.lineWidth = 3.0
        
        view.layer.addSublayer(innerShapeLayer)
        
    
    
    }
}


