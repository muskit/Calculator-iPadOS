import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.systemBackground))
                .ignoresSafeArea()
            GeometryReader { geom in
                VStack(alignment: .leading, spacing: 0) {
                    HStack (alignment: .bottom, spacing: 0) {
                        Display()
                            .frame(height: geom.size.height/3)
                    }
                    KeypadVertical()
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
