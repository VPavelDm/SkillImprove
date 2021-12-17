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
    
    var body: some View {
        NavigationView {
            Text("Hello, World!")
                .navigationTitle("Filters")
                .navigationBarTitleDisplayMode(.inline)
                .disableNavigationBarTransparancy()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LinearGradient(colors: [.purple, .cyan], startPoint: .top, endPoint: .bottom)
                )
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
        }
    }
}

struct QuizGameFiltersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuizGameFiltersView(search: .constant(QuizGameSearch()))
        }
    }
}
