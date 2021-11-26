# Dockerfiles.
---

## Frequently used docker commands.
[オプション]: https://qiita.com/TaaaZyyy/items/4ecf21f23e6730faf696 
> 主な[オプション]．

---
### Container.
- コンテナ操作コマンド．
~~~
$ docker container [副コマンド] [オプション]
~~~
> "container"部は省略可．

| 副コマンド | 内容 | 
| :----- | :----- |
| start  | コンテナ開始． | 
| stop  | コンテナ停止． |  
| create  | イメージからコンテナを作成． |  
| run  | イメージをダウンロードし，コンテナを作成して起動．  (image pull > container create > container start) |  
| rm  | 停止したコンテナを削除． |  |
| exec  | 実行中コンテナでプログラム実行． |  
| ls  | コンテナ一覧を表示． |  
| cp  | コンテナ-ホスト間でファイルコピー． |  
| commit  | コンテナをイメージに変換． |  

---
### Image.
- イメージ操作コマンド．
~~~
$ docker image [副コマンド] [オプション]
~~~

| 副コマンド | 内容 | 
| :----- | :----- |
| pull  | イメージのダウンロード． | 
| rm  | イメージの削除． | 
| ls  | 自分がダウンロードしたイメージ一覧を表示． | 
| build  | イメージを作成する． | 

[Docker Hub]: https://hub.docker.com 
> [Docker Hub].
> docker image ls -> docker images
> docker image rm -> docker rmi

---
### Volume.
- ボリューム操作コマンド．
~~~
$ docker volume [副コマンド] [オプション]
~~~

| 副コマンド | 内容 | 
| :----- | :----- |
| create  | ボリュームを作成． | 
| inspect  | ボリュームの詳細を表示． | 
| ls  | ボリューム一覧を表示． | 
| prune  | 現在マウントされていないボリュームを削除． | 
| rm  | ボリュームの削除． |

---
### Network.
- ネットワーク操作コマンド．
~~~
$ docker network [副コマンド] [オプション]
~~~

| 副コマンド | 内容 | 
| :----- | :----- |
| connect  | コンテナをネットワークに接続． | 
| disconnect  | コンテナをネットワークから切断． | 
| create  | ネットワークを作成． | 
| inspect  | ネットワークの詳細を表示． | 
| ls  | ネットワーク一覧を表示． | 
| prune  | 現在コンテナが接続されていないネットワークを削除． | 
| rm  | ネットワークの削除． | 

### etc.
- その他のコマンド．
    - <'none'> TAG の削除．
    ~~~
    $ docker rmi $(docker images -f "dangling=true" -q)
    ~~~

