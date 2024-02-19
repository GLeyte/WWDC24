import SwiftUI

@main
struct MyApp: App {
    
    @StateObject private var stackPath = PathType()
        
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $stackPath.path) {
                ContentView()
            }
            .environmentObject(stackPath)
            .tint(Color.accentColor)
        }
    }
}
