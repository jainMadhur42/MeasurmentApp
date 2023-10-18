import SwiftUI

struct AddVesselInfoView: View {
    
    private var isValidationSuccessful: Bool {
        isFieldEmpty(vesselInfo.vesselName)
        || isFieldEmpty(vesselInfo.contactPersonName)
        || textFieldValidatorEmail(vesselInfo.contactEmail)
        || isFieldEmpty(vesselInfo.organisation) ? false : true
    }
    
    @Binding var enableSaveButton: Bool
    @State private var errorMessage: String = ""
    @Binding var vesselInfo: LocalVesselInfo
    
    private func isFieldEmpty(_ field: String) -> Bool {
        return field.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    var insert: (LocalVesselInfo) -> Void

    var body: some View {
        Form {
            Section {
                
                TextField("Vessel Name or Unique ID"
                          , text: $vesselInfo.vesselName
                          , onEditingChanged: { _ in
                    errorMessage = isFieldEmpty(vesselInfo.vesselName)
                    ? "Vessel Name is empty" : ""
                })
                .autocorrectionDisabled(true)
                
                TextField("Contact Name"
                          , text: $vesselInfo.contactPersonName
                          , onEditingChanged: { _ in
                    errorMessage = isFieldEmpty(vesselInfo.contactPersonName)
                    ? "Contact Name is empty" : ""
                })
                .keyboardType(.emailAddress)
                .autocorrectionDisabled(true)
                
                TextField("Contact Email"
                          , text: $vesselInfo.contactEmail
                          , onEditingChanged: { _ in
                    errorMessage  = textFieldValidatorEmail(vesselInfo.contactEmail)
                    ? "Email Format is wrong" : ""
                })
                .keyboardType(.emailAddress)
                .autocorrectionDisabled(true)
                
                TextField("Trusted Node Organization/Name", text: $vesselInfo.organisation
                          , onEditingChanged: { _ in
                    errorMessage = isFieldEmpty(vesselInfo.organisation)
                    ? "Organisation is empty" : ""
                })
                .keyboardType(.namePhonePad)
                .autocorrectionDisabled(true)

            }
            header: {
                Text("Add New Vessel")
                    .multilineTextAlignment(.leading)
                    .font(.headline)
            } footer: {
                Text(isValidationSuccessful ? "" : errorMessage)
                    .foregroundColor(.red)
            }
        }
        .onChange(of: isValidationSuccessful) { newValue in
            enableSaveButton = newValue
        }
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
        AddVesselInfoView(enableSaveButton: .constant(true)
                          , vesselInfo: .constant(LocalVesselLoader.vessels[0])
                          , insert: { _ in
            print("Insert")
        })
    }
}

