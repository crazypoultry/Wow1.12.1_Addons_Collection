===================================================
== ChatAssist Ver 0.28 (World of Warcraft AddOn) ==
===================================================

■ ChatAssistについて
  World of Warcraft上で日本語によるチャットが可能になり、
  キーワード、タイムスタンプ、マウスホイールなどの便利な機能を追加するAddonです。

■ インストール
  chatassist028.zipを解凍後、ChatAssistフォルダを
  World of Warcraftインストールフォルダ\Interface\AddOnsの中に移動します。
  その後、World of Warcraftインストールフォルダ\Interface\AddOns\ChatAssist\install_win.bat
  を実行してフォントをインストールしてください。
  フォントを手動でコピーする場合は、お好きなフォントを
    World of Warcraftインストールフォルダ\Interface\AddOns\ChatAssist\font01.ttf
  の位置にコピーしてください。

■ 使用方法

  設定ウィンドウを表示
    /ca

  キーワードの追加
    /ca add キーワード

  キーワードの削除
    /ca del キーワード

  キーワードの表示
    /ca list

  チャットモードをチャンネルに固定可能にする
    /ca channelsticky

  チャットモードをOfficerチャットに固定可能にする
    /ca officersticky

  チャットモードをWhipserチャットに固定可能にする
    /ca whispersticky

  タイムスタンプの表示・非表示
    /ca ts

  タイムスタンプのフォーマット変更
    /ca tsformat %I:%D %p

    タイムスタンプのフォーマットに利用可能なキーワードは下記のものが使用可能です。

    %H 24時間表記での時 (00-23)
    %I 12時間表記での時 (01-12)
    %M 分 (00-59)
    %S 秒 (00-59)
    %p 午前or午後 小文字 (am or pm)
    %P 午前or午後 大文字 (AM or PM)

  各チャットウィンドウでのキーワード、タイムスタンプ等の有効/無効
    /ca window [WindowId(1-7)]
    (デフォルトでは1がGeneral、2がCombat Logです。)

  Logging
    /ca log

  キーワード反応履歴を表示
    /ca history

  チャンネル名を短縮
    /ca shorttag

  チャンネル名を消去
    /ca hidetag

  名前をクラス別に色分け
    /ca colorname

  Unicode Blockのオン/オフ
    /ca ub

  各チャンネルでのUnicodeの有効/無効
    /ca ub [party|raid|raidwarning|guild|officer]

  デフォルトのチャットモード
    /ca defaultchat [say|party|raid|guild|officer]

  スクリーン表示
    /ca onscreen [keyword|auction|raidleader|bgleader|officer||whisper]

■ 更新履歴
  Ver 0.28 2006/09/19
    ・Unicode Blockを無効にするオプションを追加
    ・オンスクリーン表示が機能していなかった不具合を修正

  Ver 0.27 2006/09/16
    ・ギルドメンバーのClassを取得出来ていなかった不具合を修正
    ・複数のウィンドウを表示している時に同じメッセージによるイベントが複数回発生していた不具合を修正
    ・ChatAssistOptionsで設定が保存されない不具合を修正

  Ver 0.26 2006/09/06
    ・デフォルトのチャットモード設定を追加
    ・キーワード、オークションなどのスクリーン表示を追加
    ・WhisperStickyを追加
    ・デフォルトの設定をTimestampオン、ColorNameオンに変更
    ・キーワードがチャット以外に反応していた不具合を修正

  Ver 0.25 2006/08/24
    ・キーバインドを追加(/bg)
    ・ShortTag/HideTagにBattleground、Battleground Leaderを追加
    ・CrossRealm BattlegroundでColorNameが機能しない不具合を修正

  Ver 0.24 2006/08/23
    ・Interfaceバージョンを11200に変更
    ・チャンネルでItemLinkが表示されない不具合を修正

  Ver 0.23 2006/08/12
    ・設定GUIを追加
    ・キーバインドを追加(/10,/rw)
    ・myAddOnsに対応
    ・チャットパーサーを書き直し。
    ・タグを消している場合もチャンネル番号を表示出来るように変更 (/ca hidechannel)
    ・ShortTag有効時にチャンネル番号が10以上の場合にチャンネル番号が表示されなかった不具合を修正

  Ver 0.22 2006/07/28
    ・チャンネル名を消去する機能を追加
    ・ターゲットにTellを送信するコマンドを追加(/tt)
    ・一部の公開チャンネルでUnicode/日本語が使用出来ていた不具合を修正
    ・/ca windowの引数に文字列をいれるとエラーが出た不具合を修正
    ・/ca listでキーワードを表示した時にキーワード反応していた不具合を修正

  Ver 0.21 2006/07/26
    ・ChatFrameのShift+マウスホイールで最上部/最下部、Ctrl+マウスホイールでページ単位のスクロールが可能になりました。
    ・Unicode BlockにRaidWarning、Officerを追加しました。
    ・UnicodeはGuildRecruitmentチャンネルで使用出来なくなります。
    ・ローカライズのためにチャンネル名はファイルを分離しました。
    ・ShortTagが有効にもかかわらずOfficerが省略されない不具合を修正

  Ver 0.20 2006/07/23
    ・メールで日本語が利用出来るようになります。

  Ver 0.19 2006/07/04
    ・Raid Warningで日本語が利用出来るようになります。

  Ver 0.18 2006/06/28
    ・ShortTagの文字表記を変更 (Party→PT、Raid→RD、Raid Warning→RW、Guild→GL)
    ・Ver0.16でのSendMessageの不具合修正により/afk、/dndコマンドが利用出来なくなっていた不具合を修正

  Ver 0.17 2006/06/22
    ・ShortTagで文字表記を変更 (Party→PT、Raid→RD、Raid Leader→RL、Guild→GL)

  Ver 0.16 2006/06/20
    ・Interfaceバージョンを11100に変更
    ・SendMessageの不具合を修正

  Ver 0.15 2006/05/15
