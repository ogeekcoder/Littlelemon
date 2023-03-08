import SwiftUI

struct ButtonWithFilledColor: View {
    
    let label: String
    let backgroundColor: Color
    let textColor: Color
    let cornerRadius: CGFloat
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(textColor)
                .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 12))
                .background(backgroundColor)
                .cornerRadius(cornerRadius)
        }
    }
}

struct ButtonWithFilledColor_Previews: PreviewProvider {
    static var previews: some View {
        ButtonWithFilledColor(
            label: "Save changes",
            backgroundColor: CustomColor.darkGreen,
            textColor: Color.white,
            cornerRadius: 8,
            action: {})
    }
}
