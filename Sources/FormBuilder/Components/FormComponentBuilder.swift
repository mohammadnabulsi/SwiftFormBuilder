//
//  FormComponentBuilder.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUICore

@resultBuilder
public struct FormComponentBuilder {
    public static func buildBlock(_ components: any FormComponent...) -> [any FormComponent] {
        return components
    }
    
    public static func buildEither(first component: any FormComponent) -> any FormComponent {
        return component
    }
    
    public static func buildEither(second component: any FormComponent) -> any FormComponent {
        return component
    }
    
    public static func buildArray(_ components: [any FormComponent]) -> [any FormComponent] {
        return components
    }
}


public func TextField(_ id: String) -> TextFormField {
    return TextFormField(id: id)
}

public func DatePicker(_ id: String) -> DateFormField {
    return DateFormField(id: id)
}

public func ToggleField(_ id: String) -> ToggleFormField {
    return ToggleFormField(id: id)
}

public func PickerField(_ id: String) -> PickerFormField {
    return PickerFormField(id: id)
}

public func Section(_ title: String, @FormComponentBuilder components: () -> [any FormComponent]) -> FormSection {
    return FormSection(title, components: components)
}

public func Section(@FormComponentBuilder components: () -> [any FormComponent]) -> FormSection {
    return FormSection(nil, components: components)
}

public func Row(spacing: CGFloat = 16, alignment: VerticalAlignment = .top, @FormComponentBuilder components: () -> [any FormComponent]) -> FormRow {
    return FormRow(spacing: spacing, alignment: alignment, components: components)
}

public func Column(spacing: CGFloat = 16, alignment: HorizontalAlignment = .leading, @FormComponentBuilder components: () -> [any FormComponent]) -> FormColumn {
    return FormColumn(spacing: spacing, alignment: alignment, components: components)
}

public func Spacer(_ size: CGFloat) -> FormSpacer {
    return FormSpacer(size)
}

public func Divider(color: Color = .secondary, thickness: CGFloat = 1) -> FormDivider {
    return FormDivider(color: color, thickness: thickness)
}

public func Text(_ text: String, font: Font = .body, color: Color = .primary) -> FormText {
    return FormText(text, font: font, color: color)
}
