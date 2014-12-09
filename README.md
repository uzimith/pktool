他の計算機と合わないのでダメージ計算式が間違っているようです。

# Pktool
Pktoolはポケモンのレート対戦の技選択時間１分の間になるべく様々な情報を得ることを目標としたツールです。
オフラインで動作するため、高速での検索を可能とします。

1. ダメージ計算（開発中）
2. ポケモンの能力値確認
3. パーティメモ（開発中）
4. 素早さ確認（開発中）

データはとりあえず暇ツール(http://blog.livedoor.jp/hima_shi/)のデータベースからです。

## 使い方

```
$ pktool info

なまえ>ガブリアス
せいかく>いじっぱり
努力値(default: 0)>hAS
個体値(default: 6V)>
種族値
H:108 A:130 B:95 C:80 D:85 S:102 重さ:95.0
能力値
H:184 A:200 B:115 C:90 D:105 S:154
```

```
$ pktool damage
攻撃側の指定
なまえ>ガブリアス
せいかく>いじっぱり
努力値(default: 0)>AS
個体値(default: 6V)>
防御側の指定
なまえ>クレセリア
せいかく>ずぶとい
努力値(default: 0)>HB
個体値(default: 6V)>
技の指定
わざ>げきりん

攻撃側
ガブリアス H:183 A:200 B:115 C:90 D:105 S:154
防御側
クレセリア H:227 A:81 B:189 C:95 D:150 S:105

min:72 max:85
確定数:4回 (31.72%)

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
