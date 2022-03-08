//
//  ViewController.swift
//  COVID19
//
//  Created by 김성준 on 2022/03/06.
//

import UIKit
import Charts
import Alamofire
class ViewController: UIViewController {
    
    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var newCaseLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchCovidOverview(completionHandler: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case let .success(result):
                self.configureStackView(koreaCovidOverview: result.korea)
                let covidOverviewList = self.makeCovidOverviewList(cityCovidOverview: result)
                self.configureChartView(covidOverviewList: covidOverviewList)
            case let .failure(error):
                debugPrint("error \(error)")
            }
            
        })
    }
    
    func makeCovidOverviewList(cityCovidOverview:CityCovidOverview) -> [CovidOverView]{
        return [
            cityCovidOverview.seoul,
            cityCovidOverview.busan,
            cityCovidOverview.daegu,
            cityCovidOverview.incheon,
            cityCovidOverview.gwangju,
            cityCovidOverview.daejeon,
            cityCovidOverview.ulsan,
            cityCovidOverview.sejong,
            cityCovidOverview.gyeonggi,
            cityCovidOverview.chungbuk,
            cityCovidOverview.chungnam,
            cityCovidOverview.gyeongbuk,
            cityCovidOverview.gyeongnam,
            cityCovidOverview.jeju,
        ]
    }
    
    func configureChartView(covidOverviewList:[CovidOverView]){
        let entries = covidOverviewList.compactMap{ [weak self] covidoverview -> PieChartDataEntry? in
            guard let self = self else { return nil }
            return PieChartDataEntry(
                value: self.removeForamtString(string:covidoverview.newCase),
                label: covidoverview.countryName,
                data: covidoverview
            )
        }
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
        self.pieChartView.data = PieChartData(dataSet: dataSet)
    }
    
    func removeForamtString(string : String) -> Double{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: string)?.doubleValue ?? 0
    }
    
    func configureStackView(koreaCovidOverview:CovidOverView){
        self.totalCaseLabel.text = "\(koreaCovidOverview.totalCase)명"
        self.newCaseLabel.text = "\(koreaCovidOverview.newCase)명"
    }

    func fetchCovidOverview(completionHandler : @escaping (Result<CityCovidOverview, Error>) -> Void){
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey":"wpYkP4FhdVTGQq9JbgE12czM8ZuCIrDXt"
        ]
        AF.request(url, method: .get, parameters: param)
            .responseData(completionHandler: { response in
                switch response.result{
                case let .success(data):
                    do{
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(CityCovidOverview.self, from: data)
                        completionHandler(.success(result))
                    }catch{
                        completionHandler(.failure(error))
                    }
                case let .failure(error):
                    completionHandler(.failure(error))
                }
        })
    }
}
