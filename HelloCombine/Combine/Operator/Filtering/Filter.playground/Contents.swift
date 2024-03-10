import UIKit
import Combine

//: # Filter
//: 업스트림 `Publisher`가 방출하는 항목 중 주어진 클로저(조건)에 만족하는 항목만 재방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

Array(1...100).publisher
    .filter { value in
        return value % 2 == 0
    }
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

//: RxSwift와 유사한 개념: Filter
