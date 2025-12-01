
import SwiftUI

struct AddView: View {
    
    //MARK: - Variables
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModle: ListViewModel
    @State var textFieldText: String = ""
    @State var titleAlert: String = ""
    @State var showAlert: Bool = false
    
    //MARK: - Views
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here ...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                
                Button {
                    saveBtnPressed()
                } label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
            }//end of vstack
            .padding(14)
        }//end of scrollview
        .navigationTitle("Add an Item 🖊")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    //MARK: - Button actions
    func saveBtnPressed() {
        if isTextAppropriate() {
            listViewModle.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    //MARK: - Data verification
    func isTextAppropriate() -> Bool {
        if textFieldText.count < 3 {
            titleAlert = "Item must be greater than 3 characters"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    //MARK: - Alert helper methods
    func getAlert() -> Alert {
        return Alert(title: Text(titleAlert))
    }
}

#Preview("Light Mode") {
    NavigationView {
        AddView()
    }
    .preferredColorScheme(.light)
    .environmentObject(ListViewModel())
}

#Preview("Dark Mode") {
    NavigationView {
        AddView()
    }
    .preferredColorScheme(.dark)
    .environmentObject(ListViewModel())
}
