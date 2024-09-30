//
//  ContentView.swift
//  Rock paper scissors
//
//  Created by Natalia Nikiforuk on 30/09/2024.
//


import SwiftUI

struct ContentView: View {
    @State private var elements = ["rock", "paper", "scissors"].shuffled()
    @State private var prompts = ["lose", "win"]
    @State private var currentElement = Int.random(in: 0...2)
    @State private var score = 0
    @State private var chosenPrompt = "()"
    @State private var chosenElement = "()"
    @State private var questionNr = 0
    @State private var showResult = false
    
    var body: some View {
        VStack {
            HStack {
                Text("I want to:")
                HStack {
                    ForEach(0..<2) { number in
                        Button {
                            promptTapped(number)
                        } label: {
                            Text(prompts[number])
                        }
                        .bold()
                        .buttonStyle(.borderedProminent)
                    }
                    Text("with \(elements[currentElement]).")
                        .foregroundStyle(.red)
                }
                .padding()
            }
            HStack {
                ForEach(0..<3) { number in
                    Button {
                        elementTapped(number)
                    } label: {
                        Text(elements[number])
                    }
                    .bold()
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            VStack {
                Button {
                    checkAnswer()
                } label: {
                    Text("Check the answer")
                }
                .padding()
                .background(.green)
                .clipShape(.capsule)
                .foregroundColor(.white)
                .bold()
            }
            .alert("Result", isPresented: $showResult) {
                Button("Continue", action: continueGame)
            } message: {
                Text("Your score is \(score)")
            }
        }
    }
    
    func promptTapped(_ number: Int) {
        number == 0 ? (chosenPrompt = "lose") : (chosenPrompt = "win")
    }
    
    func elementTapped(_ number: Int) {
        if number == 0 {
            chosenElement = "rock"
        } else if number == 1 {
            chosenElement = "paper"
        } else if number == 2 {
            chosenElement = "scissors"
        }
    }
    
    func continueGame(){
        elements.shuffle()
        currentElement = Int.random(in: 0...2)
    }
    
    func checkAnswer(){
        
        if questionNr == 5 {
            showResult = true
        }
        
        //If rock
        if currentElement == 0 {
            if chosenPrompt == "lose" {
                chosenElement == "scissors" ? (score += 1) : (score -= 1)
            } else if chosenPrompt == "win" {
                chosenElement == "paper" ? (score += 1) : (score -= 1)
            }
        }
        
        //If paper
        if currentElement == 1 {
            if chosenPrompt == "lose" {
                chosenElement == "rock" ? (score += 1) : (score -= 1)
            } else if chosenPrompt == "win" {
                chosenElement == "scissors" ? (score += 1) : (score -= 1)
            }
        }
        
        //If scissors
        if currentElement == 2 {
            if chosenPrompt == "lose" {
                chosenElement == "paper" ? (score += 1) : (score -= 1)
            } else if chosenPrompt == "win" {
                chosenElement == "rock" ? (score += 1) : (score -= 1)
            }
        }
        continueGame()
        questionNr += 1
    }
}

#Preview {
    ContentView()
}
