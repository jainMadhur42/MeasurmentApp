//
//  MeasurmentListItem.swift
//  AROFFSETAPP
//
//  Created by Madhur on 10/10/23.
//

import SwiftUI

struct MeasurmentListItem: View {
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .center) {
                    Text("X'")
                        .fontWeight(.bold)
                    Text("12.345")
                }
                Spacer()
                VStack(alignment: .center) {
                    Text("Y'")
                        .fontWeight(.bold)
                    Text("12.345")
                }
                Spacer()
                VStack(alignment: .center) {
                    Text("Z'")
                        .fontWeight(.bold)
                    Text("12.345")
                }
            }
            .padding(.bottom)
            
            HStack {
                VStack(alignment: .center) {
                    Text("X''")
                        .fontWeight(.bold)
                    Text("12.345")
                }
                Spacer()
                VStack(alignment: .center) {
                    Text("Y''")
                        .fontWeight(.bold)
                    Text("12.345")
                }
                Spacer()
                VStack(alignment: .center) {
                    Text("Z''")
                        .fontWeight(.bold)
                    Text("12.345")
                }
            }
            
            HStack {
                Text("Distance")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Text("13.5")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding(.top)
        }
    }
}

struct MeasurmentListItem_Previews: PreviewProvider {
    static var previews: some View {
        MeasurmentListItem()
    }
}
