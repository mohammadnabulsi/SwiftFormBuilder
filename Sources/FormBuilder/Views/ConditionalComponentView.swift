//
//  ConditionalComponentView.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import SwiftUI

struct ConditionalComponentView: View {
    let component: ConditionalFormComponent
    @Environment(\.formStateManager) private var stateManager
    @State private var isVisible: Bool = false
    @State private var hasAppeared: Bool = false
    
    var body: some View {
        Group {
            if isVisible {
                VStack {
                    ForEach(component.components, id: \.id) { component in
                        FormComponentView(component: component)
                            .transition(.asymmetric(
                                insertion: .opacity.combined(with: .scale(scale: 0.95)),
                                removal: .opacity
                            ))
                    }
                }
            }
        }
        .onAppear {
            if !hasAppeared {
                isVisible = component.condition(stateManager.getAllValues())
                hasAppeared = true
            }
        }
        .onReceive(stateManager.formValueChangedPublisher) { _ in
            withAnimation(.easeInOut(duration: 0.2)) {
                isVisible = component.condition(stateManager.getAllValues())
            }
        }
    }
}
