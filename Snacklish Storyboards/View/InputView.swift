//
//  InputView.swift
//  Snacklish
//
//  Created by Scott Odle on 2/13/22.
//

import SwiftUI

struct InputView: View {
    @Binding var inputText: String
    @Binding var outputText: String
    @Binding var showResult: Bool
    
    var body: some View {
        VStack {
            TextEditor(
                text: $inputText
            )
                .frame(maxHeight: .infinity)
                .textFieldStyle(.roundedBorder)
                .onTapGesture {
                    if inputText == placeholderString {
                        inputText = ""
                    }
                }
                .foregroundColor(inputText == placeholderString ? .gray : .primary)
            Button {
                if inputText.count > 0 {
                    outputText = Snack(input: inputText).snacklify()
                    showResult = true
                }
            } label: {
                Text("Snacklify!")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(inputText.count == 0)
        }
        .padding()
        .navigationTitle("Snacklish")
        .popover(isPresented: $showResult) {
            OutputView(outputText: $outputText, showResult: $showResult)
        }
    }
}
