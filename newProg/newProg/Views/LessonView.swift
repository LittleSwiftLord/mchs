import Foundation
import SwiftUI

import SwiftUI

struct LessonView: View {
    let lesson: Lesson

    var body: some View {
        VStack(alignment: .leading) {
            Text(lesson.time)
                .font(.headline)
                .foregroundColor(.blue)
            Text(lesson.subject)
                .font(.subheadline)
                .foregroundColor(.black)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding(.vertical, 5)
    }
}
