//
//  HomeRecommendedActionListModel.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/19/24.
//

import SwiftUI

struct HomeRecommendedActionListModel: View {
    let title: String
    let headLine: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack{
            Image(systemName: icon)
            
            Spacer().frame(width: 10)
            
            VStack(alignment: .leading){
                Text(headLine)
                    .font(.caption)
                
                Spacer().frame(height: 5)
                
                Text(title)
                    .fontWeight(.semibold)
            }
            
            Spacer().frame(width: 10)
            
            Image(systemName: "chevron.right.circle")
        }.padding(20)
            .background(
                color.opacity(0.6), in: RoundedRectangle(cornerRadius: 15)
        )
    }
}

#Preview {
    HomeRecommendedActionListModel(
        title: "Title",
        headLine: "headLine",
        icon: "checkmark",
        color: Color.red
    )
}
