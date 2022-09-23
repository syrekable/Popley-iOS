//
//  MRE.swift - MRE for https://stackoverflow.com/q/73818591/12938809
//  Popley
//
//  Created by Jordan Niedzielski on 22/09/2022.
//
/*
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ContentViewViewModel
    var body: some View {
        VStack {
            NavigationStack(path: $model.path) {
                List(model.content) { element in
                    Text(element.name)
                }
                .navigationDestination(for: Content.self) { element in
                    ContentDetailView(content: element)
                }
                .navigationDestination(for: Page.self) { page in
                    AddContentPresenterView(page: page)
                }
            }
            Button {
                model.navigateToNextPartOfContentCreation()
            } label: {
                Label("Add content", systemImage: "plus")
            }

        }
    }
}

struct ContentDetailView: View {
    let content: Content
    var body: some View {
        Text(content.name)
    }
}

struct AddContentPresenterView: View {
    @EnvironmentObject var model: ContentViewViewModel
    @StateObject var addContentViewModel = AddContentViewModel()
    let page: Page
    var body: some View {
        switch Page.allCases {
        case .contentName:
            contentName
        case .contentSummary:
            contentSummary
        }
    }
}

extension AddContentPresenterView {
    var contentName: some View {
        TextField("Name your content", text: $addContentViewModel.contentName)
            .onSubmit {
                model.navigateToNextPartOfContentCreation()
            }
    }
    var contentSummary: some View {
        VStack {
            Text(addContentViewModel.contentName)
            Button {
                model.addContent(addContentViewModel.createContent())
                model.navigateToRoot()
            } label: {
                Label("Add this content", systemImage: "checkmark.circle")
            }
        }
    }
}

class ContentViewViewModel: ObservableObject {
    @Published var path = NavigationPath()
    @Published var content: [Content] = []
    
    func navigateToNextPartOfContentCreation() {
        switch path.count {
        case 0:
            path.append(Page.contentName)
        case 1:
            path.append(Page.contentSummary)
        default:
            fatalError("Navigation error.")
        }
    }
    
    func navigateToRoot() {
        path.removeLast(path.count)
    }
    
    func addContent(_ content: Content) {
        self.content.append(content)
    }
}

class AddContentViewModel: ObservableObject {
    @Published var contentName = ""
    
    func createContent() -> Content {
        return Content(name: contentName)
    }
}

struct Content: Identifiable, Hashable {
    var id = UUID()
    var name: String
}
*/
