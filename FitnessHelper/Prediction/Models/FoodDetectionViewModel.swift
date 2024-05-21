//
//  FoodDetectionViewModel.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/22/24.
//

import Foundation
import AVFoundation
import SwiftUI

class FoodDetectionViewModel: ObservableObject{
    @Published var flashMode = 0
    @Published var flashIcon = "bolt.badge.automatic.fill"
    @Published var showShutterEffect = false
    @Published var currentZoomFactor: CGFloat = 1.0

    private let model: CameraHelper
    
    let session: AVCaptureSession
    let cameraPreview: AnyView
    let hapticImpact = UIImpactFeedbackGenerator()
    
    private var lastScale: CGFloat = 1.0
    
    init(){
        model = CameraHelper()
        session = model.session
        cameraPreview = AnyView(CameraPreviewView(session: session))
    }
    
    func config(){
        model.requestPermission()
    }
    
    func switchFlash(){
        switch flashMode{
        case 0:
            model.flashmode = .on
            flashMode = 1
            flashIcon = "bolt.fill"
            
        case 1:
            model.flashmode = .off
            flashMode = 2
            flashIcon = "bolt.slash.fill"
            
        case 2:
            model.flashmode = .auto
            flashMode = 0
            flashIcon = "bolt.badge.automatic.fill"
            
        default: break
        }
    }
    
    func capture(){
        hapticImpact.impactOccurred()
        
        withAnimation(.easeInOut(duration: 0.1)){
            showShutterEffect = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            withAnimation(.easeInOut(duration: 0.1)){
                self.showShutterEffect = false
            }
        }
        model.capture()
    }
    
    func zoomInit(){
        lastScale = 1.0
    }
    
    func reset(){
        lastScale = 1.0
        currentZoomFactor = 1.0
        model.zoom(1.0)
    }
    
    func zoom(factor: CGFloat){
        let delta = factor / lastScale
        lastScale = factor
        
        let newScale = min(max(currentZoomFactor * delta, 1), 5)
        model.zoom(newScale)
        currentZoomFactor = newScale
    }
    
    func changeCamera(){
        model.switchCamera()
    }
}
