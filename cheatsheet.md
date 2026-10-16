# 1. `map`

## 1.1 基本構文

```cpp
#include <bits/stdc++.h>
using namespace std;

map<int, int> mp;
```

- キーと値のペアを管理する。
- キーは昇順に自動ソートされる。
- キーの重複は不可。
- 検索・挿入・削除は基本的に `O(log N)`。

## 1.2 よく使う操作

| 操作 | コード | 意味 |
|---|---|---|
| 宣言 | `map<int, int> mp;` | 整数キー・整数値 |
| 代入 | `mp[10] = 100;` | キー10の値を設定 |
| 取得 | `mp[10]` | 値を取得 |
| 要素数 | `mp.size()` | 登録された要素数 |
| 空判定 | `mp.empty()` | 空なら `true` |
| 挿入 | `mp.insert({10, 100});` | 要素を挿入 |
| 削除 | `mp.erase(10);` | キー10を削除 |
| 全削除 | `mp.clear();` | 全要素を削除 |
| 存在確認 | `mp.count(10)` | 存在すれば1 |
| 検索 | `mp.find(10)` | イテレータを返す |

## 1.3 要素の存在確認・検索

### `count()`：存在確認

```cpp
if (mp.count(10)) {
    cout << "存在する\n";
}
```

### `find()`：検索

```cpp
auto it = mp.find(10);

if (it != mp.end()) {
    cout << it->second << '\n';
}
```

見つからない場合は `mp.end()` を返す。

### `contains()`：存在確認（C++20以降）

```cpp
if (mp.contains(10)) {
    cout << "存在する\n";
}
```

**注意：** `mp[10]` は、キー10が存在しない場合に新しい要素を作成する。存在確認だけなら `find()` や `contains()` を使う。

## 1.4 追加・更新・削除

```cpp
map<int, string> mp;

// 追加・更新
mp[1] = "Alice";
mp[2] = "Bob";
mp[1] = "Carol";       // 値を更新

// 既存キーがある場合は上書きしない
mp.insert({1, "Dave"});

// C++17以降：存在しなければ追加
mp.try_emplace(3, "Eve");

// 削除
mp.erase(2);
```

- `mp[key] = value`：追加または更新。
- `insert()`：既存キーがあれば値を変更しない。
- `try_emplace()`：キーが存在しない場合のみ追加。
- `erase(key)`：キーを指定して削除。

## 1.5 ループ処理

### C++17以降：構造化束縛

```cpp
for (const auto& [key, value] : mp) {
    cout << key << " " << value << '\n';
}
```

### C++11以降：`first` と `second`

```cpp
for (const auto& p : mp) {
    cout << p.first << " " << p.second << '\n';
}
```

- `p.first`：キー
- `p.second`：値
- `begin()`：最小のキーを指す。
- `end()`：最後の要素の次を指す。

## 1.6 `lower_bound()` と `upper_bound()`

```cpp
auto it1 = mp.lower_bound(25); // キーが25以上の最初の要素
auto it2 = mp.upper_bound(25); // キーが25より大きい最初の要素
```

```cpp
auto it = mp.lower_bound(25);

if (it != mp.end()) {
    cout << it->first << '\n';
}
```

どちらも `O(log N)`。

## 1.7 出現回数のカウント

```cpp
vector<int> a = {1, 2, 1, 3, 2, 1};
map<int, int> freq;

for (int x : a) {
    freq[x]++;
}

for (const auto& p : freq) {
    cout << p.first << ": " << p.second << '\n';
}
```

出力：

```text
1: 3
2: 2
3: 1
```

`freq[x]++` は、キーが存在しなければ値0で作成してから1増やす。

## 1.8 `map` と `unordered_map` の比較

| 特徴 | `map` | `unordered_map` |
|---|---|---|
| ヘッダー | `<map>` | `<unordered_map>` |
| キーの順序 | 昇順 | 順序なし |
| 検索・挿入 | `O(log N)` | 平均 `O(1)` |
| 最悪計算量 | `O(log N)` | `O(N)` |
| `lower_bound()` | 使用可能 | 使用不可 |
| 用途 | 順序・範囲検索 | 順序不要の高速検索 |

