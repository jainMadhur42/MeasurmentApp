//
//  MeasurmentListItem.swift
//  AROFFSETAPP
//
//  Created by Madhur on 10/10/23.
//

import SwiftUI

struct MeasurmentListItem: View {
    
    var vesselDistance: LocalVesselDistance
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(vesselDistance.date.formatedDate)
                .fontWeight(.bold)
                .padding(.bottom)
            
            HStack {
                VStack(alignment: .center) {
                    Text("X'")
                        .fontWeight(.bold)
                    Text("\(vesselDistance.x1)")
                }
                Spacer()
                VStack(alignment: .center) {
                    Text("Y'")
                        .fontWeight(.bold)
                    Text("\(vesselDistance.y1)")
                }
                Spacer()
                VStack(alignment: .center) {
                    Text("Z'")
                        .fontWeight(.bold)
                    Text("\(vesselDistance.z1)")
                }
            }
            .padding(.bottom)
            
            HStack {
                VStack(alignment: .center) {
                    Text("X''")
                        .fontWeight(.bold)
                    Text("\(vesselDistance.x2)")
                }
                Spacer()
                VStack(alignment: .center) {
                    Text("Y''")
                        .fontWeight(.bold)
                    Text("\(vesselDistance.y2)")
                }
                Spacer()
                VStack(alignment: .center) {
                    Text("Z''")
                        .fontWeight(.bold)
                    Text("\(vesselDistance.z2)")
                }
            }
            
            HStack {
                Text("Distance")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Text("\(vesselDistance.distance)")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding(.top)
        }
    }
}


extension Date {
    
    var formatedDate: String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        return dateFormatterPrint.string(from: self)
    }
}
struct MeasurmentListItem_Previews: PreviewProvider {
    static var previews: some View {
        MeasurmentListItem(vesselDistance: LocalVesselDistance(x1: 23.0
                                                               , x2: 12.0
                                                               , y1: 12.5
                                                               , y2: 23.5
                                                               , z1: 15.4
                                                               , z2: 16.6
                                                               , distance: 25.6))
    }
}
