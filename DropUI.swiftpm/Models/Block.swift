//
//  Block.swift
//  DropUI
//
//  Created by 이웅재 on 2023/04/09.
//

import SwiftUI

enum Block: Codable {
    case button
    case text
    case variable
    case state
    case image
    case error
    case combineBlock

    static func fromString(_ string: String?) -> Block {
        switch string {
        case "button":
            return .button
        case "text":
            return .text
        case "variable":
            return .variable
        case "state":
            return .state
        case "image":
            return .image
        default:
            return .error
        }
    }
}

extension Block {
    func toString() -> String {
        switch self {
        case .button:
            return "button"
        case .text:
            return "text"
        case .variable:
            return "variable"
        case .state:
            return "state"
        case .image:
            return "image"
        default:
            return "error"
        }
    }

    func toBlockData() -> BlockData {
        switch self {
        case .button:
            return BlockData(icon: "plus.circle.fill",
                             name: "Button",
                             color: Color.blue,
                             image: AppImages.buttonView,
                             blockDescription: "Button represents a user interface control that triggers an action when activated. It typically includes a title and an action closure to handle user interactions.")
        case .text:
            return BlockData(icon: "textformat",
                             name: "Text",
                             color: Color.yellow,
                             image: AppImages.textView,
                             blockDescription: "Text represents a read-only text display in one or multiple lines within the application.")
        case .variable:
            return BlockData(icon: "tray.full.fill",
                             name: "Variable",
                             color: Color.orange,
                             image: AppImages.textWithVar,
                             blockDescription: "Variable is a container that holds a value, which can be updated during the runtime of the application.")
        case .state:
            return BlockData(icon: "arrow.triangle.2.circlepath",
                             name: "State",
                             color: Color.green,
                             image: AppImages.textWithState,
                             blockDescription: "State is responsible for managing a value within the application, enabling observation and response to changes in the value.")
        case .image:
            return BlockData(icon: "photo.on.rectangle.angled",
                             name: "Image",
                             color: Color.purple,
                             image: AppImages.imageView,
                             blockDescription: "Image is used for displaying an image from various sources, such as assets or URLs, and supports Apple's SF Symbols as well.")
        case .combineBlock:
            return BlockData(icon: "star.square.on.square.fill",
                             name: "Combined",
                             color: .mint,
                             image: AppImages.combineView,
                             blockDescription: "This code demonstrates an app that functions similarly to the one you've just created. Don't worry, SwiftUI makes it easy to understand and implement.")
        default:
            return BlockData(icon: "exclamationmark.triangle",
                             name: "Error",
                             color: Color.red,
                             image: AppImages.combineView,
                             blockDescription: "Error")
        }
    }
}

struct BlockData {
    let icon: String
    let name: String
    let color: Color

    let image: Image
    let blockDescription: String
}
