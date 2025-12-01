
import Foundation

class ListViewModel: ObservableObject { //Now we can observe this class from our views
    
    //MARK: - Variables
    @Published var items: [ItemModel] = [] {
        didSet{
            saveItem()
        }
    }
    let itemsKey: String = "items_list"
    
    //MARK: - initalizer
    init() {
        getItems()
    }
    
    //MARK: - Get data
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
        let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        self.items = savedItems
    }
    
    //MARK: - List processing functions
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItem() {
        if let encodeData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.setValue(encodeData, forKey: itemsKey)
        }
    }
    
}
