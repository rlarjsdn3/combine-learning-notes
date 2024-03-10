import UIKit
import Combine

//: # Zip
//: 업스트림 `Publisher`와 결합한 `Publisehr`가 방출하는 항목의 짝이 서로 맞으면 하나로 묶은 결과를 방출하는 Publisher입니다. \

var cancellable = Set<AnyCancellable>()

let subject1 = PassthroughSubject<Int, Never>()
let subject2 = PassthroughSubject<String, Never>()

subject1
    .zip(subject2)
    .sink { value in
        print("\(value.0): \(value.1)")
    }
    .store(in: &cancellable)

subject1.send(1)
subject2.send("One")

subject1.send(2)
subject2.send("Two")

subject1.send(3)
subject1.send(4)

subject2.send("Three")
subject2.send("Four")

subject1.send(completion: .finished)
subject2.send(completion: .finished)

//: RxSwift와 유사한 개념: Zip