## 1.9 `map` の計算量

| 操作 | 計算量 |
|---|---|
| `mp[key]` | `O(log N)` |
| `insert()` | `O(log N)` |
| `find()` / `count()` | `O(log N)` |
| `erase(key)` | `O(log N)` |
| `lower_bound()` / `upper_bound()` | `O(log N)` |
| `size()` / `empty()` | `O(1)` |
| 全要素の走査 | `O(N)` |

---

# 2. `priority_queue`

## 2.1 基本構文

```cpp
#include <bits/stdc++.h>
using namespace std;

priority_queue<int> pq;
```

- 優先度の高い要素から取り出すデータ構造。
- デフォルトでは最大ヒープ。
- `top()` で先頭要素を参照する。
- `pop()` で先頭要素を削除する。

## 2.2 よく使う操作

| 操作 | コード | 意味 |
|---|---|---|
| 宣言 | `priority_queue<int> pq;` | 最大ヒープ |
| 追加 | `pq.push(10);` | 要素を追加 |
| 参照 | `pq.top()` | 最大の要素を参照 |
| 削除 | `pq.pop();` | 最大の要素を削除 |
| 要素数 | `pq.size()` | 要素数を取得 |
| 空判定 | `pq.empty()` | 空なら `true` |
| 直接構築 | `pq.emplace(10);` | 要素を構築して追加 |

**注意：** `top()` は要素を削除しない。`pop()` の戻り値は `void`。

## 2.3 最大ヒープと最小ヒープ

### 最大ヒープ（デフォルト）

```cpp
priority_queue<int> pq;

pq.push(3);
pq.push(10);
pq.push(5);

cout << pq.top() << '\n'; // 10
```

### 最小ヒープ

```cpp
priority_queue<int, vector<int>, greater<int>> pq;

pq.push(3);
pq.push(10);
pq.push(5);

cout << pq.top() << '\n'; // 3
```

| 種類 | 宣言 | 先頭 |
|---|---|---|
| 最大ヒープ | `priority_queue<int> pq;` | 最大値 |
| 最小ヒープ | `priority_queue<int, vector<int>, greater<int>> pq;` | 最小値 |

最小ヒープはダイクストラ法などでよく使う。

## 2.4 要素を順番に取り出す

```cpp
priority_queue<int> pq;

pq.push(3);
pq.push(10);
pq.push(5);

while (!pq.empty()) {
    cout << pq.top() << '\n';
    pq.pop();
}
```

出力：

```text
10
5
3
```

最小ヒープの場合は `3 → 5 → 10` の順に取り出される。

## 2.5 `pair` を使う

デフォルトでは `first`、次に `second` の辞書順で最大の要素が優先される。

```cpp
priority_queue<pair<int, int>> pq;

pq.push({2, 100});
pq.push({5, 10});
pq.push({5, 20});

cout << pq.top().first << " "
     << pq.top().second << '\n';
```

出力：

```text
5 20
```

### 最小の `pair` を取り出す

```cpp
priority_queue<
    pair<int, int>,
    vector<pair<int, int>>,
    greater<pair<int, int>>
> pq;
```

`first`、次に `second` の昇順になる。

例えば `{距離, 頂点番号}` を格納すれば、距離が最小の要素を優先して取り出せる。

## 2.6 カスタム比較関数

構造体の `score` が小さい順に取り出す例。

```cpp
struct Node {
    int id;
    int score;
};

struct Compare {
    bool operator()(const Node& a, const Node& b) const {
        return a.score > b.score;
    }
};

priority_queue<Node, vector<Node>, Compare> pq;
```

- `a.score > b.score`：小さい値を優先。
- `a.score < b.score`：大きい値を優先。

比較関数は、優先度の低い要素を後ろに回すように定義する。

## 2.7 `priority_queue` の計算量

要素数を `N` とする。

