//
//  NewMorphButtonStyle.swift
//  FitnessHelper
//
//  Created by Changjin Ha on 5/17/24.
//

import SwiftUI

struct NewMorphButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    
    let foreground: Color
    var paddingValue: CGFloat = 20
    var cornerRadius: CGFloat = 50
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(paddingValue)
            .background(
                Group {
                    if colorScheme == .light{
                        if configuration.isPressed {
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .fill(foreground)
                                .overlay(
                                    RoundedRectangle(cornerRadius: cornerRadius)
                                        .stroke(Color.gray, lineWidth: 4)
                                        .blur(radius: 4)
                                        .offset(x: 2, y: 2)
                                        .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(Color.btnStart, Color.btnEnd)))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: cornerRadius)
                                        .stroke(foreground, lineWidth: 8)
                                        .blur(radius: 4)
                                        .offset(x: -2, y: -2)
                                        .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(Color.btnEnd, Color.btnStart)))
                                )
                        } else {
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .fill(foreground)
                                .shadow(color: Color.shadowStart.opacity(0.2), radius: 10, x: 10, y: 10)
                                .shadow(color: Color.shadowEnd.opacity(0.7), radius: 10, x: -5, y: -5)
                        }
                    } else{
                        if configuration.isPressed{
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .fill(foreground)
                                .overlay(
                                    RoundedRectangle(cornerRadius: cornerRadius)
                                        .stroke(Color.black, lineWidth: 4)
                                        .blur(radius: 4)
                                        .offset(x: 2, y: 2)
                                        .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(Color.btnStart, Color.clear)))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: cornerRadius)
                                        .stroke(foreground, lineWidth: 8)
                                        .blur(radius: 4)
                                        .offset(x: -2, y: -2)
                                        .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(Color.clear, Color.btnStart)))
                                )
                        } else{
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .fill(foreground)
                                .shadow(color: Color.btnStart, radius: 10, x: -10, y: -10)
                                .shadow(color: Color.btnEnd, radius: 10, x: 10, y: 10)
                        }

                    }

                }
            )
            .animation(.easeInOut)
    }
}

struct PushButtonNewMorphStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    
    let isSelected: Bool
    let foreground: Color
    var width: CGFloat = 100
    var height: CGFloat = 100
    var paddingValue: CGFloat = 5
    var cornerRadius: CGFloat = 15
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: height)
            .padding(paddingValue)
            .background(
                Group {
                    if colorScheme == .light{
                        if configuration.isPressed || isSelected {
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .fill(foreground)
                                .overlay(
                                    RoundedRectangle(cornerRadius: cornerRadius)
                                        .stroke(Color.gray, lineWidth: 4)
                                        .blur(radius: 4)
                                        .offset(x: 2, y: 2)
                                        .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(Color.btnStart, Color.btnEnd)))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: cornerRadius)
                                        .stroke(foreground, lineWidth: 8)
                                        .blur(radius: 4)
                                        .offset(x: -2, y: -2)
                                        .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(Color.btnEnd, Color.btnStart)))
                                )
                        } else {
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .fill(foreground)
                                .shadow(color: Color.shadowStart.opacity(0.2), radius: 10, x: 10, y: 10)
                                .shadow(color: Color.shadowEnd.opacity(0.7), radius: 10, x: -5, y: -5)
                        }
                    } else{
                        if configuration.isPressed || isSelected{
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .fill(foreground)
                                .overlay(
                                    RoundedRectangle(cornerRadius: cornerRadius)
                                        .stroke(Color.black, lineWidth: 4)
                                        .blur(radius: 4)
                                        .offset(x: 2, y: 2)
                                        .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(Color.btnStart, Color.clear)))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: cornerRadius)
                                        .stroke(foreground, lineWidth: 8)
                                        .blur(radius: 4)
                                        .offset(x: -2, y: -2)
                                        .mask(RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(Color.clear, Color.btnStart)))
                                )
                        } else{
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .fill(foreground)
                                .shadow(color: Color.btnStart, radius: 10, x: -10, y: -10)
                                .shadow(color: Color.btnEnd, radius: 10, x: 10, y: 10)
                        }

                    }

                }
            )
            .animation(.easeInOut)
    }
}

