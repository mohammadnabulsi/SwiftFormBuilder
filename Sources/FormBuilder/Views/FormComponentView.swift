//
//  FormField.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import Foundation
import SwiftUI

struct FormComponentView: View {
    let component: any FormComponent
    @EnvironmentObject var formState: FormState
    @EnvironmentObject var validator: FormValidator
    
    var body: some View {
        switch component {
        case let field as any FormField:
            FormFieldView(field: field)
            
        case let row as FormRow:
            ScrollView(.horizontal) {
                LazyHStack(alignment: row.alignment, spacing: row.spacing) {
                    ForEach(row.components, id: \.id) { component in
                        FormComponentView(component: component)
                    }
                }
            }

        case let column as FormColumn:
            LazyVStack(alignment: column.alignment, spacing: column.spacing) {
                ForEach(column.components, id: \.id) { component in
                    FormComponentView(component: component)
                }
            }
            
        case let spacer as FormSpacer:
            if let height = spacer.height, let width = spacer.width {
                Spacer()
                    .frame(width: width, height: height)
            } else if let height = spacer.height {
                Spacer()
                    .frame(height: height)
            } else if let width = spacer.width {
                Spacer()
                    .frame(width: width)
            } else {
                Spacer()
            }
            
        case let divider as FormDivider:
            Rectangle()
                .fill(divider.color)
                .frame(height: divider.thickness)
                .padding(divider.padding)
            
        case let text as FormText:
            SwiftUI.Text(text.text)
                .font(text.font)
                .foregroundColor(text.color)
                .multilineTextAlignment(text.alignment)
            
        case let list as FormList<AnyIdentifiable>:
            LazyVStack {
                ForEach(list.items, id: \.id) { item in
                    FormComponentView(component: list.itemBuilder(item))
                }
            }
        case let section as FormSection:
            FormSectionView(section: section)
            
        case let card as FormCard:
            FormCardView(card: card)
//        case let conditional as ConditionalFormComponent:
//            if conditional.condition(formState) {
//                FormComponentView(component: conditional.component)
//            }
            
        case let stepper as FormStepper:
            FormStepperView(stepper: stepper)
        default:
            SwiftUI.Text("Unknown component: \(String(describing: type(of: component)))")
                .foregroundColor(.red)
                .font(.caption)
        }
    }
}
