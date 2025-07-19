//
//  DividerView.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import SwiftUI

struct DividerView: View {
    let divider: FormDivider
    
    var body: some View {
        Rectangle()
            .fill(divider.color)
            .frame(height: divider.thickness)
            .padding(divider.padding)
    }
}
