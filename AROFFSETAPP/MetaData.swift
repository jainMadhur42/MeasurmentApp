import SwiftUI

// Step 1: Define a data model
struct UserDetails: Codable {
   
}

struct MetaData: View {
  @State private  var vesselname: String = ""
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var organization: String = ""
    
    var isvesselnameEmpty: Bool {
            return vesselname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    var isnameEmpty: Bool {
            return name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    var isemailEmpty: Bool {
            return email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    var isorganizationEmpty: Bool {
            return organization.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    
    // Step 1: Create an instance of the data model
   // @State private var userDetails = UserDetails()
   // @State private var enteredText: String = ""
    @State private var navigateToFirstScreen = false
    
    class EmailValidator: ObservableObject {
        @Published var email: String = ""
        private let emailRegex = try! NSRegularExpression(pattern: "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")

        func isValidEmail() -> Bool {
            let range = NSRange(location: 0, length: email.utf16.count)
            return emailRegex.firstMatch(in: email, options: [], range: range) != nil
        }
    }
        @StateObject private var emailValidator = EmailValidator()

    var body: some View {
        ZStack{ Color(myColor).ignoresSafeArea(.all)
            VStack{
                Text("New Measurement Metadata")
                    .font(.title).fontWeight(.bold).foregroundColor(.white).multilineTextAlignment(.center)
                    .padding(.bottom,80)
                
                TextField("Vessel Name or Unique ID", text: $vesselname)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                TextField("Contact Name", text: $name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
               /* TextField("Contact Email", text: $emailValidator.email)
                                .padding()
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)*/
                TextField("Contact Email", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                TextField("Trusted Node Organization/Name", text: $organization)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()

                /* Text(emailValidator.isValidEmail() ? "Valid Email" : "Invalid Email")
                                .foregroundColor(emailValidator.isValidEmail() ? .green : .red)
                                .padding(.top, 50) */
                
                            
                Button(action: {
                    if (self.isvesselnameEmpty || self.isnameEmpty || self.isorganizationEmpty) || self.isemailEmpty {
                        
                    }
                    else{
                        saveDetails()
                        self.navigateToFirstScreen = true
                    }
                
                }) {
                Text("Next")
                .fontWeight(.bold)
                .padding()
                .background(Color.green)
                .foregroundColor(.black)
                .cornerRadius(10)
                .padding(20)
               
                    
                NavigationLink(destination: HowTo(), isActive: $navigateToFirstScreen) {
                     EmptyView()
                     }
                }
                   
            }
        }
    }
    func saveDetails() {
        
        print("Captured User Details:")
        print("Vessel Name or Unique ID: \(vesselname)")
        print("Contact Name: \(name)")
        print("Contact Email: \(emailValidator.email)")
        print("Organization: \(organization)")
    }
    func isValidEmail(email: String) -> Bool {
            // Regular expression for validating email format
            let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: email)
        }
}

struct MetaData_Previews: PreviewProvider {
    static var previews: some View {
        MetaData()
    }
}

