# AtCoderSupport

Swift で AtCoder に取り組むためのサポートライブラリです。標準ライブラリや Foundation に不足しているアルゴリズムやデータ構造等が実装されています。

Swift Package 形式になっていますが、 AtCoder で利用する際には必要なものをコピペして利用して下さい。 Swift Package を採用しているのはテストの実行が容易なためです。

コピペを前提としているため、すべての API は `public` でなく無印の `internal` として実装されています。また、本パッケージ内も含めて極力他の API に依存なく、関数や `extension` 単体でコピペできるようにしています。

## 利用例

| アルゴリズム・データ構造 | API | 利用例 |
|:--|:--|:--|
| 二次元配列 | `Array2D` | [ABC 182 E - Akari](https://atcoder.jp/contests/abc182/submissions/17978677) |
| 三次元配列 | `Array3D` | [ABC 184 D - increment of coins](https://atcoder.jp/contests/abc184/submissions/18377096) |
| N次元配列 | `ArrayND` | [ABC 184 D - increment of coins](https://atcoder.jp/contests/abc184/submissions/18377137) |
| 順列 | `permutations()` | [ABC 145 C - Average Length](https://atcoder.jp/contests/abc145/submissions/17547859) |
| nCr | `NCR` | [ABC 151 E - Max-Min Sums](https://atcoder.jp/contests/abc151/submissions/17937622) |
| 二分探索 | `values(_:_:)` | [ABC 077 C - Snuke Festival](https://atcoder.jp/contests/abc077/submissions/17547635) |
| 深さ優先探索 | `dfs(edges:startedAt:_:)` | [ABC 138 D - Ki](https://atcoder.jp/contests/abc138/submissions/17661705) |
| 幅優先探索 | `bfs(edges:startedAt:,_:)` | [ABC 190 E - Magical Ornament](https://atcoder.jp/contests/abc190/submissions/24337525) |
| 素数判定 | `isPrime` | [ABC 149 C - Next Prime](https://atcoder.jp/contests/abc149/submissions/17548101) |
| ベルマン–フォード法 | `bellmanFord(graph:startedAt)` | [ABC 061 D - Score Attack](https://atcoder.jp/contests/abc061/submissions/18111027) |
| ダイクストラ法 | `dijkstra(graph:startedAt:)` | [ABC 035 D - トレジャーハント](https://atcoder.jp/contests/abc035/submissions/17662367) |
| ワーシャル–フロイド法 | `warshallFloyd(graph:)` | [ABC 143 E - Travel by Car](https://atcoder.jp/contests/abc143/submissions/18082582) |
| 巡回セールスマン問題 | `tsp(distances:startedAt:)` | [ABC 180 E - Traveling Salesman among Aerial Cities](https://atcoder.jp/contests/abc180/submissions/17561600) |
| Union-Find | `UnionFind` | [ARC 032 B - 道路工事](https://atcoder.jp/contests/arc032/submissions/17591100) |
| mod | `ModInt` | [ARC 107 A - Simple Math](https://atcoder.jp/contests/arc107/submissions/17766344) |
| mod | `%+`, `%*`, `%+=` 等 | [ABC 151 E - Max-Min Sums](https://atcoder.jp/contests/abc151/submissions/17937622) |
| 範囲の和 | `ClosedRange.sum(modulus:)` | [ARC 107 A - Simple Math](https://atcoder.jp/contests/arc107/submissions/17766344) |
| 安全な範囲演算子 | `..<?`, `...?` | [ABC 192 D - Base n](https://atcoder.jp/contests/abc192/submissions/20355912) |
| オーバーフロー安全な算術演算子 | `+?`, `-?`, `*?` | [ABC 192 D - Base n](https://atcoder.jp/contests/abc192/submissions/20355912) |

## テスト

通常の Swift Package 同様 `swift test` でテストを実行できますが、パフォーマンステストなど最適化を必要とする場合は次のようなオプションが必要になります。これは、 `internal` な API をテストするために `@testable import` を利用しているため、通常の `swift test -c release` ではテストを実行できないからです。

```
swift test -c release -Xswiftc -enable-testing
```

`-Ounchecked` で実行するには次のようにします。

```
swift test -c release -Xswiftc -enable-testing -Xswiftc -Ounchecked
```

## `precondition`

コード中に `precondition` が含まる場合がありますが、 AtCoder では `-Ounchecked` でコンパイルされるため実行時にはすべて取り除かれます。そのため、 `precondition` のオーバーヘッドを気にする必要はありません。

ローカル環境で実行する際には、最適化オプションなしで実行することでコードの事前条件違反を素早く検出することができます。

```swift
// main.swift
func dfs(edges: [[Int]], startedAt start: Int, _ body: (Int) -> Void) {
    precondition(edges.indices.contains(start), "`start` index is out of bounds: \(start)")
    // 省略
}

dfs(edges: [[1, 2], [], []], startedAt: -1) { _ in }
```

```
$ swift main.swift 
Precondition failed: `start` index is out of bounds: -1
```

## License

CC0
