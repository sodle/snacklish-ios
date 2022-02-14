//
//  SnacklishView.swift
//  Snacklish
//
//  Created by Scott Odle on 2/13/22.
//

import SwiftUI

let placeholderString = "Your text here..."

struct SnacklishView: View {
    @State var inputText = placeholderString
    @State var outputText = ""
    @State var showResult = false
    
    var body: some View {
        NavigationView {
            InputView(inputText: $inputText, outputText: $outputText, showResult: $showResult)
        }
    }
}

struct SnacklishView_Previews: PreviewProvider {
    static var previews: some View {
        SnacklishView()
        SnacklishView(outputText: "Sample Text", showResult: true)
    }
}
