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

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score: Int = 0

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
                HStack {
                    Image(systemName: "trophy")
                    Text("Total Score: \(score)").font(.title3).bold()
                }
            }
            .navigationTitle(rootWord)
            // When we click enter on the keyboard submit.
            .onSubmit(addNewWord)
            // onAppear -> When this view is shown startGame
            .onAppear(perform: startGame)
            .toolbar {
                Button("New Deal") {
                    startGame()
                }
            }
            .alert(errorTitle, isPresented: $showingError) {
                // Provides automatically an ok button if there is nothing
                // in this closure
                //                Button("Ok"){}
            } message: {
                Text(errorMessage)
            }
        }
    }

    func addNewWord() {
        // lowerCased and remove whiteSpace and NewLines.
        let answer = newWord.lowercased().trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        // Make sure there is at least one character in the String answer
        guard answer.count >= 3 else {
            wordError(
                title: "Too short",
                message: "A word must have at least 3 letters."
            )
            return
        }
        guard answer != rootWord else {
            wordError(
                title: "Same word as root word",
                message: "You cannot use that one!"
            )
            return
        }
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        guard isPossible(word: answer) else {
            wordError(
                title: "Word not possible",
                message: "You can't spell that word from '\(rootWord)'!"
            )
            return
        }

        guard isReal(word: answer) else {
            wordError(
                title: "Word not recognized",
                message: "You can't just make them up, right?"
            )
            return
        }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        // Score calculation based on the length of the word and number of words found.
        score += newWord.count + (usedWords.count - 1)
        newWord = ""
    }

    func startGame() {
        // Reset Score and Array
        score = 0
        usedWords = [String]()
        // Retrieving the file
        if let startWordsURL = Bundle.main.url(
            forResource: "start",
            withExtension: "txt"
        ) {
            // Loading of the file
            if let startWords =
                (try? String(contentsOf: startWordsURL, encoding: .utf8))
            {
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

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )
        return misspelledRange.location == NSNotFound
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }

    func calculateScore() {}
}

#Preview {
    ContentView()
}
