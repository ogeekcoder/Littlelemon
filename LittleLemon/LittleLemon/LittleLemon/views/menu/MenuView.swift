import SwiftUI
import CoreData

struct MenuView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject private var viewModel = MenuModel()
    
    @State private var searchText = ""
    @State private var selectedCategory = ""
    
    var body: some View {
        NavigationView {
            VStack {
                toolbarSection
                ScrollView {
                    VStack {
                        HeroSection()
                        searchButtonSection
                        menuPillsSection
                        
                        FetchedObjects(
                            predicate: buildPredicate(),
                            sortDescriptors: buildSortDescriptors()
                        ) { (dishes: [Dish]) in
                            ForEach(dishes, id:\.self) { dish in
                                MenuItemRowView(
                                    name: dish.name ?? "",
                                    description: dish.dishDescription ?? "",
                                    price: dish.price ?? ""
                                )
                                Divider().padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                            }
                        }
                    }
                }
            }.task {
                await viewModel.getMenuData(viewContext)
            }
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
    
    var searchButtonSection: some View {
        Group {
            ZStack(alignment: Alignment.leading) {
                Rectangle().frame(height: 76)
                    .foregroundColor(CustomColor.darkGreen)
                TextField("", text: $searchText)
                    .frame(height: 48)
                    .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 6))
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 1))
                    .background(Color.white)
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
            }.padding(.top, -36)
            Rectangle().frame(height: 16)
                .foregroundColor(CustomColor.darkGreen)
                .padding(.top, -8)
        }
    }
    
    var menuPillsSection: some View {
        Group {
            HStack {
                Text("ORDER FOR DELIVERY")
                Image(systemName: "box.truck.badge.clock")
                Spacer()
            }.padding(EdgeInsets(top: 24, leading: 12, bottom: 0, trailing: 0))
            HStack {
                ButtonWithFilledColor(
                    label: "Starters",
                    backgroundColor: CustomColor.buttonBackground,
                    textColor: CustomColor.darkGreen,
                    cornerRadius: 24) {
                        // to implement
                    }
                Spacer()
                ButtonWithFilledColor(
                    label: "Mains",
                    backgroundColor: CustomColor.buttonBackground,
                    textColor: CustomColor.darkGreen,
                    cornerRadius: 24) {
                        // to implement
                    }
                Spacer()
                ButtonWithFilledColor(
                    label: "Desserts",
                    backgroundColor: CustomColor.buttonBackground,
                    textColor: CustomColor.darkGreen,
                    cornerRadius: 24) {
                        // to implement
                    }
                Spacer()
                ButtonWithFilledColor(
                    label: "Drinks",
                    backgroundColor: CustomColor.buttonBackground,
                    textColor: CustomColor.darkGreen,
                    cornerRadius: 24) {
                        // to implement
                    }
            }.padding(EdgeInsets(top: 8, leading: 12, bottom: 0, trailing: 12))
            
            Divider().padding(EdgeInsets(top: 24, leading: 12, bottom: 12, trailing: 12))
        }
    }
    
    func buildPredicate() -> NSPredicate {
        return searchText.isEmpty ?
        NSPredicate(value: true) :
        NSPredicate(format: "name CONTAINS[cd] %@", searchText)
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "name",
                             ascending: true,
                             selector: #selector(NSString.localizedStandardCompare))
        ]
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
