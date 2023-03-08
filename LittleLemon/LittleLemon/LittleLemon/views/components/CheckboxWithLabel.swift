import SwiftUI

struct CheckboxWithLabel: View {
    @Binding var isChecked: Bool
    let label: String
    
    var body: some View {
        Button(action: {
            self.isChecked = !self.isChecked
        }) {
            HStack(alignment: .center, spacing: 10) {
                ZStack {
                    Rectangle()
                        .fill(self.isChecked ? CustomColor.darkGreen : Color.white)
                        .frame(width: 30, height: 30, alignment: .center)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(CustomColor.darkGreen, lineWidth: 1))
                    if isChecked {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.white)
                    }
                }
                Text(label).font(.system(size: 14, weight: .regular))
            }
        }
        .foregroundColor(Color.black)
    }
}

struct CheckboxWithLabel_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxWithLabel(isChecked: .constant(true), label: "Todo item")
    }
}