| 操作 | 計算量 |
|---|---|
| `top()` | `O(1)` |
| `push()` | `O(log N)` |
| `emplace()` | `O(log N)` |
| `pop()` | `O(log N)` |
| `empty()` | `O(1)` |
| `size()` | `O(1)` |
| 全要素の取り出し | `O(N log N)` |

## 2.8 `queue`・`stack` との比較

| データ構造 | 取り出す順序 | 主な操作 |
|---|---|---|
| `queue` | 先に入れた要素から | `front()`, `pop()` |
| `stack` | 最後に入れた要素から | `top()`, `pop()` |
| `priority_queue` | 優先度が高い要素から | `top()`, `pop()` |

## 2.9 注意点

- 空の状態で `top()` や `pop()` を呼ばない。
- `top()` が返す参照は、要素を削除した後に使わない。
- 標準の `priority_queue` には任意の要素を直接削除する機能がない。
- 要素を取り出すたびに優先度の高い要素が先頭になる。

---

# 3. 最低限覚えるテンプレート

## `map`

```cpp
map<int, int> mp;

// 追加・更新
mp[5] = 10;

// 存在確認・検索
auto it = mp.find(5);
if (it != mp.end()) {
    cout << it->second << '\n';
}

// 全要素をキーの昇順で走査
for (const auto& p : mp) {
    cout << p.first << " " << p.second << '\n';
}

// 境界検索
auto lb = mp.lower_bound(5);

// 削除
mp.erase(5);
```

## `priority_queue`

```cpp
// 最大ヒープ
priority_queue<int> max_pq;

// 最小ヒープ
priority_queue<int, vector<int>, greater<int>> min_pq;

max_pq.push(10);
max_pq.push(3);
max_pq.push(5);

min_pq.push(10);
min_pq.push(3);
min_pq.push(5);

cout << max_pq.top() << '\n'; // 10
cout << min_pq.top() << '\n'; // 3

max_pq.pop();
min_pq.pop();
```

## 1. `sort()`：ソート

ヘッダー：`#include <algorithm>`

### 1.1 昇順ソート

```cpp
vector<int> a = {5, 2, 8, 1, 3};

sort(a.begin(), a.end());

// {1, 2, 3, 5, 8}
```

### 1.2 降順ソート

```cpp
sort(a.begin(), a.end(), greater<int>());

// {8, 5, 3, 2, 1}
```

### 1.3 配列（C-style array）のソート

```cpp
int a[] = {5, 2, 8, 1, 3};
int n = 5;

// 昇順
sort(a, a + n);

// 降順
sort(a, a + n, greater<int>());
```

### 1.4 `pair` のソート

デフォルトでは `first`、次に `second` の昇順。

```cpp
vector<pair<int, int>> a = {
    {2, 30}, {1, 20}, {2, 10}
};

sort(a.begin(), a.end());

// {(1,20), (2,10), (2,30)}
```

### 1.5 カスタム比較関数

`second` の昇順でソートする例。

```cpp
sort(a.begin(), a.end(),
    [](const auto& x, const auto& y) {
        return x.second < y.second;
    }
);
```

降順なら `<` を `>` に変更する。

### 1.6 計算量

| 操作 | 計算量 |
|---|---|
| `sort()` | `O(N log N)` |
| `reverse()` | `O(N)` |

---

## 2. `reverse()`：順序を反転

```cpp
vector<int> a = {1, 2, 3, 4, 5};

reverse(a.begin(), a.end());

// {5, 4, 3, 2, 1}
```

**注意：** `reverse()` はソートではない。元の順序を単純に反転する。

すでに昇順にソートされた配列なら、`reverse()` で降順にできる。

```cpp
sort(a.begin(), a.end());
reverse(a.begin(), a.end());
```

ただし、最初から降順にするなら `sort(a.begin(), a.end(), greater<int>())` でよい。

---

## 3. `lower_bound()`：下限の二分探索

ヘッダー：`#include <algorithm>`

**昇順配列で、値 `x` 以上となる最初の位置を返す。**

