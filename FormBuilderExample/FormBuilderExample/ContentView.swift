//
//  ContentView.swift
//  FormBuilderExample
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import SwiftUI
import FormBuilder

struct ContentView: View {
    @State private var formValues: [String: FieldValue] = [:]
    
    var body: some View {
        VStack {
            FormView(definition: ExampleForm())
                .onSubmit { values in
                    print("Form submitted!")
                    let formData = FormData(values)
                    
                    // Or access individual values
                    if let firstName = formData.getString("firstName") {
                        print("First Name: \(firstName)")
                    }
                    
                    if let email = formData.getString("email") {
                        print("Email: \(email)")
                    }
                    
                    if let notifications = formData.getBool("notifications") {
                        print("Notifications enabled: \(notifications)")
                    }
                }
                .onValueChanged { values in
                    // Real-time value monitoring
                    formValues = values
                    print("Form values changed: \(values)")
                }
        }
    }
}

#Preview {
    ContentView()
}
