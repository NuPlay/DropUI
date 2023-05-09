//
//  TableOfContentsView.swift
//  DropUI
//
//  Created by 이웅재 on 2023/04/16.
//

import SwiftUI

struct TableOfContentsView: View {
    @State private var currentIndex: Int = 0

    private let categories = [
        ("🚀", "App Idea", "Imagine an app idea through a story and conversation with friends."),
        ("🔧", "Drag & Drop App Building", "Learn to build an app using easy drag and drop."),
        ("✏️", "Draw App Icon with Apple Pencil", "Make a fun app icon using the Apple Pencil."),
        ("🎉", "Finish!", "Great job! You made an app!")
    ]

    let end: () -> Void

    var body: some View {
        ZStack {
            AppColors.darkBg
                .ignoresSafeArea()

            GeometryReader { geo in
                AppImages.gradientBg
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .clipped()
            }
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .center, spacing: 32) {
                    titleSection

                    descriptionSection
                    .padding(.bottom, 40)

                    categorySection
                        .padding(.bottom, 32)
                    nextButton
                }
                .padding(.all, 52)
            }
            .animation(.spring())
        }
        .preferredColorScheme(.dark)
    }
}

private extension TableOfContentsView {
    var titleSection: some View {
        HStack {
            Text("DropUI")
                .font(.system(size: 60))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
    }

    var descriptionSection: some View {
        HStack {
            Spacer()

            Text("This app is designed to help users experience the joy of app development.")
                .font(.title)
                .fontWeight(.bold)
                .lineSpacing(10)

            Spacer()
        }
        .padding(.vertical, 32)
        .padding(.horizontal, 16)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.1)))
        .background(RoundedRectangle(cornerRadius: 20).stroke(Color.white.opacity(0.2), lineWidth: 1))
    }

    var categorySection: some View {
        VStack(alignment: .leading, spacing: 32) {
            ForEach(0 ..< categories.count, id: \.self) { index in
                CategoryCell(currentIndex: $currentIndex, index: index, emoji: categories[index].0, text: categories[index].1, description: categories[index].2)
            }
        }
    }

    var nextButton: some View {
        Button {
            if currentIndex < categories.count - 1 {
                currentIndex += 1
            } else {
                end()
            }
        } label: {
            if currentIndex < categories.count - 1 {
                Text("Next")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 72)
                    .padding(.vertical, 20)
                    .frame(maxWidth: 400)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.1)))
                    .background(RoundedRectangle(cornerRadius: 20).stroke(Color.white.opacity(0.2), lineWidth: 1))
            } else {
                HStack {

                    Spacer()

                    Text("Next Step")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Spacer()
                }
                .padding(.horizontal, 72)
                .padding(.vertical, 20)
                .frame(maxWidth: 400)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue))
            }
        }
    }
}

struct TableOfContentsView_Previews: PreviewProvider {
    static var previews: some View {
        TableOfContentsView {

        }
    }
}

struct CategoryCell: View {
    @Binding var currentIndex: Int
    let index: Int
    let emoji: String
    let text: String
    let description: String

    var body: some View {
        HStack(spacing: 16) {
            Text(emoji)
                .font(.system(size: currentIndex == index ? 80 : 40))

            VStack(alignment: .leading, spacing: 6) {
                Text(text)
                    .font(.system(size: currentIndex == index ? 32 : 24))
                    .fontWeight(.bold)

                Text(description)
                    .font(.system(size: currentIndex == index ? 24 : 16))
                    .fontWeight(.semibold)
                    .opacity(0.7)
            }
            Spacer()
        }
        .foregroundColor(.white)
        .opacity(currentIndex == index ? 1 : 0.5)
    }
}
