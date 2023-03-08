import SwiftUI

struct OnboardingView: View {
    
    @State private var isLoggedIn = false
    
    @State private var showInvalidInputAlert = false
    @State private var errorMessage = ""
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                        EmptyView()
                    }
                    HeroSection()
                    textInputSection
                    
                    Button(action: {
                        if validateForm() {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            isLoggedIn = true
                        } else {
                            showInvalidInputAlert.toggle()
                        }
                    }) {
                        Text("Register")
                            .font(.title)
                            .foregroundColor(CustomColor.darkGreen)
                            .padding()
                            .frame(width: 300, height: 56)
                            .background(CustomColor.lemonYellow)
                            .cornerRadius(12)
                        
                    }.buttonStyle(PlainButtonStyle())
                        .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image("Logo").background(Color.white)
                    }
                }
                .toolbarBackground(Color.white, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            }
        }.alert(
            errorMessage,
            isPresented: $showInvalidInputAlert
        ) {
            Button("OK", role: .cancel) {}
        }.navigationBarBackButtonHidden(true)
            
        .onAppear {
                isLoggedIn = getLoginStatus()
            }
    }
    
    var textInputSection: some View {
        Group {
            TextFieldWithBorder(
                textLabel: "First Name *",
                textFieldLabel: "Enter your first name",
                textInput: $firstName)
            .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
            TextFieldWithBorder(
                textLabel: "Last Name *",
                textFieldLabel: "Enter your last name",
                textInput: $lastName)
            .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
            TextFieldWithBorder(
                textLabel: "Email *",
                textFieldLabel: "Enter your email address",
                textInput: $email)
            .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
        }
    }
    
    private func validateForm() -> Bool {
        let firstNameIsValid = isValid(name: firstName)
        let lastNameIsValid = isValid(name: lastName)
        let emailIsValid = isValid(email: email)
        
        guard firstNameIsValid && lastNameIsValid && emailIsValid
        else {
            var invalidFirstNameMessage = ""
            if firstName.isEmpty || !isValid(name: firstName) {
                invalidFirstNameMessage = "First name can only contain letters and must have at least 1 characters\n\n"
            }
            
            var invalidLastNameMessage = ""
            if lastName.isEmpty || !isValid(name: lastName) {
                invalidLastNameMessage = "Last name can only contain letters and must have at least 1 characters\n\n"
            }
            
            
            var invalidEmailMessage = ""
            if email.isEmpty || !isValid(email: email) {
                invalidEmailMessage = "The e-mail is invalid and cannot be blank."
            }
            
            self.errorMessage = "Found these errors in the form:\n\n \(invalidFirstNameMessage)\(invalidLastNameMessage)\(invalidEmailMessage)"
            
            return false
        }
        return true
    }
    
    func isValid(name: String) -> Bool {
        guard !name.isEmpty,
              name.count > 0
        else { return false }
        for chr in name {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == " ") ) {
                return false
            }
        }
        return true
    }
    
    func isValid(email:String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
    
    private func getLoginStatus() -> Bool {
        let defaults = UserDefaults.standard
        let savedFirstName = defaults.string(forKey: kFirstName) ?? ""
        let savedLastName = defaults.string(forKey: kLastName) ?? ""
        let savedEmail = defaults.string(forKey: kEmail) ?? ""
        
        if savedLastName.isEmpty || savedFirstName.isEmpty || savedEmail.isEmpty {
            return false
        } else {
            return true
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
