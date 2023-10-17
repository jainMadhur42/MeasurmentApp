import SwiftUI

struct AddVesselInfoView: View {
    
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
    
    
    private func isFieldEmpty(_ field: String) -> Bool {
        return field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    var insert: (LocalVesselInfo) -> Void

    var body: some View {
        ZStack {
            Rectangle()
                .fill(ThemeColor.backGround.theme)
                .accentColor(ThemeColor.backGround.theme)
                .ignoresSafeArea(.all)
            VStack(spacing: 24) {
                Text("Add New Vessel")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 80)
                    
                TextField("Vessel Name or Unique ID"
                            , text: $vesselName
                            , onEditingChanged: { _ in
                                errorMessage = isFieldEmpty(vesselName)
                                        ? "Vessel Name is empty" : ""
                            })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocorrectionDisabled(true)
                
                TextField("Contact Name"
                          , text: $name
                          , onEditingChanged: { _ in
                                errorMessage = isFieldEmpty(name)
                                        ? "Contact Name is empty" : ""
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocorrectionDisabled(true)
                
                TextField("Contact Email"
                          , text: $email
                          , onEditingChanged: { _ in
                                errorMessage  = textFieldValidatorEmail(email)
                    ? "Email Format is wrong" : ""
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocorrectionDisabled(true)
                
                TextField("Trusted Node Organization/Name", text: $organisation, onEditingChanged: { _ in
                    errorMessage = isFieldEmpty(organisation)
                            ? "Organisation is empty" : ""
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.namePhonePad)
                .autocorrectionDisabled(true)

                Text(isValidationSuccessful ? "" : errorMessage)
                    .foregroundColor(.white)
                
                VStack(alignment: .center) {
                    Button {
                        saveDetails()
                    } label: {
                        Text("Next")
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(isValidationSuccessful ? .black : .gray)
                            .cornerRadius(10)
                    }
                    .disabled(!isValidationSuccessful)
                }
            }
            .padding(.top)
        }
        .background(ThemeColor.backGround.theme)
        .ignoresSafeArea(.all)
    }
    
    private func saveDetails() {
        let localVesselInfo = LocalVesselInfo(id: UUID()
                                               , contactEmail: email
                                               , contactPersonName: name
                                               , vesselName: vesselName
                                               , organisation: organisation)
        self.insert(localVesselInfo)
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
        AddVesselInfoView(insert: { _ in
            print("Insert")
        })
    }
}

