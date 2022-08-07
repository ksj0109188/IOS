import RxSwift
import RxCocoa
import UIKit
import PlaygroundSupport

let disposeBag = DisposeBag()

print("-----------------------replay-----------------------")
let 인사말 = PublishSubject<String>()
let 앵무새 = 인사말.replay(1)
앵무새.connect()

인사말.onNext("Hello")
인사말.onNext("Hallo")

앵무새.subscribe(onNext: {
    print($0)
})
.disposed(by: disposeBag)

print("-----------------------replay All-----------------------")
//replay와 동일하지만 replay는 버퍼 사이즈를 지정해 이전 이벤트를 보았지만 replay All의 경우는 이전 이벤트들을 모두 볼 수 있다.
let 닥터스트레인지 = PublishSubject<String>()
let 타임스톤 = 닥터스트레인지.replayAll()

타임스톤.connect()

닥터스트레인지.onNext("도르마무 !")
닥터스트레인지.onNext("거래를 하러왔다 ")

타임스톤.subscribe(onNext: {
    print($0)
})
.disposed(by: disposeBag)

닥터스트레인지.onNext("현재시점")

print("-----------------------buffer-----------------------")
//let source = PublishSubject<String>()
//
//var count = 0
//let timer = DispatchSource.makeTimerSource()
//
//timer.schedule(deadline: .now()+2, repeating: .seconds(1)) //현재시간 기준 2초후 1초마다 이벤트 발생
//timer.setEventHandler{
//    count += 1
//    source.onNext("\(count)")
//}
//timer.resume()
//                //어느 이벤트를 받는데 버퍼시간(2초동안) 최대 2걔(count:2)를 받아 메인스케줄러에서 실행
//source.buffer(timeSpan: .seconds(2), count: 2, scheduler: MainScheduler.instance)
//    .debug()
//    .subscribe(onNext: {
//        print($0) //**Array 리턴
//    })
//    .disposed(by: disposeBag)

print("-----------------------window-----------------------")
//buffer와 비슷하지만 이벤트를 옵저버로 반환함, buffer는 **Array를 리턴함
//let 만들어낼최대Observable수 = 5
//let 만들시간 = RxTimeInterval.seconds(1)
//
//let window = PublishSubject<String>()
//
//var windowCount = 0
//let windowTimerSource = DispatchSource.makeTimerSource()
//windowTimerSource.schedule(deadline: .now()+2, repeating: .seconds(1))
//windowTimerSource.setEventHandler{
//    windowCount += 1
//    window.onNext("\(windowCount)")
//}
//
//windowTimerSource.resume()
////옵저버블을 하나로 묶는(만드는)시간, 하나의 스케줄러로 등록될 수 있는 옵저버들의 최대 갯수
//window.window(timeSpan: 만들시간, count: 만들어낼최대Observable수, scheduler: MainScheduler.instance)
//    .flatMap{windowObservable  -> Observable<(index: Int, element: String)> in
//        return windowObservable.enumerated()
//    }
//    .subscribe(onNext: {
//        print("\($0.index)번째 요소 \($0.element)")
//    })
//    .disposed(by: disposeBag)
//
print("-----------------------delaySubscription-----------------------")
//let delaySource = PublishSubject<String>()
//
//var delayCount = 0
//let delayTimeSource = DispatchSource.makeTimerSource()
//delayTimeSource.schedule(deadline: .now()+2, repeating: .seconds(1))
//delayTimeSource.setEventHandler{
//    delayCount += 1
//    delaySource.onNext("\(delayCount)")
//}
//delayTimeSource.resume()
//
//delaySource.delaySubscription(.seconds(5), scheduler: MainScheduler.instance)  //구독을 지연
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("-----------------------delay-----------------------")
//let delaySource = PublishSubject<String>()
//
//var delayCount = 0
//let delayTimeSource = DispatchSource.makeTimerSource()
//delayTimeSource.schedule(deadline: .now()+2, repeating: .seconds(1))
//delayTimeSource.setEventHandler{
//    delayCount += 1
//    delaySource.onNext("\(delayCount)")
//}
//delayTimeSource.resume()
//
//delaySource.delay(.seconds(5), scheduler: MainScheduler.instance) //delay는 onNext의 이벤트를 지연
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("-----------------------interval-----------------------")
//Timer와 관련된 RxSwift Operator, 기존 NSTimer, Dispatchsource Timer는 개발자가 구현하기 불편한 부분이 존재
//RXSwfit에선 TimerOperator를 지원(Interval, Timer, Timeout)
//Observable<Int>
//    .interval(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("-----------------------timer-----------------------")
//Observable<Int>
//    .timer(.seconds(5), period: .seconds(2), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("-----------------------timeout-----------------------")
//특정 시간을 초과하게 되면 Error를 발생시키고 옵저버를 죽임
let 누르지않으면에러 = UIButton(type: .system)
누르지않으면에러.setTitle("눌러주시오", for: .normal)
누르지않으면에러.sizeToFit()

PlaygroundPage.current.liveView = 누르지않으면에러

누르지않으면에러.rx.tap
    .do(onNext: {
        print("tap")
    })
    .timeout(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe{
        print($0)
    }
    .disposed(by: disposeBag)