　　・CT_RaidAssistのスクリーンメッセージ(/rs)で日本語が利用出来るようになりました。
    ・アイテムリンクを2つ以上貼った場合正常に表示されない不具合を修正

  Ver 0.14 2006/05/13
    ・チャンネル切り替えのKeyBindingを追加
    ・オークションログにデバッグメッセージが入る事がある不具合を修正

  Ver 0.13 2006/05/12
    ・一部のアイテムがアイテムリンクされない不具合を修正

  Ver 0.12 2006/05/12
    ・ユーザチャンネルにアイテムリンクを張れる機能を追加(CopyLink互換)

  Ver 0.11 2006/05/07
    ・HistoryウィンドウのKeyBindをKeyword、Auction個別設定に変更
    ・ColorNameをONにした時にClassCacheを再生成するように変更
    ・URL抽出の正規表現を変更
    ・キーワードの検索対象をSay,Party,Raid,Guild,Channel,Whisperに限定
    ・URL抽出の対象をSay,Party,Raid,Guild,Channel,Whisperに限定
    ・オークションログに落札、落札圏外も記録されるように変更
    ・ゾーン時にイベントを解除するように変更
    ・オークションログが正しく記録されない不具合を修正
    ・LocalDefense、WorldDefenseでの発言でShortTagが機能しない不具合を修正

  Ver 0.10 2006/05/03
    ・ColorNameが有効の場合Rogueを認識出来ない不具合を修正

  Ver 0.09 2006/05/03
    ・KeyBindにスクリーンショットを追加
    ・KeyBindでHistoryウィンドウを開いた場合に内容が表示されない不具合を修正
    ・ShortTagが有効にもかかわらずGuildが省略されない不具合を修正

  Ver 0.08 2006/05/03
    ・オークションのログを追加
    ・チャットのKeyBinding追加
　　・クラスの色を変更
　　・英数文字もUnicode判定されてしまう不具合を修正
    ・URLウィンドウの横幅を変更

  Ver 0.07 2006/05/03
    ・クラス別の名前の色分けを追加
    ・チャンネル名短縮機能を追加
    ・チャンネル毎のUnicodeの有効・無効切り替えを追加
    ・ローカライズ用にファイルを分離

  Ver 0.06 2006/05/02
    ・URLをコピーする機能を追加
    ・キーワード反応履歴を追加
    ・Say,Emote,Yell,Public Channelで日本語を使用出来なくなります。

  Ver 0.05 2006/05/01
    ・ChatFrame個別に有効/無効切り替えを実装
    ・Logging機能を追加

  Ver 0.04 2006/04/30
    ・ChatFrameでのマウスホイールを有効化
    ・タイムスタンプ機能を追加
    ・ユーザチャンネルに固定する機能を追加

  Ver 0.03 2006/04/29
    ・コマンドによるキーワードの表示/追加/削除を実装

  Ver 0.02 2006/04/28
    ・自分の名前に反応する不具合を修正

  Ver 0.01 2006/04/27
    ・First Release
