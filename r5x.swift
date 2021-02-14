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

public class PublishSubject<T> {
    private class Observer {
        let closure: (T) -> Void
        init(_ closure: @escaping (T) -> Void) { self.closure = closure }
    }

    private var closures = [(T) -> Void]()

    public func send(_ value: T) { closures.forEach { $0(value) } }

    public func observe(_ closure: @escaping (T) -> Void) -> AnyObject {
        let observer = Observer(closure)
        closures.append { [weak observer] in observer?.closure($0) }
        return observer
    }
}

public class BehaviourSubject<T>: PublishSubject<T> {
    public private(set) var value: T

    public init(_ value: T) { self.value = value }

    public override func send(_ value: T) {
        self.value = value
        super.send(value)
    }
}
