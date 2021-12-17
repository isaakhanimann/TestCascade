import SwiftUI

struct ContentView: View {

    @FetchRequest(
        entity: File.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \File.creationDate, ascending: false) ]
    ) var files: FetchedResults<File>

    @FetchRequest(
        entity: Child.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \Child.name, ascending: false) ]
    ) var children: FetchedResults<Child>

    var body: some View {
        NavigationView {
            List {
                Button("Decode and save file", action: PersistenceController.shared.decodeAndSaveFile)
                Button("Delete oldest file", action: PersistenceController.shared.deleteOldestFile)
                Section(header: Text("Files")) {
                    ForEach(files) { file in
                        HStack {
                            Text(file.creationDate ?? Date(), style: .date)
                            Text(file.creationDate ?? Date(), style: .time)
                        }
                    }
                }
                Section(header: Text("Children")) {
                    ForEach(children) { child in
                        if child.parent == nil {
                            Text("\(child.name ?? "Unknown") has no parent")
                        } else {
                            Text("\(child.name ?? "Unknown") has parent")
                        }
                    }
                }
                Section(header: Text("Oldest file children")) {
                    ForEach(files.first?.children?.allObjects as? [Child] ?? []) { child in
                        if child.parent == nil {
                            Text("\(child.name ?? "Unknown") has no parent")
                        } else {
                            Text("\(child.name ?? "Unknown") has parent")
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.viewContext)
            .accentColor(Color.blue)
    }
}
