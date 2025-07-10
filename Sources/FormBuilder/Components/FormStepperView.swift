//
//  FormStepperView.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import SwiftUI

struct FormStepperView: View {
    let stepper: FormStepper
    @EnvironmentObject var formState: FormState
    
    @State private var currentStep: Int
    
    init(stepper: FormStepper) {
        self.stepper = stepper
        self._currentStep = State(initialValue: stepper.currentStep)
    }
    
    var body: some View {
        VStack(spacing: 24) {
            // Step indicator
            stepIndicator
            
            // Current step content
            if currentStep < stepper.steps.count {
                currentStepContent
                
                // Navigation buttons
                navigationButtons
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private var stepIndicator: some View {
        HStack(spacing: 0) {
            ForEach(0..<stepper.steps.count, id: \.self) { index in
                HStack(spacing: 0) {
                    // Step circle
                    Circle()
                        .fill(stepColor(for: index))
                        .frame(width: 32, height: 32)
                        .overlay(
                            Text("\(index + 1)")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(stepTextColor(for: index))
                        )
                    
                    // Connecting line (except for last step)
                    if index < stepper.steps.count - 1 {
                        Rectangle()
                            .fill(index < currentStep ? .blue : Color(.systemGray4))
                            .frame(height: 2)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        
        // Step titles
        HStack {
            ForEach(0..<stepper.steps.count, id: \.self) { index in
                VStack(spacing: 4) {
                    Text(stepper.steps[index].title)
                        .font(.caption)
                        .fontWeight(index == currentStep ? .semibold : .regular)
                        .foregroundColor(index <= currentStep ? .primary : .secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.top, 8)
    }
    
    @ViewBuilder
    private var currentStepContent: some View {
        let step = stepper.steps[currentStep]
        
        VStack(alignment: .leading, spacing: 10) {
            Text(step.title)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 8)
            
            ForEach(step.components, id: \.id) { component in
                FormComponentView(component: component)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemBackground))
        )
    }
    
    @ViewBuilder
    private var navigationButtons: some View {
        HStack(spacing: 16) {
            // Previous button
            if currentStep > 0 {
                Button("Previous") {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        currentStep -= 1
                    }
                }
                .buttonStyle(SecondaryButtonStyle())
            }
            
            Spacer()
            
            // Next/Finish button
            Button(currentStep == stepper.steps.count - 1 ? "Finish" : "Next") {
                if currentStep < stepper.steps.count - 1 {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        currentStep += 1
                    }
                } else {
                    // Handle form completion
                    handleStepperCompletion()
                }
            }
            .buttonStyle(PrimaryButtonStyle())
            .disabled(!isCurrentStepValid)
        }
        .padding(.top, 16)
    }
    
    private func stepColor(for index: Int) -> Color {
        if index < currentStep {
            return .green // Completed
        } else if index == currentStep {
            return .blue // Current
        } else {
            return Color(.systemGray4) // Future
        }
    }
    
    private func stepTextColor(for index: Int) -> Color {
        if index <= currentStep {
            return .white
        } else {
            return .secondary
        }
    }
    
    private var isCurrentStepValid: Bool {
        guard currentStep < stepper.steps.count else { return false }
        let step = stepper.steps[currentStep]
        return step.isValid(formState)
    }
    
    private func handleStepperCompletion() {
        // This could trigger form submission or other completion logic
        print("Stepper completed!")
    }
}
