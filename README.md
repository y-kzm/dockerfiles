# Dockerfiles.
## Frequently used docker commands.
### Container.
- コンテナ操作コマンド．
~~~
$ docker container [副コマンド] [オプション]
~~~
> "container"部は省略可．

| 副コマンド | 内容 | 
|:---|:--- |:--- |
| start | コンテナ開始． | 
| stop | コンテナ停止． |  
| create | イメージからコンテナを作成． |  
| run | イメージをダウンロードし，コンテナを作成して起動．(image pull > container create > container start) |  
| rm | 停止したコンテナを削除． |  |
| exec | 実行中コンテナでプログラム実行． |  
| ls | コンテナ一覧を表示． |  
| cp | コンテナ-ホスト間でファイルコピー． |  
| commit | コンテナをイメージに変換． |  

[Option]: https://qiita.com/TaaaZyyy/items/4ecf21f23e6730faf696 
> 主なオプション[Option]．
