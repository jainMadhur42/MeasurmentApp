import SwiftUI

struct MetaData: View {
    
    private var isValidationSuccessful: Bool {
        isFieldEmpty(vesselName)
        || isFieldEmpty(name)
        || textFieldValidatorEmail(email)
        || isFieldEmpty(organisation) ? false : true
    }
    @State private var errorMessage: String = ""
    @State private var vesselName: String = ""
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var organisation: String = ""
    @AppStorage(Constants.activeVessel) private var activeVesselInfo = UUID().uuidString
    
    private func isFieldEmpty(_ field: String) -> Bool {
        return field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
   
    @State private var navigateToFirstScreen = false
    var vesselInfoLoader: VesselInfoLoader
    
    var body: some View {
        ZStack {
            Color(myColor)
                .ignoresSafeArea(.all)
            VStack{
                Text("New Measurement Metadata")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom,80)
                
                TextField("Vessel Name or Unique ID"
                            , text: $vesselName
                            , onEditingChanged: { _ in
                                errorMessage = isFieldEmpty(vesselName)
                                        ? "Vessel Name is empty" : ""
                            })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocorrectionDisabled(true)
                
                TextField("Contact Name"
                          , text: $name
                          , onEditingChanged: { _ in
                                errorMessage = isFieldEmpty(name)
                                        ? "Contact Name is empty" : ""
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.emailAddress)
                .autocorrectionDisabled(true)
                
                TextField("Contact Email"
                          , text: $email
                          , onEditingChanged: { _ in
                                errorMessage  = textFieldValidatorEmail(email)
                    ? "Email Format is wrong" : ""
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.emailAddress)
                .autocorrectionDisabled(true)
                
                TextField("Trusted Node Organization/Name", text: $organisation, onEditingChanged: { _ in
                    errorMessage = isFieldEmpty(organisation)
                            ? "Organisation is empty" : ""
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.namePhonePad)
                .autocorrectionDisabled(true)

                Text(isValidationSuccessful ? "" : errorMessage)
                    .foregroundColor(.white)
                Button {
                    saveDetails()
                    self.navigateToFirstScreen.toggle()
                } label: {
                    Text("Next")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(isValidationSuccessful ? .black : .gray)
                        .cornerRadius(10)
                        .padding(20)
                }
                .disabled(!isValidationSuccessful)
            }
            NavigationLink(destination: ARView(), isActive: $navigateToFirstScreen) {
                
            }
        }
    }
    
    private func saveDetails() {
        print(activeVesselInfo.description)
        let localVesselInfo = LocalVesselInfo(id: UUID()
                                               , contactEmail: email
                                               , contactPersonName: name
                                               , vesselName: vesselName
                                               , organisation: organisation)
        vesselInfoLoader.insert(vesselInfo: localVesselInfo, completion: { result in
            switch result {
            case .success(let uuid):
                activeVesselInfo = uuid.uuidString
            case .failure(let error):
                print("error Occurred \(error)")
            }

        })
    }
    
    private func textFieldValidatorEmail(_ string: String) -> Bool {
            if string.count > 100 {
                return false
            }
            let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" // short format
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
            return !emailPredicate.evaluate(with: string)
    }
}

struct MetaData_Previews: PreviewProvider {
    static var previews: some View {
        MetaData(vesselInfoLoader: LocalVesselLoader())
    }
}

