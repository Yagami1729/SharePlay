//
//  QuestionFormView.swift
//  SharePlay
//
//  Created by Ratnesh Jain on 11/06/23.
//

import SwiftUI
import Observation

@Observable
public class Question {
    public var title: String = ""
    public var options: [Option] = []
    public var correctOption: Option? = nil
    
    public init(title: String) {
        self.title = title
        self.options = [.init(title: "")]
        self.correctOption = options[0]
    }
    
    public init(title: String, options: [Option], correct index: Int) {
        self.title = title
        self.options = options
        self.correctOption = options[index]
    }
}

public struct Option: Identifiable, Equatable {
    public let id: UUID
    public var title: String
    
    init(title: String) {
        self.id = .init()
        self.title = title
    }
}

struct QuestionForm: View {
    @Bindable var question: Question
    
    var body: some View {
        Form {
            Section {
                TextField("Question", text: $question.title, axis: .vertical)
                    .lineLimit(10)
            } header: {
                Text("Question")
            }
            
            Section {
                ForEach($question.options) { $option in
                    HStack {
                        TextField("Option", text: $option.title, axis: .vertical)
                            .lineLimit(5)
                        
                        Button {
                            question.correctOption = $option.wrappedValue
                        } label: {
                            if $option.wrappedValue == question.correctOption {
                                Image(systemName: "checkmark.circle.fill")
                                    .symbolEffect(.scale)
                            } else {
                                Image(systemName: "circle")
                                    .symbolEffect(.scale)
                            }
                        }
                        .help("Checkbox for Correct Answer")
                        .font(.system(size: 24))
                    }
                }
            } header: {
                HStack {
                    Text("Options")
                    Spacer()
                    Button { question.options.append(.init(title: ""))} label: {
                        Label("Add Option", systemImage: "plus")
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            Button {
                
            } label: {
                Text("Submit")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.horizontal)
        }
    }
}

#Preview {
    QuestionForm(question: Question(title: ""))
}
