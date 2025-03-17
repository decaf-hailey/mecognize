//
//  HistoryCell.swift
//  Me-cognize
//
//  Created by Hailey on 2023/07/09.
//

import Foundation
import UIKit

class HistoryCell: MeTableViewCell {
    
    @IBOutlet weak var titleLabel: MeLightLabel!
    @IBOutlet var gaugeView: UIView!
    var data: History?
    var gaugeValue: CGFloat = 0
    var gaugeBackLayer = CAShapeLayer()
    var gaugeLayer = CAShapeLayer()
    let lineWidth: CGFloat = 4
    var gaugeWidth : CGFloat {
        return self.gaugeView.bounds.width
    }
    
    func config(_ data: History){
        titleLabel.text = Util.DateConverter.getDateString(.weekdayMMM, date: data.date)
        setGauge(score: data.score)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size.width > 0 {
            createGauges()
        }
    }
}


extension HistoryCell {
    
    
    fileprivate func setGauge(score: CGFloat) {
        gaugeValue = CGFloat(score) / 2
    }
    
    fileprivate func createGauges() {
        
        if gaugeBackLayer.superlayer != nil {
            gaugeBackLayer.removeFromSuperlayer()
        }
        gaugeBackLayer = createGaugeLayer(back: true)
        gaugeView.layer.addSublayer(gaugeBackLayer)
        
        
        if gaugeLayer.superlayer != nil {
            gaugeLayer.removeFromSuperlayer()
        }
        gaugeLayer = createGaugeLayer(back: false)
        // for animation
        // gaugeLayer.strokeStart = 0.0 
        gaugeLayer.strokeEnd = abs(gaugeValue)
        gaugeView.layer.addSublayer(gaugeLayer)
    }
    
    
    fileprivate func createGaugeLayer(back: Bool) -> CAShapeLayer {
        let barColor = gaugeValue < 0 ? UIColor.red : UIColor.blue
        let half = gaugeWidth/2

        let shapeLayer = CAShapeLayer()
        let path = CGMutablePath()
        if (back){
            path.move(to: CGPoint(x: .zero, y: 15))
        } else {
            path.move(to: CGPoint(x: gaugeValue < 0 ? half + (gaugeValue*half*1.5) : half, y: 15))
        }
        path.addLine(to: CGPoint(x: gaugeWidth, y: 15))

        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.path = path
        shapeLayer.strokeColor = back ? UIColor.blue.withAlphaComponent(0.2).cgColor : barColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        return shapeLayer
    }

    
    
}
