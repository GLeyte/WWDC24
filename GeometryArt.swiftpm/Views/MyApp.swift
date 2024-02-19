import SwiftUI

@main
struct MyApp: App {
    
    @StateObject private var stackPath = PathType()
        
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $stackPath.path) {
                Curve4View()
            }
            .environmentObject(stackPath)
            .tint(Color.accentColor)
        }
    }
}
