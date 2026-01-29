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
            // When we click enter on the keyboard submit.
            .onSubmit(addNewWord)
            // onAppear -> When this view is shown startGame
            .onAppear(perform: startGame)
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
    
    func startGame() {
        // Retrieving the file
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // Loading of the file
            if let startWords = (
                try? String(contentsOf: startWordsURL, encoding: .utf8)) {
                // Create the allWords Array
                let allWords = startWords.components(separatedBy: "\n")
                // rootWord == a randow word in the array of allWords.
                // randomElement() returns an optional so nil coalescing "silkworm"
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        // If we get into this scope that means there is a problem.
        fatalError("Could not load start.txt from bundle.")
    }
    
    
}

#Preview {
    ContentView()
}
