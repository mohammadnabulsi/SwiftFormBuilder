//
//  TextView.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import SwiftUI

struct TextView: View {
    let text: FormText
    
    var body: some View {
        Text(text.text)
            .font(text.font)
            .foregroundColor(text.color)
            .multilineTextAlignment(text.alignment)
    }
}
