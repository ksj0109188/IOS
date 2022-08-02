import UIKit
import RxSwift

let disposeBag = DisposeBag()

print("-------------startWith--------------")
let 노랑반 = Observable<String>.of("응애1","응애2","응애3")

노랑반
    .enumerated()
    .map {index, element in
        return element + "어린이 \(index)"
    }
    .startWith("선생님") // 시퀀스 초기값으로 어느 위치에서든 옵저버에서 제일 첫번째로 등장하게됨
    .subscribe(onNext:{
        print($0)
    })
    .disposed(by: disposeBag)

print("-------------concat1--------------")
/**
 옵저버들을 하나로 엮는, Java String의 concat 메소드와 비슷한 메커니즘
 */
let 노랑반어린이들 = Observable<String>.of("응애1","응애2","응애3")
let 선생님 = Observable<String>.of("쌤")

//하나의 옵저버를 생성해 묶는방법
Observable.concat([선생님,노랑반어린이들])
    .subscribe(onNext: {
        print($0)
    })

//옵저버블로 다른 옵저버와 묶는방법
print("-------------concat2--------------")
선생님
    .concat(노랑반어린이들)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

//flatMap과 비슷하지만 다름, conCat은 합쳐지는데 순서를 고려하고, 서로다른 옵저버들이 한개씩 처리됨, 즉 한 옵저버가 다른 옵저버의 작업처리를 기다려 FlatMap보다 성능이 떨어질 수 있음(여러 데이터 처리일때)
print("-------------concatMap-------------")
let 어린이집: [String:Observable<String>] = [
    "노랑반" : Observable.of("응애1","응애2","응애3"),
    "파랑반" : Observable.of("애기1","애기2")
]

Observable.of("노랑반","파랑반")
    .concatMap{ 반 in
        어린이집[반] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

//Merge, Concat, FlatMap들은 옵저버들을 합치지만, 용도 및 동작방식이 틀림
//FlatMap 옵저버의 요소를 1차원 배열로 펼치기 위함
print("-------------Merge1-------------")
let 강북 = Observable.from(["강북구","서대문구","동대문구","종로"])
let 강남 = Observable.from(["강남구","강동구","영등포구","양천구"])

Observable.of(강북, 강남)
    .merge()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------------Merge2-------------")
Observable.of(강북,강남)
    .merge(maxConcurrent: 1) //이벤트를 받을 옵저버들(강북,강남)을 처리할 수 즉, 1이란 먼저받은 옵저버의 처리가 끝날때 까지 다른 옵저버를 처리하지 않는다.
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-------------CombineLatest1-------------")

let 성 = PublishSubject<String>()
let 이름 = PublishSubject<String>()

let 성명 = Observable.combineLatest(성,이름){ 성, 이름 in
    성+이름
}
    
성명
    .subscribe(onNext: {
    print($0)
    })
    .disposed(by: disposeBag)

성.onNext("김")
이름.onNext("똘똘")
이름.onNext("영수")
이름.onNext("은영")
성.onNext("박")
성.onNext("이")
성.onNext("조")

print("-------------CombineLatest2-------------")
let 날짜형식 = Observable<DateFormatter.Style>.of(.short, .long)
let 날짜 = Observable<Date>.of(Date())

Observable.combineLatest(
    날짜형식,
    날짜,
    resultSelector: { 형식, 날짜 -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = 형식
        return dateFormatter.string(from: 날짜)
    }
)
.subscribe(onNext: {
    print($0)
})
.disposed(by: disposeBag)

print("-------------CombineLatest3-------------")
let lastName = PublishSubject<String>()
let firstName = PublishSubject<String>()

let fullName = Observable.combineLatest([lastName, firstName]){ name in
    name.joined(separator: " ")
}

fullName.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)

lastName.onNext("김")
firstName.onNext("성준")
firstName.onNext("스텔라")
firstName.onNext("초이")
