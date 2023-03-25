//
//  DashedDivider.swift
//  City Sights
//
//  Created by tom montgomery on 3/22/23.
//

import SwiftUI

struct DashedDivider: View {
    var body: some View {
        // Wrap the whole thing in a Geometry Reader to handle dynamic widths
        GeometryReader { geo in
            // the outline of a 2D shape...
            Path { path in
                // the closure generates the path
                // starts at 0,0
                path.move(to: CGPoint.zero)
                path.addLine(to: CGPoint(x: geo.size.width, y: 0))
            }
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .foregroundColor(.gray)

        }
        // force a height of 1 so it doesn't try and take up all the available space in the BusinessDetail
        .frame(height: 1)
    }
}

struct DashedDivider_Previews: PreviewProvider {
    static var previews: some View {
        DashedDivider()
    }
}
