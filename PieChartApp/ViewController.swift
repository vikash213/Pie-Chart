//
//  ViewController.swift
//  PieChartApp
//
//  Created by Appinventiv on 05/09/19.
//  Copyright © 2019 Appinventiv. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var chartView: LineChartView!
    
    var months: [String]!
    let unitsSold = [1.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]

    let unitsSold2 = [3.0, 7.0, 12.0, 2.0, 7.0, 18.0, 14.0, 1.0, 12.0, 14.0, 5.0, 3.0]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        chartView.noDataText = "You need to provide data for the chart."
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
        setChart(dataPoints: months, secValues: self.unitsSold2, values: unitsSold)
    }

//    func setChart1(dataPoints: [String], values: [Double]) {
//        chartView.noDataText = "You need to provide data for the chart."
//
//        var dataEntries: [BarChartDataEntry] = []
//
//        for i in 0..<dataPoints.count {
//
//
//            let dataEntry = BarChartDataEntry.init(x: Double(i), y: unitsSold[i], data: nil)
//
//            dataEntries.append(dataEntry)
//        }
//
//        let chartDataSet = PieChartDataSet(entries: dataEntries, label: "Units Sold")
//        let chartData = PieChartData.init(dataSet: chartDataSet)
//
//        //let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
//        chartView.data = chartData
//    }
    
    func setChart(dataPoints: [String], secValues: [Double], values: [Double]) {

        var dataEntries: [ChartDataEntry] = []

        var dataEntries2: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: secValues[i])
            dataEntries2.append(dataEntry)
        }
        
        
////
//        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Units Sold")
//        let pieChartData = PieChartData(dataSet: pieChartDataSet)
////
//////        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
////        chartView.data = pieChartData
//
//        var colors: [UIColor] = []
//
//        for i in 0..<dataPoints.count {
//            let red = Double(arc4random_uniform(256))
//            let green = Double(arc4random_uniform(256))
//            let blue = Double(arc4random_uniform(256))
//
//            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
//            colors.append(color)
//        }
//
//        pieChartDataSet.colors = colors


        //MARK: - First curve
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Units Sold")
        lineChartDataSet.mode = .cubicBezier
        lineChartDataSet.drawCircleHoleEnabled = false
        lineChartDataSet.circleHoleRadius = 0.0
        lineChartDataSet.circleRadius = 0
      //  lineChartDataSet. = .round
        lineChartDataSet.lineDashLengths = [4, 4, 4]
        lineChartDataSet.lineWidth = 2.0
        lineChartDataSet.formLineWidth = 5.0
        lineChartDataSet.colors = [.blue]
        lineChartDataSet.lineDashPhase = 10
        
        //MARK: - Second curve
        let lineChartDataSet2 = LineChartDataSet(entries: dataEntries2, label: "Units2 Sold")
        lineChartDataSet2.mode = .cubicBezier
        lineChartDataSet2.drawCircleHoleEnabled = false
        lineChartDataSet2.circleHoleRadius = 0.0
        lineChartDataSet2.circleRadius = 0
        lineChartDataSet2.lineDashLengths = [4, 4, 4]
        lineChartDataSet2.lineWidth = 2.0
        lineChartDataSet2.formLineWidth = 5.0
        lineChartDataSet2.colors = [.red]
        lineChartDataSet2.lineDashPhase = 10

        
        //MARK: add curve amd pass as parameter in array here
        let lineChartData = LineChartData(dataSets: [lineChartDataSet, lineChartDataSet2])
        
        chartView.data = lineChartData
        chartView.animate(yAxisDuration: 2.0, easingOption: .easeOutCirc)
    }
    
    
    @IBAction func clickShareButton(_ sender: Any) {
        
        let img = UIImage.init(view: self.chartView)
        let imageShare = [ img ]
        let activityViewController = UIActivityViewController(activityItems: imageShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    


}



extension UIImage {
    
    convenience init(view: UIView) {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
        
    }
}
