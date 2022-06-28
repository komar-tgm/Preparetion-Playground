//
//  ChartViewController.swift
//  PlainTest
//
//  Created by Karim Omar on 23.06.22.
//

import Foundation
import UIKit
import Charts
import CoreBluetooth
import Resolver

class ChartViewController: UIViewController {
    
    var centralManager: CBCentralManager?

    var array = [CBPeripheral]()
    
    let chartView = LineChartView()
        
    var dataEntries = [ChartDataEntry]()
    
    var xValue: Double = 8

    @Injected var bluetoothService: BluetoothService
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = R.color.button()
        setupViews()
        setupInitialDataEntries()
        setupChartData()
        self.bluetoothService.initCentralManager()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(didUpdatedChartView), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.bluetoothService.cleanClose()
    }
    

    @objc func didUpdatedChartView() {
        let newDataEntry = ChartDataEntry(x: xValue,
                                          y: Double.random(in: 0...50))
        updateChartView(with: newDataEntry, dataEntries: &dataEntries)
        xValue += 1
    }
    
    func setupViews() {
        view.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chartView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        chartView.widthAnchor.constraint(equalToConstant: view.frame.width - 32).isActive = true
        chartView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func setupInitialDataEntries() {
        (0..<Int(xValue)).forEach {
            let dataEntry = ChartDataEntry(x: Double($0), y: 0)
            dataEntries.append(dataEntry)
        }
    }
    
    func setupChartData() {
        // 1
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "set1")
        chartDataSet.drawCirclesEnabled = false
        chartDataSet.setColor(NSUIColor.red)
        chartDataSet.mode = .linear
        
        // 2
        let chartData = LineChartData(dataSet: chartDataSet)
        chartView.data = chartData
        chartView.xAxis.labelPosition = .bottom
    }
    
    func updateChartView(with newDataEntry: ChartDataEntry, dataEntries: inout [ChartDataEntry]) {
        if let oldEntry = dataEntries.first {
            dataEntries.removeFirst()
            chartView.data?.removeEntry(oldEntry, dataSetIndex: 0)
        }
        
        dataEntries.append(newDataEntry)
        chartView.data?.appendEntry(newDataEntry, toDataSet: 0)
        
        chartView.notifyDataSetChanged()
        chartView.moveViewToX(newDataEntry.x)
    }
}
