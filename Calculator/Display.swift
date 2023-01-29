import SwiftUI
import UIKit



struct Display: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var calState = CalState.shared
    
    var body: some View {
        GeometryReader { geom in
            VStack {
                Text(calState.upper)
                    .font(.system(size: 500))
                    .fontWeight(.thin)
                    .minimumScaleFactor(0.01)
                    .foregroundColor(Color(UIColor.systemGray))
                    .multilineTextAlignment(.trailing)
                    .frame(width: geom.size.width-40, height: geom.size.height/4, alignment: .bottomTrailing)
                Spacer()
                Text(calState.lower)
                    .font(.system(size: 500))
                    .fontWeight(.thin)
                    .minimumScaleFactor(0.01)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    .multilineTextAlignment(.trailing)
                    .frame(width: geom.size.width-40, height: geom.size.height/2, alignment: .bottomTrailing)
                    .textSelection(.enabled)
            }
        }
    }
}
