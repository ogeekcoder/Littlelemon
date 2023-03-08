import SwiftUI

struct HeroSection: View {
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            Text("Little Lemon").foregroundColor(CustomColor.lemonYellow)
                .font(.system(size: 48))
                .padding(EdgeInsets(top: 8, leading: 12, bottom: 0, trailing: 0))
            
            HStack {
                VStack(alignment: HorizontalAlignment.leading) {
                    Text("Chicago")
                        .font(.system(size: 32))
                        .foregroundColor(Color.white)
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
                    Spacer()
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .foregroundColor(Color.white)
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 36, trailing: 0))
                }
                VStack {
                    Spacer()
                    Image("Hero_image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 171)
                        .cornerRadius(12)
                        .padding(EdgeInsets(top: 12, leading: 0, bottom: 28, trailing: 8))
                }
            }
            VStack(alignment: HorizontalAlignment.leading) {
                
                
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300)
        .background(CustomColor.darkGreen)
    }
}

struct HeroSection_Previews: PreviewProvider {
    static var previews: some View {
        HeroSection()
    }
}
