import UIKit

extension UIView {
    func removeConstraints() {
        self.removeConstraints(self.constraints)
    }
}
