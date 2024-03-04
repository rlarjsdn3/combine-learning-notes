import UIKit
import Combine

//: # Assign
//: Assign은 전달받은 항목을 (키패스를 사용해) 한 객체의 프로퍼티에 항목을 할당하는 간단한 Subscriber입니다. 주로 UI Binding에 사용됩니다.

var cancellable = Set<AnyCancellable>()

final class Switch {
    var toggle: Bool = false {
        didSet {
            print("Toggle Switch to \(toggle)")
        }
    }
}
let bulbSwitch = Switch()

let subject = CurrentValueSubject<Bool, Never>(false)
subject
    .assign(to: \.toggle, on: bulbSwitch)
subject.send(true)
subject.send(false)

//: RxSwift와 유사한 개념: bind, drive
