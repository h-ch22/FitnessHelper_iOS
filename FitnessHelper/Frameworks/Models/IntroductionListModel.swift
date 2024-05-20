//
//  IntroductionListModel.swift
//  FitnessHelper
//
//  Created by 하창진 on 5/19/24.
//

import SwiftUI

struct IntroductionListModel: View {
    let icon: String
    let title: String
    let contents: String
    
    var body: some View {
        HStack{
            Image(systemName: icon)
                .foregroundStyle(Color.txt)
            
            VStack{
                HStack{
                    Text(title)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.txt)
                    
                    Spacer()
                }
                
                HStack{
                    Text(contents)
                        .font(.caption)
                        .foregroundStyle(Color.txt)
                    
                    Spacer()
                }

            }
            
            Spacer()
        }
    }
}

#Preview {
    IntroductionListModel(icon: "circle.fill", title: "Title", contents: "Contents")
}
