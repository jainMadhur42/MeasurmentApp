import SwiftUI

struct AddVesselInfoView: View {
    
    private var isValidationSuccessful: Bool {
        isFieldEmpty(vesselName)
        || isFieldEmpty(name)
        || textFieldValidatorEmail(email)
        || isFieldEmpty(organisation) ? false : true
    }
    @Binding var enableSaveButton: Bool
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
        Form {
            Section {
                
                TextField("Vessel Name or Unique ID"
                          , text: $vesselName
                          , onEditingChanged: { _ in
                    errorMessage = isFieldEmpty(vesselName)
                    ? "Vessel Name is empty" : ""
                })
                .autocorrectionDisabled(true)
                
                TextField("Contact Name"
                          , text: $name
                          , onEditingChanged: { _ in
                    errorMessage = isFieldEmpty(name)
                    ? "Contact Name is empty" : ""
                })
                .keyboardType(.emailAddress)
                .autocorrectionDisabled(true)
                
                TextField("Contact Email"
                          , text: $email
                          , onEditingChanged: { _ in
                    errorMessage  = textFieldValidatorEmail(email)
                    ? "Email Format is wrong" : ""
                })
                .keyboardType(.emailAddress)
                .autocorrectionDisabled(true)
                
                TextField("Trusted Node Organization/Name", text: $organisation, onEditingChanged: { _ in
                    errorMessage = isFieldEmpty(organisation)
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
        AddVesselInfoView(enableSaveButton: .constant(true)
                          , insert: { _ in
            print("Insert")
        })
    }
}

