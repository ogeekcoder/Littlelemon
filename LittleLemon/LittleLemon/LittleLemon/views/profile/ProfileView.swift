import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kPhoneNumber = "phone number key"

let kOrderStatusNotification = "order status notification key"
let kPasswordChangesNotification = "password changes notification key"
let kSpecialOfferNotification = "special offer notification key"
let kNewsLetterNotification = "news letter notification key"


struct ProfileView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @State private var showInvalidInputAlert = false
    @State private var errorMessage = ""
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    
    @State private var orderStatusNotification: Bool = false
    @State private var passwordChangesNotification: Bool = false
    @State private var specialOfferNotification: Bool = false
    @State private var newsLetterNotification: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                toolbarSection
                
                ScrollView {
                    VStack {
                        avatarSection
                        textInputSection
                        notificationSection
                        bottomButtonsSection
                    }
                }
            }
        }.onAppear() {
            loadUserData()
        }
    }
    
    var toolbarSection: some View {
        ZStack {
            Image("Logo")
            HStack() {
                Spacer()
                NavigationLink(destination: ProfileView()) {
                    Image("profile-image-placeholder")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 24))
                }
            }
        }
    }
    
    var avatarSection: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            Text("Personal information")
                .font(.system(size: 18, weight: .regular))
                .padding(EdgeInsets(top: 24, leading: 0, bottom: 8, trailing: 0))
            Text("Avatar").font(.system(size: 14, weight: .regular))
            HStack(alignment: VerticalAlignment.center) {
                Image("profile-image-placeholder")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                ButtonWithFilledColor(
                    label: "Change",
                    backgroundColor: CustomColor.darkGreen,
                    textColor: Color.white,
                    cornerRadius: 8,
                    action: {})
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                ButtonWithBorder(label: "Remove", action: {})
                Spacer()
            }
        }.padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
    }
    
    var textInputSection: some View {
        Group {
            TextFieldWithBorder(
                textLabel: "First name",
                textFieldLabel: "Enter your first name",
                textInput: $firstName)
            .padding(EdgeInsets(top: 12, leading: 24, bottom: 0, trailing: 24))
            TextFieldWithBorder(
                textLabel: "Last name",
                textFieldLabel: "Enter your last name",
                textInput: $lastName)
            .padding(EdgeInsets(top: 12, leading: 24, bottom: 0, trailing: 24))
            TextFieldWithBorder(
                textLabel: "Email",
                textFieldLabel: "Enter your email address",
                textInput: $email)
            .padding(EdgeInsets(top: 12, leading: 24, bottom: 0, trailing: 24))
            TextFieldWithBorder(
                textLabel: "Phone number",
                textFieldLabel: "Enter your phone number",
                textInput: $phoneNumber)
            .padding(EdgeInsets(top: 12, leading: 24, bottom: 0, trailing: 24))
        }
    }
    
    var notificationSection: some View {
        HStack {
            VStack(alignment: HorizontalAlignment.leading) {
                Text("Email Notification")
                    .font(.system(size: 18, weight: .regular))
                    .padding(EdgeInsets(top: 24, leading: 24, bottom: 0, trailing: 0))
                CheckboxWithLabel(isChecked: $orderStatusNotification, label: "Order status")
                    .padding(EdgeInsets(top: 4, leading: 24, bottom: 0, trailing: 24))
                CheckboxWithLabel(isChecked: $passwordChangesNotification, label: "Password changes")
                    .padding(EdgeInsets(top: 4, leading: 24, bottom: 0, trailing: 24))
                CheckboxWithLabel(isChecked: $specialOfferNotification, label: "Special offers")
                    .padding(EdgeInsets(top: 4, leading: 24, bottom: 0, trailing: 24))
                CheckboxWithLabel(isChecked: $newsLetterNotification, label: "Newsletter")
                    .padding(EdgeInsets(top: 4, leading: 24, bottom: 0, trailing: 24))
            }
            Spacer()
        }
    }
    
    var bottomButtonsSection: some View {
        Group {
            Button(action: {
                resetUserData()
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Log out")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(CustomColor.darkGreen)
                    .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                    .frame(maxWidth: .infinity)
                    .background(CustomColor.lemonYellow)
                    .cornerRadius(5)
                
            }
            .buttonStyle(PlainButtonStyle())
            .padding(EdgeInsets(top: 24, leading: 24, bottom: 48, trailing: 24))
            HStack {
                ButtonWithBorder(label: "Discard changes", action: {
                    loadUserData()
                })
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 24))
                ButtonWithFilledColor(
                    label: "Save changes",
                    backgroundColor: CustomColor.darkGreen,
                    textColor: Color.white,
                    cornerRadius: 8
                ) {
                    saveUserData()
                }
            }
        }
    }
    
    private func resetUserData() {
        let defaults = UserDefaults.standard
        defaults.set("", forKey: kFirstName)
        defaults.set("", forKey: kLastName)
        defaults.set("", forKey: kEmail)
        defaults.set("", forKey: kPhoneNumber)
        
        defaults.set(false, forKey: kOrderStatusNotification)
        defaults.set(false, forKey: kPasswordChangesNotification)
        defaults.set(false, forKey: kSpecialOfferNotification)
        defaults.set(false, forKey: kNewsLetterNotification)
    }
    
    private func saveUserData() {
        let defaults = UserDefaults.standard
        defaults.set(firstName, forKey: kFirstName)
        defaults.set(lastName, forKey: kLastName)
        defaults.set(email, forKey: kEmail)
        defaults.set(phoneNumber, forKey: kPhoneNumber)
        
        defaults.set(orderStatusNotification, forKey: kOrderStatusNotification)
        defaults.set(passwordChangesNotification, forKey: kPasswordChangesNotification)
        defaults.set(specialOfferNotification, forKey: kSpecialOfferNotification)
        defaults.set(newsLetterNotification, forKey: kNewsLetterNotification)
    }
    
    private func loadUserData() {
        let defaults = UserDefaults.standard
        let savedFirstName = defaults.string(forKey: kFirstName) ?? ""
        let savedLastName = defaults.string(forKey: kLastName) ?? ""
        let savedEmail = defaults.string(forKey: kEmail) ?? ""
        let savedPhoneNumber = defaults.string(forKey: kPhoneNumber) ?? ""
        
        let savedOrderStatusNotification = defaults.bool(forKey: kOrderStatusNotification)
        let savedPasswordChangesNotification = defaults.bool(forKey: kPasswordChangesNotification)
        let savedSpecialOfferNotification = defaults.bool(forKey: kSpecialOfferNotification)
        let savedNewsLetterNotification = defaults.bool(forKey: kNewsLetterNotification)
        
        firstName = savedFirstName
        lastName = savedLastName
        email = savedEmail
        phoneNumber = savedPhoneNumber
        
        orderStatusNotification = savedOrderStatusNotification
        passwordChangesNotification = savedPasswordChangesNotification
        specialOfferNotification = savedSpecialOfferNotification
        newsLetterNotification = savedNewsLetterNotification
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
