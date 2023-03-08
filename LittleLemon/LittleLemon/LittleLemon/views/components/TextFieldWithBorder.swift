import SwiftUI

struct TextFieldWithBorder: View {
    let textLabel: String
    let textFieldLabel: String
    let textInput: Binding<String>
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            Text(textLabel).foregroundColor(CustomColor.darkGreen)
            TextField(textFieldLabel, text: textInput)
            // option 1:
            // .padding()
            // .textFieldStyle(PlainTextFieldStyle())
            // .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
            // option 2:
                .frame(height: 52)
                .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                .cornerRadius(5)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
        }
    }
}

struct TextFieldWithBorder_Previews: PreviewProvider {
    
    static var previews: some View {
        TextFieldWithBorder(
            textLabel: "Email *",
            textFieldLabel: "Enter your email address",
            textInput: .constant(""))
    }
}
