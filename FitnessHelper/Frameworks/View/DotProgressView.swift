//
//  DotProgressView.swift
//  FitnessHelper
//
//  Created by Changjin Ha on 5/17/24.
//

import SwiftUI

struct DotProgressView: View {
    var width: CGFloat = 8
    @State private var y: CGFloat = 0
    
    var body: some View {
        HStack{
            Dot(width: width, y: y)
                .animation(.easeInOut(duration: 0.5).repeatForever().delay(0), value: y)
            Dot(width: width, y: y)
                .animation(.easeInOut(duration: 0.5).repeatForever().delay(0.2), value: y)
            Dot(width: width, y: y)
                .animation(.easeInOut(duration: 0.5).repeatForever().delay(0.4), value: y)
        }
        .onAppear{y = -10}
    }
}

#Preview {
    DotProgressView()
}
