//
//  FormComponentBuilder.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUICore

@resultBuilder
struct FormComponentBuilder {
    static func buildBlock(_ components: any FormComponent...) -> [any FormComponent] {
        return components
    }
    
    static func buildEither(first component: any FormComponent) -> any FormComponent {
        return component
    }
    
    static func buildEither(second component: any FormComponent) -> any FormComponent {
        return component
    }
    
    static func buildArray(_ components: [any FormComponent]) -> [any FormComponent] {
        return components
    }
}

//@resultBuilder
//struct FormSectionBuilder {
//    static func buildBlock(_ components: any FormComponent...) -> [any FormComponent] {
//        return components
//    }
//    
//    static func buildEither(first component: any FormComponent) -> any FormComponent {
//        return component
//    }
//    
//    static func buildEither(second component: any FormComponent) -> any FormComponent {
//        return component
//    }
//    
//    static func buildArray(_ components: [any FormComponent]) -> [any FormComponent] {
//        return components
//    }
//}


func TextField(_ id: String) -> TextFormField {
    return TextFormField(id: id)
}

func DatePicker(_ id: String) -> DateFormField {
    return DateFormField(id: id)
}

func ToggleField(_ id: String) -> ToggleFormField {
    return ToggleFormField(id: id)
}

func PickerField(_ id: String) -> PickerFormField {
    return PickerFormField(id: id)
}

func Section(_ title: String, @FormComponentBuilder components: () -> [any FormComponent]) -> FormSection {
    return FormSection(title, components: components)
}

func Section(@FormComponentBuilder components: () -> [any FormComponent]) -> FormSection {
    return FormSection(nil, components: components)
}

func Row(spacing: CGFloat = 16, alignment: VerticalAlignment = .top, @FormComponentBuilder components: () -> [any FormComponent]) -> FormRow {
    return FormRow(spacing: spacing, alignment: alignment, components: components)
}

func Column(spacing: CGFloat = 16, alignment: HorizontalAlignment = .leading, @FormComponentBuilder components: () -> [any FormComponent]) -> FormColumn {
    return FormColumn(spacing: spacing, alignment: alignment, components: components)
}

func Spacer(_ size: CGFloat) -> FormSpacer {
    return FormSpacer(size)
}

func Divider(color: Color = Color(.separator), thickness: CGFloat = 1) -> FormDivider {
    return FormDivider(color: color, thickness: thickness)
}

func Text(_ text: String, font: Font = .body, color: Color = .primary) -> FormText {
    return FormText(text, font: font, color: color)
}
