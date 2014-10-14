Description
------
Felwoodの食材を集めるのに特化したAddonです。主にタイマ管理を目的としています。
Whipper Root Tuber(ダイコン)とWindblossom Berries(ブドウ)、Night Dragon's Breath
(メロン)に対応しています。
・FelwoodのWorld Detail MapにSpawn位置を表示します。
・ダイコン、メロンを拾うとタイマを起動し、ETAを表示します。
・食材がRepopする5分、1分前にChatFrameに通知し、サウンドを鳴らします。
・Group/Raid内でタイマーをShareすることも出来ます
　（有効なタイマだけを交換。ずれてる場合は上書き)
・タイマのReset/Announce/ShareをLandkmark IconをクリックすることでPopupするメニューから行えます。
・WSGCommanderのようなMinimapを表示できます。

Usage
------
インストールするだけです。依存するAddonもありません。

*コマンド
持っているタイマをShareしたい場合は、
/fwg share
とコマンドを入力してください。
または、アイコンをクリックするとメニューが表示されるので、そこから実行してください。
/fwg config
と打つと設定画面が表示されます。
  - Accept timer: 他の人からTimerのブロードキャストを受けたくない場合Checkを外します。
  - Notify: 音つきでそろそろPopする場所の通知を受けます。
  - Notification 1/2: ETA設定時間に通知メッセージを受けます。
  - Transparency: ワールドマップ上での透明度を指定します。
  - Icon size: ワールドマップ上のアイコンのサイズを指定します。.
/fwg count
と打つとカウントダウンをコールします。Windowを開いたままでカウントダウンを待ち、一緒にPickupしましょう。
/fwg map
と打つとミニマップを表示します。

*コンフィグ画面
  - Accept timer: shareによるタイマの通知を受け入れて自分の管理しているタイマに反映します。
  - Notify: Spawnの通知メッセージ機能を利用します。
  - Notification 1/2: 通知メッセージをトリガする時刻を設定します。
  - Transparency: マップ上のアイコン、ラベルの透明度を設定します。
  - Icon size: マップ上のアイコンサイズを設定します。.
ミニマップのタイトルバーを右クリックするとメニューが表示されます。
マップのコンフィグでは以下の設定が出来ます。
  - Transparency: ミニマップの透明度を設定します。
  - Scale: ミニマップのサイズを変更します。.
  -　Auto show： ミニマップの表示を自動的に行います。
*メニュー
マップ上のアイコンをクリックすると表示されます。
Reset - そのアイコンのタイマをリセットします。
announce - そのアイコンのETA等情報をChannelに流します。
share - 持っているタイマをブロードキャストします。

* キーバインド
 Toggle Config Window - コンフィグ画面を開きます。
 Countdown call - カウントダウンをコールします。

* タイマの表示色
マップ上に表示されるETAのテキストは以下の条件で色が変わります。
ETA > notification 1                  - 緑
notification 2 < ETA < notification 1 - 黄色
ETA < notification 2                  - 赤
次にPopする場所　　　　　             - 白

History
------
Readme.txt参照
