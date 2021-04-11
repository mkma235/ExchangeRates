//
//  Graph.swift
//  ExchangeRates
//
//  Created by Mariano Manuel on 4/10/21.
//

import SwiftUI

struct LineGraph: Shape {
    var dataPoints: [CGFloat]

    func path(in rect: CGRect) -> Path {
        func point(at ix: Int) -> CGPoint {
            let point = dataPoints[ix]
            let x = rect.width * CGFloat(ix) / CGFloat(dataPoints.count - 1)
            let y = (2-point) * (rect.height/2)
            return CGPoint(x: x, y: y)
        }

        return Path { p in
            guard dataPoints.count > 1 else { return }
            let start = dataPoints[0]
            p.move(to: CGPoint(x: 0, y: (2-start) * (rect.height/2)))
            for idx in dataPoints.indices {
                p.addLine(to: point(at: idx))
            }
        }
    }
}

struct RateTimeAxis: Shape {

    func path(in rect: CGRect) -> Path {

        return Path { p in
            let rate_increment = rect.height / 10
            for i in 0...10 {
                let y = CGFloat(10-i) * rate_increment
                p.move(to: CGPoint(x: 0, y: y))
                p.addLine(to: CGPoint(x: rect.width, y: y))
            }
            let time_increment = rect.width / 12
            for j in 0...12 {
                let x = CGFloat(j) * time_increment
                p.move(to: CGPoint(x: x, y: rect.height))
                p.addLine(to: CGPoint(x: x, y: 0))
            }
        }
    }
}


struct Graph: View {
    @Binding var on: Bool
    var points: [CGFloat]

    var body: some View {
        VStack {
            Text("Exchange Rates Last Year")
                .font(.title3)
            HStack {
                HStack {
                    Text("Rate($/€)")
                        .rotationEffect(Angle(degrees: 270))
                    VStack {
                        Text("2.0")
                            .rotationEffect(Angle(degrees: 315))
                        Group {
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                        Text("1.0")
                            .rotationEffect(Angle(degrees: 315))
                        Group {
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                        Text("0.0")
                            .rotationEffect(Angle(degrees: 315))
                    }
                    .aspectRatio(16/9, contentMode: .fit)
                
                    ZStack {
                        LineGraph(dataPoints: points)
                            .trim(to: on ? 1 : 0)
                            .stroke(Color.red, lineWidth: 2)
                            .aspectRatio(16/9, contentMode: .fit)
                            .border(Color.blue, width: 1)
                        
                        RateTimeAxis()
                            .trim(to: on ? 1 : 0)
                            .stroke(Color.blue, lineWidth: 0.5)
                            .aspectRatio(16/9, contentMode: .fit)
                            .border(Color.blue, width: 1)
                    }
                }
                .padding()
            }
            Text("Time (months)")

            Button("Show Rates") {
                withAnimation(.easeInOut(duration: 2)) {
                    self.on.toggle()
                }
            }
            .frame(minWidth: 0, maxWidth: 150)
            .padding()
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(40)
            .font(.title3)
        }
    }
}

struct Graph_Previews: PreviewProvider {
    static var previews: some View {
        Graph(on: .constant(true), points: [0.5,1.5,2.0,0.75,1,0.5,0.25,1.5,0.5,1,0,2])
    }
}
