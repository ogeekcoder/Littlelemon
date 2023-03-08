import SwiftUI

struct LittleLemonTitleBar: View {
    let action: () -> Void = {}
    
    var body: some View {
        ZStack {
            Image("Logo")
            HStack() {
                Spacer()
                Image("Profile")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 24))
            }
        }
    }
}

struct LittleLemonTitleBar_Previews: PreviewProvider {
    static var previews: some View {
        LittleLemonTitleBar()
    }
}