struct CircleNewMorphButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    
    let foreground: Color
    let paddingValue: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(paddingValue)
            .background(
                Group {
                    if colorScheme == .light{
                        if configuration.isPressed {
                            Circle()
                                .fill(foreground)
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray, lineWidth: 4)
                                        .blur(radius: 4)
                                        .offset(x: 2, y: 2)
                                        .mask(Circle().fill(LinearGradient(Color.btnStart, Color.btnEnd)))
                                )
                                .overlay(
                                    Circle()
                                        .stroke(foreground, lineWidth: 8)
                                        .blur(radius: 4)
                                        .offset(x: -2, y: -2)
                                        .mask(Circle().fill(LinearGradient(Color.btnEnd, Color.btnStart)))
                                )
                        } else {
                            Circle()
                                .fill(foreground)
                                .shadow(color: Color.shadowStart.opacity(0.2), radius: 10, x: 10, y: 10)
                                .shadow(color: Color.shadowEnd.opacity(0.7), radius: 10, x: -5, y: -5)
                        }
                    } else{
                        if configuration.isPressed {
                            Circle()
                                .fill(foreground)
                                .overlay(
                                    Circle()
                                        .stroke(Color.black, lineWidth: 4)
                                        .blur(radius: 4)
                                        .offset(x: 2, y: 2)
                                        .mask(Circle().fill(LinearGradient(Color.btnStart, Color.btnEnd)))
                                )
                                .overlay(
                                    Circle()
                                        .stroke(foreground, lineWidth: 8)
                                        .blur(radius: 4)
                                        .offset(x: -2, y: -2)
                                        .mask(Circle().fill(LinearGradient(Color.btnEnd, Color.btnStart)))
                                )
                        } else {
                            Circle()
                                .fill(foreground)
                                .shadow(color: Color.btnStart, radius: 10, x: -10, y: -10)
                                .shadow(color: Color.btnEnd, radius: 10, x: 10, y: 10)
                        }
                    }
                }
            )
            .animation(.easeInOut)

    }
}

struct NewMorphToggleStyle: ToggleStyle {
    @Environment(\.colorScheme) var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            configuration.label
            
            Spacer()
            
            if colorScheme == .light{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(Color.background)
                    .frame(width: 51, height: 31, alignment: .center)
                    .shadow(color: Color.shadowStart.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.shadowEnd.opacity(0.7), radius: 10, x: -5, y: -5)
                    .overlay(
                        Circle()
                            .foregroundStyle(.white)
                            .padding(.all, 3)
                            .overlay(
                                Image(systemName: configuration.isOn ? "circle" : "xmark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .font(Font.title.weight(.black))
                                    .frame(width: 8, height: 8, alignment: .center)
                                    .foregroundStyle(Color.gray)
                            )
                            .shadow(color: Color.shadowStart.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.shadowEnd.opacity(0.7), radius: 10, x: -5, y: -5)
                            .offset(x: configuration.isOn ? 11 : -11, y: 0)
                            .animation(Animation.linear(duration: 0.1))
                    )
                    .onTapGesture {
                        configuration.isOn.toggle()
                    }
            } else{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(Color.background)
                    .frame(width: 51, height: 31, alignment: .center)
                    .shadow(color: Color.btnStart, radius: 10, x: -10, y: -10)
                    .shadow(color: Color.btnEnd, radius: 10, x: 10, y: 10)
                    .overlay(
                        Circle()
                            .foregroundStyle(.white)
                            .padding(.all, 3)
                            .overlay(
                                Image(systemName: configuration.isOn ? "circle" : "xmark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .font(Font.title.weight(.black))
                                    .frame(width: 8, height: 8, alignment: .center)
                                    .foregroundStyle(Color.gray)
                            )
                            .shadow(color: Color.btnStart, radius: 10, x: -10, y: -10)
                            .shadow(color: Color.btnEnd, radius: 10, x: 10, y: 10)
                            .offset(x: configuration.isOn ? 11 : -11, y: 0)
                            .animation(Animation.linear(duration: 0.1))
                    )
                    .onTapGesture {
                        configuration.isOn.toggle()
                    }
            }
        }
    }
}

#Preview{
    ZStack{
        Color.background.ignoresSafeArea(.all, edges: [.top, .bottom])
        
        HStack{
            Button(action: {}){
                Text("BUTTON")
                    .foregroundStyle(Color.txt)
            }
                .buttonStyle(NewMorphButtonStyle(foreground: Color.background))
            
            Button(action: {}){
                Image(systemName: "heart.fill")
                    .foregroundStyle(Color.txt)
            }.buttonStyle(CircleNewMorphButtonStyle(foreground: Color.background, paddingValue: 20))
        }
    }
}
