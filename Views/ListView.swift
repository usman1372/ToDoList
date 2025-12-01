
import SwiftUI

struct ListView: View {
    
    //MARK: - Variables
    @EnvironmentObject var listViewModel: ListViewModel
    
    //MARK: - Views
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
            }else{
                List {
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Todo List 📝")
        .navigationBarItems(leading: EditButton(), trailing:NavigationLink(destination: {
            AddView()
        }, label: {
            Text("Add")
        })
        )
    }
}

#Preview {
    NavigationView {
        ListView()
    }
    .environmentObject(ListViewModel())
}
