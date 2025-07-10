//
//  FormLayout.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import SwiftUI
import UIKit

public struct FormLayout {
    public var contentPadding: EdgeInsets
    public var backgroundColor: Color
    public var titleDisplayMode: NavigationBarItem.TitleDisplayMode // TODO: Remove
    public var showSubmitButton: Bool
    
    public init(
        contentPadding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
        backgroundColor: Color = Color(.systemGroupedBackground),
        titleDisplayMode: NavigationBarItem.TitleDisplayMode = .large,
        showSubmitButton: Bool = true
    ) {
        self.contentPadding = contentPadding
        self.backgroundColor = backgroundColor
        self.titleDisplayMode = titleDisplayMode
        self.showSubmitButton = showSubmitButton
    }
    
    @MainActor public static let `default` = FormLayout()
    @MainActor public static let compact = FormLayout(
        contentPadding: EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12),
        titleDisplayMode: .inline
    )
}
