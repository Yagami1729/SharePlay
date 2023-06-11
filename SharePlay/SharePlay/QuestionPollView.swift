//
//  QuestionPollView.swift
//  SharePlay
//
//  Created by Ratnesh Jain on 11/06/23.
//

import SwiftUI

struct QuestionPollView: View {
    var question: Question
    @State private var selectedOption: Option?
    
    var body: some View {
        ScrollView {
            Section {
                Text(question.title)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color.accentColor.opacity(0.35))
                    }
            } header: {
                Text("Question")
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Section {
                LazyVStack {
                    ForEach(question.options) { option in
                        let isSelected = selectedOption == option
                        HStack {
                            Text(option.title)
                            Spacer()
                            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(Color.accentColor)
                                .font(.headline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(isSelected ? Color.accentColor.opacity(0.2) : Color.secondary.opacity(0.2))
                        }
                        .onTapGesture {
                            selectedOption = option
                        }
                    }
                }
            } header: {
                Text("Options")
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
            }
            .sensoryFeedback(.selection, trigger: selectedOption)
        }
        .safeAreaInset(edge: .bottom, content: {
            Button {
                
            } label: {
                Text("Submit")
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
            }
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
        })
        .fontDesign(.rounded)
        .safeAreaPadding(.init(top: 16, leading: 16, bottom: 16, trailing: 16))
    }
}

#Preview {
    QuestionPollView(question: Question(
        title: "What is Observable?",
        options: [
            .init(title: "PropertyWrapper"),
            .init(title: "Macro"),
            .init(title: "Compiler Flag"),
            .init(title: "Attribute"),
        ],
        user: "John Appleseed"))
}
