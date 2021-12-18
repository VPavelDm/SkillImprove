//
//  QuizGameFiltersView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 17.12.21.
//

import SwiftUI

struct QuizGameFiltersView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var search: QuizGameSearch
    @State private var draft: QuizGameSearch
    
    init(search: Binding<QuizGameSearch>) {
        self._search = search
        self._draft = State(wrappedValue: search.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Filters")
                .navigationBarTitleDisplayMode(.inline)
                .disableNavigationBarTransparancy()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LinearGradient(colors: [.purple, .cyan], startPoint: .top, endPoint: .bottom)
                )
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) { cancel }
                    ToolbarItem(placement: .confirmationAction) { apply }
                }
        }
    }
    var content: some View {
        VStack {
            VStack {
                Toggle("iOS", isOn: $draft.iOS)
                Divider()
                Toggle("UIKit", isOn: $draft.uiKit)
                Divider()
                Toggle("SwiftUI", isOn: $draft.swiftUI)
                Divider()
                Toggle("Obj-C", isOn: $draft.objC)
            }
            .foregroundColor(.white)
            .font(.system(size: 18, weight: .semibold))
            .padding()
            .cornerRadius(16)
            Spacer()
        }
        .padding()
    }
    var cancel: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Cancel")
        }
    }
    var apply: some View {
        Button {
            search = draft
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Apply")
        }
    }
}

struct QuizGameFiltersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuizGameFiltersView(search: .constant(QuizGameSearch()))
        }
        .preferredColorScheme(.dark)
    }
}
