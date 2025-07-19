//
//  FormList.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import Foundation

public struct FormList<Item: Identifiable>: FormComponent {
    public let id = UUID().uuidString
    public let items: [Item]
    public let itemBuilder: (Item) -> any FormComponent
    
    public init(items: [Item], @FormComponentBuilder itemBuilder: @escaping (Item) -> any FormComponent) {
        self.items = items
        self.itemBuilder = itemBuilder
    }
}
