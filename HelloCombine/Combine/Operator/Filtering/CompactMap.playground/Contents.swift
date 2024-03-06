import UIKit
import Combine

//: # CompactMap
//: 업스트림 `Publisher`가 방출하는 항목이 nil이 아니면 (옵셔널 해제가 가능하면) 다운스트림으로 내려보내는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

["a", "b", "c", "d", "z"].publisher
    .map { value -> UInt8? in
        return Character(value).asciiValue
    }
    .compactMap { value in
        return value
    }
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)
    
