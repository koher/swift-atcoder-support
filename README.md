# AtCoderSupport

Swift で AtCoder に取り組むためのサポートライブラリです。標準ライブラリや Foundation に不足しているアルゴリズムやデータ構造等が実装されています。

Swift Package 形式になっていますが、 AtCoder で利用する際には必要なものをコピペして利用して下さい。 Swift Package を採用しているのはテストの実行が容易なためです。

コピペを前提としているため、すべての API は `public` でなく無印の `internal` として実装されています。また、本パッケージ内も含めて極力他の API に依存なく、関数や `extension` 単体でコピペできるようにしています。

## 利用例

| アルゴリズム・データ構造 | API | 利用例 |
|:--|:--|:--|
| 順列 | `permutations()` | [ABC 145 C - Average Length](https://atcoder.jp/contests/abc145/submissions/17547859) |
| 二分探索 | `values(_:_:)` | [ABC 077 C - Snuke Festival](https://atcoder.jp/contests/abc077/submissions/17547635) |
| 幅優先探索 | `dfs(edges:startedAt:_:)` | [ABC 138 D - Ki](https://atcoder.jp/contests/abc138/submissions/17546144) |
| 素数判定 | `isPrime` | [ABC 149 C - Next Prime](https://atcoder.jp/contests/abc149/submissions/17548101) |

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
