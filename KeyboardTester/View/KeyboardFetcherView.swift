//
//  KeyboardFetcherView.swift
//  KeyboardTester
//
//  Created by Loïc PIREZ on 07/07/2021.
//

import SwiftUI

struct KeyboardFetcherView: View {
    @ObservedObject private var keyboardFetcher: KeyboardFetcherViewModel = KeyboardFetcherViewModel()

    var body: some View {
        HStack {
            NavigationView {
                VStack(spacing: 30) {
                    List {
                        Section(header: Text("Button mapping")) {
                            HStack {
                                Text("TODO")
                                Spacer()
                            }
                        }

                        Section(header: Text("Debug")) {

                            HStack {
                                Text("Keyboard enabled")
                                Spacer()
                                Text(verbatim: self.keyboardFetcher.status.keyboardEnabled ? "Yes" : "No")
                            }

                            HStack {
                                Text("Source")
                                Spacer()
                                Text(verbatim: self.keyboardFetcher.status.input.count > 0 ? self.keyboardFetcher.status.input : "None")
                            }
                        }
                        }
                    }
                HStack(alignment: .center) {
                        List {

                            ForEach(0 ..< KeyboardButtonType.allCases.count) { type in
                                Section(header: Text(KeyboardButtonType.allCases[type].rawValue)) {
                                    ForEach(0 ..< self.keyboardFetcher.buttons.count) { button in

                                        if self.keyboardFetcher.buttons[button].type == KeyboardButtonType.allCases[type] {
                                            HStack(alignment: .center, spacing: 20) {
                                                Text(self.keyboardFetcher.buttons[button].name)
                                                Spacer()
                                                if self.keyboardFetcher.buttons[button].pressed {
                                                    Circle().foregroundColor(.green).frame(width: 32, height: 32)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }.navigationBarTitle("Keyboard Fetcher")
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardFetcherView()
            .previewDevice("iPad Pro (11-inch) (3rd generation)")
    }
}
