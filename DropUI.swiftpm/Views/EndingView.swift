//
//  EndingView.swift
//  DropUI
//
//  Created by 이웅재 on 2023/04/10.
//

import SwiftUI

struct EndingView: View {
    let appIcon: UIImage?

    var body: some View {
        NavigationStack {
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
                    VStack(spacing: 16) {
                        if let icon = appIcon {
                            Image(uiImage: icon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                .background(
                                    Color.white
                                )
                                .cornerRadius(20)
                                .padding(.bottom, 20)
                        } else {
                            Rectangle()
                                .frame(width: 200, height: 200)
                                .cornerRadius(20)
                                .opacity(0.1)
                                .padding(.bottom, 20)
                        }

                        Text("Your app is complete!")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)

                        Text("The blocks you used in drag and drop are similar to SwiftUI")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .opacity(0.7)
                            .padding(.bottom, 40)

                        VStack(spacing: 24) {
                            Text("Click on each block to see the code!")
                                .font(.title)
                                .fontWeight(.bold)
                                .opacity(0.7)

                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: 32) {
                                BlockCell(block: .button)
                                BlockCell(block: .image)
                                BlockCell(block: .text)
                                BlockCell(block: .variable)
                                BlockCell(block: .state)
                                BlockCell(block: .combineBlock)
                            }
                        }
                        .padding(.all, 40)
                        .background(
                            Color.white.opacity(0.1)
                                .cornerRadius(20)
                        )
                        .padding(.bottom, 32)

                        Text("Learning SwiftUI allows you to create more diverse apps")
                            .font(.title)
                            .fontWeight(.bold)
                            .opacity(0.7)

                        Text("Build the app of your dreams")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                    }
                    .padding(.all, 40)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct EndingView_Previews: PreviewProvider {
    static var previews: some View {
        EndingView(appIcon: nil)
    }
}

struct BlockCell: View {
    @State private var showCode: Bool = false

    let blockData: BlockData

    init(block: Block) {
        self.blockData = block.toBlockData()
    }

    var body: some View {
        Button {
            self.showCode.toggle()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: blockData.icon)
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(blockData.color.cornerRadius(10))

                Text(blockData.name)
                    .font(.body)
                    .foregroundColor(.white)
                    .fontWeight(.bold)

                Image(systemName: "info.circle")
                    .font(.title3)
                    .foregroundColor(.blue)
                    .sheet(isPresented: $showCode) {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 32) {
                                blockData.image
                                    .resizable().aspectRatio(contentMode: .fit)
                                    .cornerRadius(15)

                                HStack {
                                    Text(blockData.blockDescription)
                                        .lineSpacing(10)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)

                                    Spacer()
                                }
                                .padding(.all, 16)
                                .background(
                                    Color.white.opacity(0.1)
                                        .cornerRadius(10)
                                )
                            }
                            .padding(.all, 32)
                        }
                    }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .foregroundColor(blockData.color.opacity(0.1))
            )
        }
    }
}
