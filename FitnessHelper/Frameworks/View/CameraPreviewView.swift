//
//  CameraPreviewView.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/22/24.
//

import SwiftUI
import AVFoundation

struct CameraPreviewView: UIViewRepresentable{
    class CameraViewFinder: UIView{
        override class var layerClass: AnyClass{
            AVCaptureVideoPreviewLayer.self
        }
        
        var viewLayer: AVCaptureVideoPreviewLayer{
            return layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> CameraViewFinder {
        let view = CameraViewFinder()
        
        view.backgroundColor = .black
        view.viewLayer.videoGravity = .resizeAspectFill
        view.viewLayer.cornerRadius = 0
        view.viewLayer.session = session
        view.viewLayer.connection?.videoRotationAngle = 0.0
        
        return view
    }
    
    func updateUIView(_ uiView: CameraViewFinder, context: Context) {
        
    }
}
