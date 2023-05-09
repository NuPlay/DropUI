//
//  AppIdeaView.swift
//  DropUI
//
//  Created by 이웅재 on 2023/04/09.
//

import SwiftUI

struct AppIdeaView: View {
    @State private var index: Int = 0
    let onboardingData: [OnboardingData] = [
        OnboardingData(emoji: "📅", title: "Planning the Reunion", description: "Friends start planning an epic get-together and exchange cool ideas for the big day."),
        OnboardingData(emoji: "📍", title: "Picking Date & Location", description: "They find the perfect date and pick a cozy café that's easy for everyone to get to."),
        OnboardingData(emoji: "🎉", title: "The Joyful Reunion", description: "The day comes, and they all meet up, sharing warm hugs, life updates, and old memories."),
        OnboardingData(emoji: "💬", title: "Breaking the Ice", description: "To make things more fun, they brainstorm ways to show appreciation and gratitude to each other."),
        OnboardingData(emoji: "📱", title: "Compliment Generator App", description: "One friend suggests a Quick Compliment Generator app for a fun, interactive group activity, making everyone's day.")
    ]

    let onboardingEnd: () -> Void

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.blue.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                OnboardingCell(
                    emoji: onboardingData[index].emoji,
                    title: onboardingData[index].title,
                    description: onboardingData[index].description
                )
                .padding(.bottom, 52)

                if index < onboardingData.count - 1 {
                    CustomButton(text: "Next") {
                        withAnimation {
                            index += 1
                        }
                    }
                } else {
                    CustomButton(text: "Get Started") {
                        onboardingEnd()
                    }
                }
            }
            .frame(maxWidth: 500)
            .padding(.horizontal, 32)
        }
    }
}

struct AppIdeaView_Previews: PreviewProvider {
    static var previews: some View {
        AppIdeaView {}
            .animation(.spring())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

struct OnboardingCell: View {
    let emoji: String
    let title: String
    let description: String

    var body: some View {
        VStack(spacing: 20) {
            Text(emoji)
                .font(.system(size: 100))

            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(description)
                    .font(.title2)
                    .lineSpacing(10)
                    .opacity(0.8)
            }
            .padding(20)
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.1)))
            .background(RoundedRectangle(cornerRadius: 20).stroke(Color.white.opacity(0.2), lineWidth: 1))
            .foregroundColor(.white)
        }
    }
}

struct OnboardingData {
    let emoji: String
    let title: String
    let description: String
}
