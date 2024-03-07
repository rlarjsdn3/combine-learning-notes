import UIKit
import Combine

//: # Delay
//: 업스트림 `Publisher`가 일정 시간 지연 후 항목을 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

let df = DateFormatter()
df.dateStyle = .none
df.timeStyle = .long

Timer.publish(every: 1.0, on: .main, in: .default)
    .autoconnect()
    .handleEvents(receiveOutput: { date in
        print("Sending Timestamp \'\(df.string(from: date))\' to delay()")
    })
    .delay(for: .seconds(3), scheduler: RunLoop.main)
    .sink { value in
        let now = Date()
        print("At \(df.string(from: now)) received Timestamps \'\(df.string(from: value))\' sent: \(String(format: "%2.f", now.timeIntervalSince(value))) secs ago", terminator: "\n")
    }
    .store(in: &cancellable)
