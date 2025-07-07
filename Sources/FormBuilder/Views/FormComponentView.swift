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
    @ObservedObject var formState: FormState
    @ObservedObject var validator: FormValidator
    
    var body: some View {
        switch component {
        case let field as any FormField:
            FormFieldView(field: field, formState: formState, validator: validator)
            
        case let row as FormRow:
            HStack(alignment: row.alignment, spacing: row.spacing) {
                ForEach(row.components, id: \.id) { component in
                    FormComponentView(component: component, formState: formState, validator: validator)
                }
            }
            
        case let column as FormColumn:
            VStack(alignment: column.alignment, spacing: column.spacing) {
                ForEach(column.components, id: \.id) { component in
                    FormComponentView(component: component, formState: formState, validator: validator)
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
            
        default:
            SwiftUI.Text("Unknown component")
                .foregroundColor(.red)
        }
    }
}
