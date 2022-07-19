import RxSwift

let disposeBag = DisposeBag()

enum TraitError:Error {
    case single
    case maybe
    case completable
}

print("---------Single1---------")
Single<String>.just("❤️") //Single Type 생성방식 1
    .subscribe(
        onSuccess:{
            print($0)
        }
        ,onFailure:{
            print("Error: \($0)")
        }
        ,onDisposed: {
            print("disposed")
        }
    )
    .disposed(by: disposeBag)
//Observable<String>.just()
//    .subscribe(
//        onNext:{
//        }
//        , onError:{
//        }
//        , onCompleted:{
//        }
//        , onDisposed:{
//        }
//)

print("---------Single2---------")
Observable<String>.just("❤️")
    .asSingle() //observer Single Type 생성방식 2
    .subscribe(
        onSuccess:{
            print($0)
        }
        ,onFailure:{
            print("Error: \($0)")
        }
        ,onDisposed: {
            print("disposed")
        }
)
    .disposed(by: disposeBag)

print("---------Single3---------")
Observable<String>.create({ observer -> Disposable in
    observer.onError(TraitError.single)
    return Disposables.create()
})
    .asSingle()
    .subscribe(
        onSuccess:{
            print($0)
        }
        ,onFailure:{
            print("Error: \($0.localizedDescription)")
        }
        ,onDisposed: {
            print("disposed")
        }
    ).disposed(by: disposeBag)


print("---------Single4---------")
struct SomeJSON: Decodable{
    let name: String
}

enum JSONError:Error {
    case decodingError
}

let json1 = """
            {"name":"park"}
            """

let json2 = """
            {"WronName":"park"}
            """

func decode(json:String) -> Single<SomeJSON>{
    Single<SomeJSON>.create { observer -> Disposable in
        guard let data = json.data(using: .utf8),
              let json = try? JSONDecoder().decode(SomeJSON.self,from: data)
        else{
            observer(.failure(JSONError.decodingError))
            return Disposables.create()
        }
        observer(.success(json)) //json 객체를 success이벤트에 담아 발생시킴
        return Disposables.create()
    }
}

decode(json: json1).subscribe(
    onSuccess: {
        print($0)
    },
    onFailure: {
        print($0.localizedDescription)
    },
    onDisposed: {
        print("Disposed")
    })


