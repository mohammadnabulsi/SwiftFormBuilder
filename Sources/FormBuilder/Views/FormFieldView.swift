//
//  FormFieldView.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUI

struct FormFieldView: View {
    let field: any FormField
    var body: some View {
        fieldInput
    }
    
    @ViewBuilder
    private var fieldInput: some View {
        switch field {
        case let textField as TextFormField:
            TextFieldView(field: textField)
        case let dateField as DateFormField:
            DateFieldView(field: dateField)
        case let toggleField as ToggleFormField:
            ToggleFieldView(field: toggleField)
        case let pickerField as PickerFormField:
            PickerFieldView(field: pickerField)
            
        default:
            Text("Unsupported field type")
                .foregroundColor(.secondary)
        }
    }
}
