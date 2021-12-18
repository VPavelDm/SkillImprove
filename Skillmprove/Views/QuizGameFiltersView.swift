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
    private let onApply: () -> Void
    
    init(search: Binding<QuizGameSearch>, onApply: @escaping () -> Void) {
        self._search = search
        self._draft = State(wrappedValue: search.wrappedValue)
        self.onApply = onApply
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
                ForEach(draft.filters.indices, id: \.self) { index in
                    Toggle(draft.filters[index], isOn: $draft.toggles[index])
                    if index < draft.filters.count {
                        Divider()
                    }
                }
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
            onApply()
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Apply")
        }
    }
}

struct QuizGameFiltersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuizGameFiltersView(search: .constant(QuizGameSearch()), onApply: {})
        }
        .preferredColorScheme(.dark)
    }
}
