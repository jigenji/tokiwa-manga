# トキワマンガ（検証用サービス）を Render で公開する

このフォルダの中身（Dockerfile・README.md・app.tar.gz.part-00〜）を、そのまま GitHub の新しいリポジトリに上げます。

1. GitHub で新しいリポジトリを作る（Public）。
2. 「Add file → Upload files」に、このフォルダの中のファイルをすべてドラッグして「Commit changes」。
   （1ファイル20MB以下に分けてあるので、ブラウザから上げられます）
3. Render で「New → Web Service」→「Public Git Repository」にリポジトリのURLを入れる。
   - Language: Docker（自動で選ばれる）
   - Instance type: Starter 以上（記録を残すディスクを付けるため）
4. 「Advanced」で次を設定する。
   - Disk：Mount Path `/data`、Size 1GB
   - Environment Variables：
     - `SITE_PASSWORD` 読者サイトの合い言葉（知っている人だけが読める。外すと誰でも読める）
     - `ADMIN_PASSWORD` 管理画面のパスワード
     - `SESSION_SECRET` 長いランダムな文字列
     - `OPERATOR_NAME` 運営者名（利用規約・プライバシーポリシーに出る）
     - `CONTACT_EMAIL` 問い合わせ先
   - Health Check Path：`/healthz`
5. 「Deploy Web Service」。できた `https://○○.onrender.com` を配る。管理画面は `/admin`。

- 読者はアカウントなしで、最初に合い言葉を入れて読みます（端末ごとに30日有効）。読んだ記録（名前・メールは取らない）はディスクに残り、管理画面で見られます。
- 入口を分けるときは、配るリンクに `?src=panel&seg=20s-30s-f` などを付けます（管理画面の「リンクの作成」）。
- 中身を更新するときは、新しい app.tar.gz.part-* に置き換えて、Render で「Manual Deploy」。
