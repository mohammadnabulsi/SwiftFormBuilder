//
//  FormFieldView.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUI

struct FormFieldView: View {
    let field: any FormField
    
    var body: some View {
        Group {
            switch field {
            case let textField as TextFormField:
                TextFieldView(field: textField)
            case let dateField as DateFormField:
                DateFieldView(field: dateField)
            case let toggleField as ToggleFormField:
                ToggleFieldView(field: toggleField)
            case let pickerField as PickerFormField:
                PickerFieldView(field: pickerField)
            case let styledText as StyledTextFormField:
                TextFieldView(field: styledText.field)
            case let styledDate as StyledDateFormField:
                DateFieldView(field: styledDate.field)
                
            default:
                Text("Unsupported field type: \(String(describing: type(of: field)))")
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
}
