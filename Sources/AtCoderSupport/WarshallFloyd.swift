func warshallFloyd<Distance>(graph: inout [[Distance?]]) where Distance: Comparable, Distance: AdditiveArithmetic {
    for k in graph.indices {
        for i in graph.indices {
            for j in graph.indices {
                if let new1 = graph[i][k], let new2 = graph[k][j] {
                    let new = new1 + new2
                    if let current = graph[i][j] {
                        if new < current {
                            graph[i][j] = new
                        }
                    } else {
                        graph[i][j] = new
                    }
                }
            }
        }
    }
}
