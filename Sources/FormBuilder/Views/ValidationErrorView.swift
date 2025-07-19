//
//  ValidationErrorView.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import SwiftUI

struct ValidationErrorView: View {
    let errors: [ValidationError]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(errors, id: \.localizedDescription) { error in
                HStack(spacing: 4) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.caption)
                        .foregroundColor(.red)
                    
                    Text(error.localizedDescription)
                        .font(.caption)
                        .foregroundColor(.red)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}
