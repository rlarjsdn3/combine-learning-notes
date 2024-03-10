import UIKit
import Combine

//: # TimeOut
//: 업스트림 `Publisher`가 일정 시간 동안 항목을 방출하지 않으면 스트림을 종료하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

var WAIT_TIME: Int = 2
var TIMEOUT_TIME: Int = 5

let subject = PassthroughSubject<String, Never>()
subject
    .timeout(.seconds(TIMEOUT_TIME), scheduler: DispatchQueue.main)
    .sink { completion in
        print("completion: \(completion) at \(Date())")
    } receiveValue: { value in
        print("value: \(value) at \(Date())")
    }
    .store(in: &cancellable)

DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(WAIT_TIME)) {
    subject.send("Some data - sent after a delay of \(WAIT_TIME)")
}

//: RxSwift와 유사한 개념: Timeout
