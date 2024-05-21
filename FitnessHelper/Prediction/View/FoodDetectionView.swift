//
//  FoodDetectionView.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/22/24.
//

import SwiftUI

struct FoodDetectionView: View {
    @ObservedObject var viewModel = FoodDetectionViewModel()
    @Environment(\.dismiss) var dismiss
        
    var body: some View {
        ZStack{
            CameraPreviewView(session: viewModel.session)
                .ignoresSafeArea(.all, edges: [.top, .bottom])
                .onAppear {
                    viewModel.config()
                }
                .gesture(MagnificationGesture()
                         
                    .onChanged { value in
                        viewModel.zoom(factor: value)
                    }
                         
                    .onEnded{ _ in
                        viewModel.zoomInit()
                    })
            
            VStack(alignment: .leading){
                Button(action: {
                    dismiss()
                }){
                    Image(systemName: "xmark")
                        .foregroundStyle(Color.white)
                }.padding([.horizontal], 20)
                    .padding([.vertical], 10)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
                
                Spacer()
                
                if viewModel.currentZoomFactor != 1.0{
                    HStack{
                        Spacer()
                        
                        Button(action: {
                            viewModel.reset()
                        }){
                            Text(String("\(String(format: "%.2f", viewModel.currentZoomFactor))x"))
                                .foregroundStyle(Color.white)
                        }
                        
                        Spacer()
                        
                    }.padding(15).background(.ultraThinMaterial, in: Circle())

                    Spacer().frame(height: 20)
                }
                
                HStack{
                    Button(action: {
                        viewModel.changeCamera()
                    }){
                        Image(systemName: "camera.rotate.fill")
                            .font(.title)
                            .foregroundStyle(Color.gray)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.capture()
                    }){
                        Image(systemName: "checkmark")
                            .font(.title)
                            .foregroundStyle(Color.white)
                    }.padding(20)
                        .background(.ultraThinMaterial, in: Circle())
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.switchFlash()
                    }){
                        Image(systemName: viewModel.flashIcon)
                            .font(.title)
                            .foregroundStyle(Color.gray)
                    }
                }
            }.padding(20)
        }.opacity(viewModel.showShutterEffect ? 0 : 1)
    }
}

#Preview {
    FoodDetectionView()
}
