//
//  CameraHelper.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/22/24.
//

import Foundation
import AVFoundation

class CameraHelper: NSObject, ObservableObject{
    var session = AVCaptureSession()
    var videoDeviceInput: AVCaptureDeviceInput!
    var photoData = Data(count: 0)
    var flashmode: AVCaptureDevice.FlashMode = .auto
    
    let output = AVCapturePhotoOutput()
    
    func setup(){
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back){
            do{
                videoDeviceInput = try AVCaptureDeviceInput(device: device)
                
                if session.canAddInput(videoDeviceInput){
                    session.addInput(videoDeviceInput)
                }
                
                if session.canAddOutput(output){
                    session.addOutput(output)
                    output.isHighResolutionCaptureEnabled = true
                    output.maxPhotoQualityPrioritization = .quality
                }
                
                session.startRunning()
            } catch{
                print(error)
            }
        }
    }
    
    func requestPermission(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { [weak self] authStatus in
                if authStatus{
                    DispatchQueue.main.async{
                        self?.setup()
                    }
                }
            })
            
        case .restricted: break
            
        case .authorized: setup()
            
        default: print("Permission denied.")
        }
    }
    
    func capture(){
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = self.flashmode
        self.output.capturePhoto(with: photoSettings, delegate: self)
    }
    
    func zoom(_ zoom: CGFloat){
        let factor = zoom < 1 ? 1 : zoom
        let device = self.videoDeviceInput.device
        
        do{
            try device.lockForConfiguration()
            device.videoZoomFactor = factor
            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    
    func switchCamera(){
        let currentPosition = self.videoDeviceInput.device.position
        var preferredPosition = AVCaptureDevice.Position.back
        
        switch currentPosition {
        case .unspecified, .front:
            preferredPosition = .back
            
        case .back:
            preferredPosition = .front
            
        @unknown default:
            preferredPosition = .back
        }
        
        if let videoDevice = AVCaptureDevice
            .default(.builtInWideAngleCamera, for: .video, position: preferredPosition){
            do{
                let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
                
                self.session.beginConfiguration()
                
                if let inputs = session.inputs as? [AVCaptureDeviceInput]{
                    for input in inputs{
                        session.removeInput(input)
                    }
                }
                
                if self.session.canAddInput(videoDeviceInput){
                    self.session.addInput(videoDeviceInput)
                    self.videoDeviceInput = videoDeviceInput
                } else{
                    self.session.addInput(self.videoDeviceInput)
                }
                
                if let connection = self.output.connection(with: .video){
                    if connection.isVideoStabilizationSupported{
                        connection.preferredVideoStabilizationMode = .auto
                    }
                }
                
                output.isHighResolutionCaptureEnabled = true
                output.maxPhotoQualityPrioritization = .quality
                
                self.session.commitConfiguration()
            } catch{
                print(error)
            }
        }
    }
}

extension CameraHelper: AVCapturePhotoCaptureDelegate{
    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: (any Error)?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
    }
}