```cpp
vector<int> a = {1, 2, 2, 2, 4, 6};

auto it = lower_bound(a.begin(), a.end(), 2);

cout << it - a.begin(); // 1
```

`lower_bound()` はイテレータを返す。

| 目的 | コード |
|---|---|
| 位置を取得 | `lower_bound(a.begin(), a.end(), x) - a.begin()` |
| 値を取得 | `*lower_bound(a.begin(), a.end(), x)` |
| 存在確認 | `it != a.end() && *it == x` |

### 3.1 見つからない場合

```cpp
auto it = lower_bound(a.begin(), a.end(), 5);

if (it != a.end()) {
    cout << *it << '\n';
} else {
    cout << "見つからない\n";
}
```

配列 `{1, 2, 2, 2, 4, 6}` では、5以上の最初の値は6。

**注意：** `it == a.end()` のときに `*it` を参照してはいけない。

---

## 4. `upper_bound()`：上限の二分探索

**昇順配列で、値 `x` より大きい最初の位置を返す。**

```cpp
vector<int> a = {1, 2, 2, 2, 4, 6};

auto it = upper_bound(a.begin(), a.end(), 2);

cout << it - a.begin(); // 4
```

### 4.1 `lower_bound()` との違い

配列 `{1, 2, 2, 2, 4, 6}` の場合：

| 関数 | 探す条件 | `x = 2` の位置 |
|---|---|---:|
| `lower_bound()` | `>= x` | 1 |
| `upper_bound()` | `> x` | 4 |

### 4.2 値 `x` の出現回数

```cpp
int cnt = upper_bound(a.begin(), a.end(), x)
        - lower_bound(a.begin(), a.end(), x);
```

### 4.3 値 `x` の出現範囲

```cpp
auto l = lower_bound(a.begin(), a.end(), x);
auto r = upper_bound(a.begin(), a.end(), x);

// [l, r) が x の範囲
```

`l` は最初の `x`、`r` は最後の `x` の次の位置。

---

## 5. 降順配列での `lower_bound()`・`upper_bound()`

降順配列では、**比較関数に `greater<int>()` を指定する**。

### 5.1 降順配列の作成

```cpp
vector<int> a = {1, 5, 3, 8, 2};

sort(a.begin(), a.end(), greater<int>());

// {8, 5, 3, 2, 1}
```

### 5.2 降順での `lower_bound()`

```cpp
auto it = lower_bound(
    a.begin(), a.end(), 3, greater<int>()
);
```

降順配列での `lower_bound()` は、**`x` 以下となる最初の位置**を返す。

例えば `{8, 5, 3, 2, 1}` で `x = 3` なら、値3の位置を返す。

### 5.3 降順での `upper_bound()`

```cpp
auto it = upper_bound(
    a.begin(), a.end(), 3, greater<int>()
);
```

降順配列での `upper_bound()` は、**`x` 未満となる最初の位置**を返す。

例えば `{8, 5, 3, 2, 1}` で `x = 3` なら、値2の位置を返す。

### 5.4 昇順と降順の比較

| 関数 | 昇順配列 | 降順配列（`greater<int>()`） |
|---|---|---|
| `lower_bound(x)` | `>= x` の最初 | `<= x` の最初 |
| `upper_bound(x)` | `> x` の最初 | `< x` の最初 |

**重要：** 二分探索の比較条件は、配列をソートしたときの比較条件と一致させる。

---

## 6. `binary_search()`：存在確認

ソート済みの配列に値が存在するかを `bool` で返す。

### 昇順

```cpp
sort(a.begin(), a.end());

bool found = binary_search(
    a.begin(), a.end(), 3
);
```

### 降順

```cpp
sort(a.begin(), a.end(), greater<int>());

bool found = binary_search(
    a.begin(), a.end(), 3, greater<int>()
);
```

| 関数 | 戻り値 |
|---|---|
| `binary_search()` | 存在すれば `true` |
| `lower_bound()` | 条件を満たす最初の位置 |
| `upper_bound()` | 条件を満たす最初の位置 |

