//
//  ViewController.swift
//  PlainTest
//
//  Created by Karim Omar on 10.06.22.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    private lazy var uiview = UIView().with { view in
        view.backgroundColor = R.color.background()
        view.addSubview(self.uilabel)
        view.addSubview(self.uibutton)
        view.addSubview(self.uibutton2)
    }
    private let uilabel = UILabel().with { view in
        view.text = HelloWorldWrapper().sayHello()
    }
    private let uibutton = UIButton().with { view in
        view.layer.backgroundColor = R.color.button()?.cgColor
        view.setTitle("CHARTS", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
    }
    private let uibutton2 = UIButton().with { view in
        view.layer.backgroundColor = R.color.button()?.cgColor
        view.setTitle("DATABASE TEST", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
    }
    let disposeBag = DisposeBag()
    let databaseViewModel = DatabaseViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // test shared c++ library
        print("TESTNUMBER \(String(describing: HelloWorldWrapper().test(2)))")

        self.initLayout()
        self.configureViewBindings()
    
        // to delete all number entries in db
        // self.databaseViewModel.deleteAllNumbers()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.printEntries()
        self.printQuery()
    }

    private func initLayout() {
        self.view.addSubview(self.uiview)

        self.uiview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.uilabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.uibutton.snp.makeConstraints { make in
            make.top.equalTo(uilabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        self.uibutton2.snp.makeConstraints { make in
            make.top.equalTo(uibutton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }

    private func configureViewBindings() {
        self.uibutton.rx.controlEvent(.touchUpInside).bind(bag: disposeBag) { [weak self] (_) in
            guard let self = self else { return }

            print("CLICKED")
            let vc = ChartViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }

        self.uibutton2.rx.controlEvent(.touchUpInside).bind(bag: disposeBag) { [weak self] (_) in
            guard let self = self else { return }

            print("CLICKED")
            let vc = DatabaseViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    private func printEntries() {
        print("DATABASE ENTRIES:")
        let entries = self.databaseViewModel.getAllNumbers()
        print(entries)
        entries.forEach { entry in
            print(entry.timestamp)
        }
    }

    private func printQuery() {
        let entries = self.databaseViewModel.getNumberFromValue(value: 100)
        print(entries)
    }
}

// lazy rxswift implemetation
extension ControlEvent {
    func bind(bag: DisposeBag, onNext: @escaping (PropertyType) -> Swift.Void) {
        self.bind(onNext: onNext).disposed(by: bag)
    }
}
