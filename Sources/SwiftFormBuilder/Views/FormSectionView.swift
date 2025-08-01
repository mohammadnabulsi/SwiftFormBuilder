//
//  FormSectionView.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUI

struct FormSectionView: View {
    let section: FormSection
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let title = section.title {
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 8)
            }
            
            // Render all components
            ForEach(section.components, id: \.id) { component in
                FormComponentView(component: component)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
        )
    }
}
