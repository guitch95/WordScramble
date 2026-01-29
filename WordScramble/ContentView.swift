//
//  ContentView.swift
//  WordScramble
//
//  Created by Guillaume Richard on 28/01/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
        }
    }

    func addNewWord() {
        // lowerCased and remove whiteSpace and NewLines.
        let answer = newWord.lowercased().trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        // Make sure there is at least one character in the String answer
        guard answer.count > 0 else { return }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }

        newWord = ""
    }
}

#Preview {
    ContentView()
}
