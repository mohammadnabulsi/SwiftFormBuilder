//
//  SpacerView.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import SwiftUI

struct SpacerView: View {
    let spacer: FormSpacer
    
    var body: some View {
        if let height = spacer.height, let width = spacer.width {
            Color.clear
                .frame(width: width, height: height)
        } else if let height = spacer.height {
            Color.clear
                .frame(height: height)
        } else if let width = spacer.width {
            Color.clear
                .frame(width: width)
        } else {
            Spacer()
        }
    }
}
