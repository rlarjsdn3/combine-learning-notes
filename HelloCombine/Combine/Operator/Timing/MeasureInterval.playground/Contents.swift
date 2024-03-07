import UIKit
import Combine

//: # MeasureInterval
//: 업스트림 `Publisher`가 방출한 항목 사이의 시간 간격을 측정한 결과를 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

Timer.publish(every: 1, on: .main, in: .default)
    .autoconnect()
    .measureInterval(using: RunLoop.main)
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)
