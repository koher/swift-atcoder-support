struct PriorityQueue<T> {
    private var data: [T]
    private var ordered: (T, T) -> Bool

    public var isEmpty: Bool {
        return data.isEmpty
    }

    public var count: Int {
        return data.count
    }

    init(_ order: @escaping (T, T) -> Bool) {
        self.data = []
        self.ordered = order
    }

    init<Seq: Sequence>(_ seq: Seq, _ order: @escaping (T, T) -> Bool) where Seq.Element == T {
        self.data = []
        self.ordered = order

        for x in seq {
            push(x)
        }
    }

    public mutating func pop() -> T? {
        return data.popLast().map { item in
            var item = item
            if !isEmpty {
                swap(&item, &data[0])
                siftDown()
            }
            return item
        }
    }

    public mutating func push(_ item: T) {
        let oldLen = count
        data.append(item)
        siftUp(oldLen)
    }

    private mutating func siftDown() {
        var pos = 0
        let end = count

        data.withUnsafeMutableBufferPointer { bufferPointer in
            let _data = bufferPointer.baseAddress!
            swap(&_data[0], &_data[end])

            var child = 2 * pos + 1
            while child < end {
                let right = child + 1
                if right < end && ordered(_data[right], _data[child]) {
                    child = right
                }
                swap(&_data[pos], &_data[child])
                pos = child
                child = 2 * pos + 1
            }
        }
        siftUp(pos)
    }

    private mutating func siftUp(_ pos: Int) {
        var pos = pos
        while pos > 0 {
            let parent = (pos - 1) / 2;
            if ordered(data[parent], data[pos]) {
                break
            }
            data.swapAt(pos, parent)
            pos = parent
        }
    }
}

extension PriorityQueue: Sequence, IteratorProtocol {
    mutating func next() -> T? {
        return pop()
    }
}
// 第一引数に隣接リスト表現(重み付きver.)のグラフを渡す　graph[i] = [[iに隣接する頂点j, 辺の重み], …, …]
// 第二引数に始点を渡す
func dijkstra(graph:[[[Int]]],start:Int)->[Int]{
    let INF = Int.max
    let num = graph.count
    var dist = Array(repeating: INF, count: num) // 各ノードの頂点からの最短距離
    dist[start] = 0
    var q = PriorityQueue<(Int, Int)>(>=) // 「仮の最短距離, 頂点」が小さい順に並ぶ
    q.push((0,start)) // ノードの情報(始点からの距離,ノード名)
    while !q.isEmpty{
        //始点からの距離が一番短いノードの情報を取得
        let label = q.pop()!
        let prove_cost = label.0
        let src = label.1 
        
        if dist[src] < prove_cost{ // 最短距離で無ければ無視
            continue
        }
        for edge in graph[src]{
            let cost = edge[0]
            let dest = edge[1]
            if dist[dest] > dist[src]+cost{ // 最短距離候補なら プライオリティーキュー に追加
                dist[dest] = dist[src]+cost
                q.push((dist[dest],dest))
            }
        }
    }
    // 視点から各頂点までの最小コストをまとめた配列を返す
    return dist
}
