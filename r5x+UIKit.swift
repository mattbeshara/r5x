// Copyright 2021 Matt Beshara.
//
// This file is part of r5x.
//
// r5x is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// r5x is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with r5x.  If not, see <https://www.gnu.org/licenses/>.

import UIKit

extension UIControl {
    private class TapPublishSubject: PublishSubject<Void> {
        override func observe(_ closure: @escaping (()) -> Void)
        -> AnyObject {
            super.observe { _ = self ; closure(()) }
        }

        @objc func tap() { send(()) }
    }

    public var onTap: PublishSubject<Void> {
        with(TapPublishSubject()) {
            addTarget(
                $0,
                action: #selector(TapPublishSubject.tap),
                for: .touchUpInside
            )
        }
    }
}
