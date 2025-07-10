//
//  FormCardView.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import SwiftUI

struct FormCardView: View {
    let card: FormCard
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Card header
            if card.title != nil || card.subtitle != nil {
                VStack(alignment: .leading, spacing: 4) {
                    if let title = card.title {
                        Text(title)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                    
                    if let subtitle = card.subtitle {
                        Text(subtitle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            // Card content
            LazyVStack {
                ForEach(card.components, id: \.id) { component in
                    FormComponentView(component: component)
                }
            }
        }
        .padding(card.style.padding)
        .background(
            RoundedRectangle(cornerRadius: card.style.cornerRadius)
                .fill(card.style.backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: card.style.cornerRadius)
                        .stroke(
                            card.style.borderColor ?? Color.clear,
                            lineWidth: card.style.borderWidth
                        )
                )
        )
        .shadow(radius: card.style.shadowRadius)
    }
}
