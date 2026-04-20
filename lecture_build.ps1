# ０．初期化（テンプレート） ナビゲーションメニュー（目次リスト）
# npm create slidev@latest

# npm install @slidev/cli@0.49.29
# npx @slidev/cli --version     52.14.2

# .gitフォルダ削除
# git init
# git add .
# git commit -m "init"
# git remote add origin https://github.com/moriees0473-uiGIT/lecture_math_003.git
# git branch -M main
# git push -u origin main


# http://localhost:3030/

Remove-Item -Recurse -Force node_modules\.vite -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force slides\dist -ErrorAction SilentlyContinue

# ビルド＆ローカルサーバー起動 (http://localhost:3030/main/ と /math03/)
# npm run serve

npx slidev
# npm ci --include=optional && npm run build:render
