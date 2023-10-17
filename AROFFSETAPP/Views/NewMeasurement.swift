//
//  NewMeasurement.swift
//  AROFFSETAPP
//
//  Created by Darshan Gummadi on 9/13/23.
//

import SwiftUI

struct NewMeasurement: View {
    @State private var navigateToFirstScreen = false
    
    var body: some View {
      //  NavigationView{
            ZStack{
                ThemeColor.backGround.theme.ignoresSafeArea(.all)
                VStack{
                    Text("New Measurement Notice")
                        .font(.title).fontWeight(.bold).foregroundColor(.white).multilineTextAlignment(.center)
                        .padding(.bottom,80)
                    Text("This tool does not assist with a croudsourced bathymetry data logger installation.")
                        .font(.title3).fontWeight(.bold).foregroundColor(.white).multilineTextAlignment(.center)
                        .padding(.bottom,20)
                    Text("If you do not have depth logger installed, contact your trusted node for assistance.")
                        .font(.title3).fontWeight(.bold).foregroundColor(.white).multilineTextAlignment(.center)
                        .padding(.bottom,20)
                    
                    Text("You can also visit the link below for tutorials and information about how to install some of the avilable loggers.")
                        .font(.title3).fontWeight(.bold).foregroundColor(.white).multilineTextAlignment(.center)
                    Button(action: openWeb) {
                                Text("Logger Install Resources")
                                    .padding()
                                    .background(Color.green)
                                    .font(.title)
                                    .foregroundColor(.black)
                                    .cornerRadius(10).padding(20)
                            }
                    Button(action: {
                        self.navigateToFirstScreen = true
                    }) {
                        Text("Next")
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .padding(20)
                   
//                        
//                    NavigationLink(destination:
//                                    AddVesselInfoView(vesselInfoLoader: CoreDataVesselLoader())
//                                   , isActive: $navigateToFirstScreen) {
//                         EmptyView()
//                         }
                    }
                }
                
            }
            
        }
    
    func openWeb(){
        if let url = URL(string:"https://www.marine.usf.edu/comit/"){
            UIApplication.shared.open(url)
        }
    }
}


struct NewMeasurement_Previews: PreviewProvider {
    static var previews: some View {
        NewMeasurement()
    }
}


//#Preview {
//    NewMeasurement()
//}
