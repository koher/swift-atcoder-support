struct UnionFind {
    var par:[Int]
    var rank:[Int]
    var n:Int
    init(n:Int){
        self.n = n
        self.par = Array(repeating:0,count:n)
        self.rank = Array(repeating:0,count:n)
        for i in 0..<n{
            par[i] = i
        }
    }
    mutating func root(x:Int) -> Int {
        if par[x] == x{
            return x
        }
        else{
            return root(x:par[x])
        }
    }
    mutating func unite (x:Int,y:Int){
        let x = root(x:x)
        let y = root(x:y)
        if x == y{
            return
        }
        if rank[x] < rank[y]{
            par[x] = y
        } else {
            par[y] = x
            if rank[x] == rank[y]{
                rank[x] += 1
            }
        }
    }
    mutating func same(x:Int,y:Int)->Bool{
        return root(x:x) == root(x:y)
    }
}