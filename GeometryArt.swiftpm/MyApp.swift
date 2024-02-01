import SwiftUI

@main
struct MyApp: App {
    
    @StateObject private var stackPath = PathType()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $stackPath.path) {
                ContentView()
            }
            .environmentObject(stackPath)
            .tint(colorScheme == .dark ? .white : .black)
        }
    }
}


