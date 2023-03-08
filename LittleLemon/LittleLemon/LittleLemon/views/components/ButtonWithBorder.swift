import SwiftUI

struct ButtonWithBorder: View {
    let label: String
    let action: () -> Void
    
    let backgroundColor: Color = Color.white
    let textColor: Color = CustomColor.darkGreen
    let borderStrokeColor: Color = CustomColor.darkGreen
    let cornerRadius: CGFloat = 8
    let borderStrokeWidth: CGFloat = 2
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(textColor)
                .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
                .background(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(borderStrokeColor, lineWidth: borderStrokeWidth))
        }
    }
}

struct ButtonWithBorder_Previews: PreviewProvider {
    static var previews: some View {
        ButtonWithBorder(label: "Discard changes", action: {})
    }
}