---

## 7. `equal_range()`：同じ値の範囲

`lower_bound()` と `upper_bound()` の結果をまとめて取得する。

```cpp
vector<int> a = {1, 2, 2, 2, 4, 6};

auto p = equal_range(a.begin(), a.end(), 2);

cout << p.first - a.begin() << '\n';  // 1
cout << p.second - a.begin() << '\n'; // 4
```

- `p.first`：最初の `2`
- `p.second`：最後の `2` の次の位置

出現回数は `p.second - p.first` で求められる。

---

## 8. `greater<int>()` とラムダ式の使い分け

### `greater<int>()`

```cpp
sort(a.begin(), a.end(), greater<int>());
```

整数などを降順にするときに簡潔。

### ラムダ式

```cpp
sort(a.begin(), a.end(),
    [](int x, int y) {
        return x > y;
    }
);
```

独自の条件でソートしたい場合に便利。

### `pair` を `second` の降順にする

```cpp
sort(a.begin(), a.end(),
    [](const auto& x, const auto& y) {
        return x.second > y.second;
    }
);
```

同じ `second` のとき `first` の昇順にする例：

```cpp
sort(a.begin(), a.end(),
    [](const auto& x, const auto& y) {
        if (x.second != y.second) {
            return x.second > y.second;
        }
        return x.first < y.first;
    }
);
```

## 9. 計算量まとめ

要素数を `N` とする。

| 操作 | 計算量 |
|---|---|
| `sort()` | `O(N log N)` |
| `reverse()` | `O(N)` |
| `lower_bound()` | `O(log N)`（`vector` などのランダムアクセスイテレータ） |
| `upper_bound()` | `O(log N)`（`vector` などのランダムアクセスイテレータ） |
| `binary_search()` | `O(log N)`（`vector` などのランダムアクセスイテレータ） |
| `equal_range()` | `O(log N)`（`vector` などのランダムアクセスイテレータ） |

※ `set` や `map` では、独自のメンバ関数 `lower_bound()` / `upper_bound()` を使うと効率的。`std::lower_bound()` をそれらのイテレータに適用すると、比較回数は対数でもイテレータ移動が線形になる場合がある。

---

## 10. 競技プログラミング用テンプレート

```cpp
#include <bits/stdc++.h>
using namespace std;

int main() {
    vector<int> a = {1, 2, 2, 2, 4, 6};

    // 昇順ソート
    sort(a.begin(), a.end());

    int x = 2;

    // x 以上の最初の位置
    int l = lower_bound(
        a.begin(), a.end(), x
    ) - a.begin();

    // x より大きい最初の位置
    int r = upper_bound(
        a.begin(), a.end(), x
    ) - a.begin();

    // x の出現回数
    int cnt = r - l;

    // 存在確認
    bool found = binary_search(
        a.begin(), a.end(), x
    );

    // 降順ソート
    sort(a.begin(), a.end(), greater<int>());

    // 降順配列での二分探索
    auto it = lower_bound(
        a.begin(), a.end(), x, greater<int>()
    );

    cout << l << " " << r << " "
         << cnt << " " << found << '\n';
}
```

## 11. ポイントまとめ

| やりたいこと | コード |
|---|---|
| 昇順ソート | `sort(a.begin(), a.end());` |
| 降順ソート | `sort(a.begin(), a.end(), greater<int>());` |
| 配列を反転 | `reverse(a.begin(), a.end());` |
| 昇順で `x` 以上の位置 | `lower_bound(a.begin(), a.end(), x)` |
| 昇順で `x` より大きい位置 | `upper_bound(a.begin(), a.end(), x)` |
| 降順で `x` 以下の位置 | `lower_bound(a.begin(), a.end(), x, greater<int>())` |
| 降順で `x` 未満の位置 | `upper_bound(a.begin(), a.end(), x, greater<int>())` |
| 出現回数 | `upper_bound(...) - lower_bound(...)` |
| 存在確認 | `binary_search(...)` |
