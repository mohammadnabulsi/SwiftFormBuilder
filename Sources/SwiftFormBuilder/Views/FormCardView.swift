//
//  FormCardView.swift
//  SwiftFormBuilder
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
                    }
                    
                    if let subtitle = card.subtitle {
                        Text(subtitle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            // Card content - use VStack for better performance
            VStack(spacing: 12) {
                ForEach(card.components, id: \.id) { component in
                    FormComponentView(component: component)
                }
            }
        }
        .padding(card.style.padding)
        .background(
            RoundedRectangle(cornerRadius: card.style.cornerRadius)
                .fill(card.style.backgroundColor)
                .shadow(radius: card.style.shadowRadius)
        )
        .overlay(
            RoundedRectangle(cornerRadius: card.style.cornerRadius)
                .strokeBorder(
                    card.style.borderColor ?? Color.clear,
                    lineWidth: card.style.borderWidth
                )
        )
    }
}
