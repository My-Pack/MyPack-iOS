//
//  EmitterAnimator.swift
//  MyPackAnimation
//
//  Created by jito on 2023/05/07.
//

import UIKit

public class EmitterAnimator {
    private var emitterLayer: CAEmitterLayer!
    private var view: UIView
    private var viewController: UIViewController

    public init(view: UIView, viewController: UIViewController) {
        self.view = view
        self.viewController = viewController
    }

    @objc public func imageViewTapped() {
        createEmitterLayer()
        animateEmitterLayer()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.emitterLayer.birthRate = 0
        }
    }

    private func createEmitterLayer() {
        emitterLayer = CAEmitterLayer()
        emitterLayer.emitterPosition = view.center
        emitterLayer.emitterSize = CGSize(width: 0.0, height: 0.0)
        emitterLayer.emitterShape = .point
        emitterLayer.renderMode = .unordered
        viewController.view.layer.addSublayer(emitterLayer)
    }

    private func animateEmitterLayer() {
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "heart")?.cgImage
        // 얼마나 유지될거냐 (number of seconds an object lives) 이거 짧게 주면 중간에 사라질수도
        emitterCell.lifetime = 3
        // 1초에 몇개 생성할거냐. (number of objects created per second)
        emitterCell.birthRate = 200

        // 크기
        emitterCell.scale = 0.05
        // particle 마다 달라질 수 있는 scale 의 범위
        emitterCell.scaleRange = 0.05

        // 얼마나 빠른 속도로 회전할것인가. 0이면 회전 효과 없음
        emitterCell.spin = 5
        // spin 범위
        emitterCell.spinRange = 10

        // particle 이 방출되는 각도. 따라서 0 이면 linear 하게 방출됨.
        // 2pi = 360 도 = particle이 모든 방향으로 분산 됨.
        emitterCell.emissionRange = CGFloat.pi * 2

        // 수치가 높을 수록 particle 이 빠르게, 더 멀리 방출되는 효과.
        // yAcceleration에 의해 영향 받음
        emitterCell.velocity = 700
        // velocity 값의 범위를 뜻함.
        // 만약 기본 velocity가 700이고, velocityRange 가 50 이면,
        // 각 particle은 650-750 사이의 velocity 값을 갖게 됨
        emitterCell.velocityRange = 50
        // gravity 효과.
        // 양수면 중력이 적용되는 것처럼 보이고, 음수면 중력이 없어져서 날아가는 것 처럼 보임.
        // velocity 와 yAcceleration의 조합이 distance 를 결정
        emitterCell.yAcceleration = 1200
        emitterLayer.emitterCells = [emitterCell]
    }
}
