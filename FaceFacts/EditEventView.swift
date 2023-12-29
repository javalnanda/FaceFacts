//
//  EditEventViw.swift
//  FaceFacts
//
//  Created by Javal Nanda on 22/12/23.
//

import SwiftUI

struct EditEventView: View {
    @Bindable var event: Event

    var body: some View {
        Form {
            TextField("Name of event", text: $event.name)
            TextField("location", text: $event.location)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()

        return EditEventView(event: previewer.event)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview:\(error.localizedDescription)")
    }
}
