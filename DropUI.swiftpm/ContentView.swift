import SwiftUI

struct ContentView: View {
    @State private var viewType: ViewType = .tableOfCotents
    @State private var image: UIImage?

    var body: some View {
        ZStack {
            AppColors.bg0.ignoresSafeArea()

            Group {
                switch viewType {
                case .tableOfCotents:
                    TableOfContentsView {
                        viewType = .appIdea
                    }
                case .appIdea:
                    AppIdeaView {
                        viewType = .canvas
                    }
                case .canvas:
                    DragAndDropView {
                        viewType = .appIcon
                    }
                case .appIcon:
                    DrawingView { image in
                        self.image = image
                        viewType = .ending
                    }
                case .ending:
                    EndingView(appIcon: image)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum ViewType {
    case tableOfCotents
    case appIdea
    case canvas
    case appIcon
    case ending
}
