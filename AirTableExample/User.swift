//
//  User.swift
//  AirTableExample
//
//  Created by Kinjal Pipaliya on 10/07/21.
//

import Foundation
import SwiftAirtable

// Standard Airtable Structure
struct User {
    // The airtable object id
    
    var id: String = ""
    var name: String = ""
    var contact: String = ""
}

extension User {
    enum AirtableField: String {
        case name = "name"
        case contact = "contact"
    }
}

// MARK: - AirtableObject
extension User: AirtableObject {
    
    static var fieldKeys: [(fieldName: String, fieldType: AirtableTableSchemaFieldKey.KeyType)] {
        var fields = [(fieldName: String, fieldType: AirtableTableSchemaFieldKey.KeyType)]()
        
        fields.append((fieldName: AirtableField.name.rawValue, fieldType: .singleLineText))
        fields.append((fieldName: AirtableField.contact.rawValue, fieldType: .singleLineText))
        
        return fields
    }
    
    func value(forKey key: AirtableTableSchemaFieldKey) -> AirtableValue? {
        switch key {
        case AirtableTableSchemaFieldKey(fieldName: AirtableField.name.rawValue, fieldType: .singleLineText): return self.name
        case AirtableTableSchemaFieldKey(fieldName: AirtableField.contact.rawValue, fieldType: .singleLineText): return self.contact
        default: return nil
        }
    }
    
    init(withId id: String, populatedTableSchemaKeys tableSchemaKeys: [AirtableTableSchemaFieldKey : AirtableValue]) {
        self.id = id
        tableSchemaKeys.forEach { element in
            switch element.key {
            case AirtableTableSchemaFieldKey(fieldName: AirtableField.name.rawValue, fieldType: .singleLineText): self.name = element.value.stringValue
            case AirtableTableSchemaFieldKey(fieldName: AirtableField.contact.rawValue, fieldType: .singleLineText): self.contact = element.value.stringValue
            default: break
            }
        }
    }
}
