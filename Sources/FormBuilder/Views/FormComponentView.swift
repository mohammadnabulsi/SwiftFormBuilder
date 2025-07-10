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
    
    var body: some View {
        Group {
            switch component {
            case let field as any FormField:
                FormFieldView(field: field)
                    .id(field.id)
                
            case let field as StepperFormField:
                StepperFieldView(field: field)
                    .id(field.id)
            case let row as FormRow:
                HStack(alignment: row.alignment, spacing: row.spacing) {
                    ForEach(row.components, id: \.id) { component in
                        FormComponentView(component: component)
                            .frame(maxWidth: .infinity)
                    }
                }
                
            case let column as FormColumn:
                LazyVStack(alignment: column.alignment, spacing: column.spacing) {
                    ForEach(column.components, id: \.id) { component in
                        FormComponentView(component: component)
                            .id(component.id)
                    }
                }
                
            case let spacer as FormSpacer:
                SpacerView(spacer: spacer)
                
            case let divider as FormDivider:
                DividerView(divider: divider)
                
            case let text as FormText:
                TextView(text: text)
                
            case let list as FormList<AnyIdentifiable>:
                VStack(spacing: 12) {
                    ForEach(list.items) { item in
                        FormComponentView(component: list.itemBuilder(item))
                    }
                }
                
            case let section as FormSection:
                FormSectionView(section: section)
                
            case let card as FormCard:
                FormCardView(card: card)
                
            case let conditional as ConditionalFormComponent:
                ConditionalComponentView(component: conditional)
            default:
                Text("Unknown component: \(String(describing: type(of: component)))")
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
        .onAppear {
            print("onAppear for component view \(component.id)")
        }
    }
}
