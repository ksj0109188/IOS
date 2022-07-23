import RxSwift

let disposeBag = DisposeBag()

print("---------toArray----------")
Observable.of("A","B","C")
    .toArray() // Transform
    .subscribe(onSuccess: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------map------------")
Observable.of(Date())
    .map{ date -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        dateFormatter.locale = Locale(identifier: "ko-kr")
        return dateFormatter.string(from: date)
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------flatMap------------")
protocol 선수 {
    var 점수: BehaviorSubject<Int>{get}
}

struct 양궁선수:선수{
    var 점수: BehaviorSubject<Int>
}

let 한국국가대표 = 양궁선수(점수: BehaviorSubject<Int>(value: 10))
let 미국국가대표 = 양궁선수(점수: BehaviorSubject<Int>(value: 8))

let 올림픽경기 = PublishSubject<선수>() //선수 protocol은 BehaviorSubject, Publish<Behavior>Subject구조

//중첩된 Subject의 element 요소에 접근하려면 FlatMap TransFormming
올림픽경기
    .flatMap{ 선수 in
        선수.점수
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

올림픽경기.onNext(한국국가대표)
한국국가대표.점수.onNext(10)

올림픽경기.onNext(미국국가대표)
한국국가대표.점수.onNext(10)
미국국가대표.점수.onNext(8)

print("-------flatMapLatest------------")
struct 높이뛰기선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 서울 = 높이뛰기선수(점수: BehaviorSubject<Int>(value: 7))
let 부산 = 높이뛰기선수(점수: BehaviorSubject<Int>(value: 11))

let 전국대회 = PublishSubject<선수>()

전국대회
    .flatMapLatest { 선수 in //가장 최근에 발생한 옵저버의 값을 가져오고, 이전 옵저버블을 구독 해제돼 이전 옵저버가 이벤트가 발생하더라도 그 이벤트는 무시된다.
        선수.점수
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
전국대회.onNext(서울)
서울.점수.onNext(9) //최신값

전국대회.onNext(부산) //새로운 시퀀스 발생, 그 전의 시퀀스인 서울은 이제 무시된다.
서울.점수.onNext(10) //변경값
부산.점수.onNext(8)
서울.점수.onNext(12)
부산.점수.onNext(9)

print("-------materialize and dematerialize------------")

