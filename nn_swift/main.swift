import GameKit
import Foundation

public let SEED:UInt64 = 1

class Net {
    private var m_eta:Double
    private var m_epochs:Int
    public var m_w:[Double]
    
    init (eta:Double, epochs:Int) {
        self.m_eta = eta
        self.m_epochs = epochs
        self.m_w = []
    }
    
    public func fit (X:[[Double]], y:[Double]) {
        for _ in 0...X[0].count {
            m_w.append(0)
        }
        for _ in 0...m_epochs {
            //            var errors = 0
            for e in 0...X.count - 1 {
                let update = m_eta * (y[e] - Double(predict(X: X[e])))
                for w in 1...m_w.count - 1 {
                    m_w[w] += update * X[e][w - 1]
                }
                m_w[0] = update
                //                errors += update != 0 ? 1 : 0
            }
            //            m_errors.append(errors)
        }
    }
    
    public func predict (X:[Double]) -> Double {
        return netInput(X: X)
    }
    
    public func netInput (X:[Double]) -> Double {
        var prob = m_w[0]
        for i in 0...X.count - 1 {
//            print("wl: \(m_w.count), i: \(i), Xl: \(X.count)")
            prob += X[i] * m_w[i + 1]
        }
        return prob
    }
}
let trainingSetInputs:[[Double]] = [[0.3, 0.3, 1], [1, 1, 1], [1, 0.3, 1], [0.3, 1, 1]]
let trainingSetOutputs:[Double] = [0.3, 1, 1, 0.3]
let m_Net = Net(eta: 0.1, epochs: 10000)

print("Starting with weights: \(m_Net.m_w)")

m_Net.fit(X: trainingSetInputs, y: trainingSetOutputs)

print ("After trianing wight are: \(m_Net.m_w)")
print("Tests: \(m_Net.predict(X: [1, 0.3, 1]))")




