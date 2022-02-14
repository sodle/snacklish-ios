//
//  OutputView.swift
//  Snacklish
//
//  Created by Scott Odle on 2/13/22.
//

import SwiftUI

struct OutputView: View {
    @Binding var outputText: String
    @Binding var showResult: Bool
    
    @State var share = false
    @State var copied = false
    
    var body: some View {
        VStack {
            Text("Snacklified Text")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(outputText)
                .font(.title2)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            HStack {
                Button {
                    UIPasteboard.general.string = outputText
                    copied = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        copied = false
                    }
                } label: {
                    Text(copied ? "Copied!" : "Copy")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(copied ? .green : .accentColor)
                Button {
                    share = true
                } label: {
                    Text("Share")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            Button {
                showResult = false
            } label: {
                Text("Done")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .sheet(isPresented: $share) {
                ShareSheet(activityItems: [outputText])
            }
        }
        .padding()
    }
}
