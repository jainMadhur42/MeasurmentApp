//
//  MeasurmentList.swift
//  AROFFSETAPP
//
//  Created by Madhur on 10/10/23.
//

import SwiftUI

struct MeasurmentList: View {

    var body: some View {
        List {
            MeasurmentListItem()
            MeasurmentListItem()
            MeasurmentListItem()
            MeasurmentListItem()
        }
    }
}

struct MeasurmentList_Previews: PreviewProvider {
    static var previews: some View {
        MeasurmentList()
    }
}
