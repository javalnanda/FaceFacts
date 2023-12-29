//
//  EditPersonView.swift
//  FaceFacts
//
//  Created by Javal Nanda on 22/12/23.
//

import PhotosUI
import SwiftUI
import SwiftData

struct EditPersonView: View {
    @Bindable var person: Person
    @Environment(\.modelContext) var modelContext
    @Binding var navigationPath: NavigationPath
    @State private var selectedItem: PhotosPickerItem?

    @Query(sort:[
        SortDescriptor(\Event.name),
        SortDescriptor(\Event.location)
    ]) var events: [Event]

    var body: some View {
        Form {
            Section {
                if let imageData = person.photo, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Label("Select a photo", systemImage: "person")
                }
            }
            Section {
                TextField("Name", text: $person.name)
                    .textContentType(.name)

                TextField("Email address", text: $person.emailAdress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }

            Section("Where did you meet them?") {
                Picker("Met at", selection: $person.metAt) {
                    Text("Unknown event")
                        .tag(Optional<Event>.none)

                    if events.isEmpty == false {
                        Divider()
                        ForEach(events) { event in
                            Text(event.name)
                                .tag(Optional(event))
                        }
                    }
                }

                Button("Add event", action: addEvent)
            }

            Section("Notes") {
                TextField("Details about this person", text: $person.details, axis: .vertical)
            }
        }
        .navigationTitle("Edit Person")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Event.self) { event in
            EditEventView(event: event)
        }
        .onChange(of: selectedItem, loadPhoto)
    }

    func addEvent() {
        let event = Event(name: "", location: "")
        modelContext.insert(event)
        navigationPath.append(event)
    }

    func loadPhoto() {
        Task { @MainActor in
            person.photo = try await selectedItem?.loadTransferable(type: Data.self)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()

        return EditPersonView(person: previewer.person, navigationPath: .constant(NavigationPath()))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview:\(error.localizedDescription)")
    }
}
