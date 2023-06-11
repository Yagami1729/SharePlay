//
//  QuestionFormView.swift
//  SharePlay
//
//  Created by Ratnesh Jain on 11/06/23.
//

import SwiftUI
import Observation

struct QuestionForm: View {
    @State var question: Question
    
    var body: some View {
        Form {
            Section {
                TextField("User name", text: $question.user)
            } header: {
                Text("User Name")
            }
            
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
            .disabled(!question.isValid)
        }
    }
}

#Preview {
    QuestionForm(question: Question(title: "", options: [.init(title: "")], user: "John Appleseed"))
}
