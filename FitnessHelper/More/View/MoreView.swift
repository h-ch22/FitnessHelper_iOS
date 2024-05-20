//
//  MoreView.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/19/24.
//

import SwiftUI

struct MoreView: View {
    var body: some View {
        ZStack{
            Color.background.ignoresSafeArea(.all, edges: [.top, .bottom])
            
            VStack{
                
            }.padding(20)
                .navigationTitle(Text("More"))
        }
    }
}

#Preview {
    MoreView()
}
