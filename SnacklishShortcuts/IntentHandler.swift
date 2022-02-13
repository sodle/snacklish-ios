//
//  IntentHandler.swift
//  SnacklishShortcuts
//
//  Created by Scott Odle on 2/13/22.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return SnacklifyIntentHandler()
    }
    
}

class SnacklifyIntentHandler: NSObject, SnacklifyIntentHandling {
    func handle(intent: SnacklifyIntent, completion: @escaping (SnacklifyIntentResponse) -> Void) {
        if let text = intent.textInput {
            let snackText = Snack(input: text).snacklify()
            completion(SnacklifyIntentResponse.success(snacklifiedText: snackText))
        }
    }
    
    func resolveTextInput(for intent: SnacklifyIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let text = intent.textInput, !text.isEmpty {
            completion(INStringResolutionResult.success(with: text))
        } else {
            completion(INStringResolutionResult.unsupported())
        }
    }
}
