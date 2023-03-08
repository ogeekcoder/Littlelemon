import SwiftUI

struct Home: View {
    var body: some View {
        TabView {
            MenuView()
                .tabItem({
                    Label("Menu", systemImage: "menucard")
                })
            ProfileView()
                .tabItem({
                    Label("Profile", systemImage: "square.and.pencil")
                })
        }.navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
