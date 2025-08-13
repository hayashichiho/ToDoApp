# ToDoアプリケーション

シンプルで使いやすいタスク管理アプリケーションです．
日々のタスクを効率的に管理し，生産性を向上させることができます．

---

## プロジェクト概要

このアプリは，ユーザーがタスクを作成・編集・削除・完了マークできるモバイル・デスクトップ対応のToDoアプリケーションです．
当日の天気予報も確認可能で，直感的なUIとスムーズな操作性を重視して設計されています．天気情報はOpenWeatherMapのAPIを利用して，実際の天気データを取得しています．

---

## 主な特徴

- **タスク管理**：タスクの追加，編集，削除機能
- **進捗管理**：完了・未完了の切り替え
- **期限設定**：タスクに期限を設定可能
- **天気確認**：当日の天気（OpenWeatherMap APIによる実データ取得）
- **テーマ変更**：テーマを4色から選択可能
- **クロスプラットフォーム**：iOS，Android，Web，デスクトップ対応

---

## 技術構成

### フロントエンド
- **Flutter 3.x**（クロスプラットフォーム開発）
- **Dart**（プログラミング言語）
- **Material Design**（UIデザイン）

### 状態管理
- **setState**（基本的な状態管理）

### データベース
- **SQLite**（ローカルストレージ）
- **sqflite**（Flutter SQLiteプラグイン）

### 基本機能
- **shared_preferences**（設定保存）
- **intl**（日時フォーマット・国際化）

### 天気機能
- **OpenWeatherMap API**（天気情報取得／APIキー必須）
- **httpパッケージ**（API通信）

---

## アプリ機能詳細

### 基本機能
1. **タスク作成**：タイトル，詳細，期限を設定
2. **タスク一覧**：全タスクをリスト表示
3. **タスク編集**：既存タスクの内容変更
4. **タスク削除**：不要なタスクの削除
5. **完了管理**：タスクの完了・未完了切り替え

### 追加機能
1. **天気表示**：指定地域（例：東京）の天気情報を表示（OpenWeatherMap API利用）
2. **テーマ切り替え**：4つのカラーテーマから選択

---

## ディレクトリ構成

```
ToDoApp/
├── lib/
│   ├── main.dart                 # アプリエントリーポイント
│   ├── models/
│   │   ├── todo.dart            # ToDoモデル
│   │   └── weather.dart         # 天気モデル
│   ├── screens/
│   │   ├── add_todo_screen.dart # タスク追加画面
│   │   └── list_screen.dart     # タスクリスト画面
│   ├── widgets/
│   │   ├── todo_item.dart       # タスクアイテム
│   │   └── weather.dart         # 天気ウィジェット（OpenWeatherMap API対応）
│   ├── services/
│   │   └── weather_service.dart # 天気API連携
│   └── utils/
│       ├── constants.dart       # 定数定義
│       └── themes.dart          # テーマ定義
├── assets/
│   ├── images/
│   │   ├── icons/              # アプリアイコン
│   │   └── weather/            # 天気アイコン
│   └── fonts/                  # カスタムフォント
├── test/
│   └── widget_test.dart        # ウィジェットテスト
├── android/
├── ios/
├── web/
├── macos/
├── windows/
├── linux/
├── pubspec.yaml
└── README.md
```

---

## セットアップ方法

### 必要な環境
- **Flutter SDK 3.x以上**
- **Dart SDK 3.x以上**
- **Android Studio** または **VS Code**
- **Git**
- **OpenWeatherMap APIキー**（[取得はこちら](https://openweathermap.org/api)）

### インストール手順

1. **リポジトリのクローン**
   ```bash
   git clone https://github.com/hayashi/ToDoApp.git
   cd ToDoApp
   ```

2. **依存関係のインストール**
   ```bash
   flutter pub get
   ```

3. **APIキーの設定**
   - プロジェクトルートに `.env` ファイルを作成し、下記のようにAPIキーを記載してください。
     ```
     API_KEY=あなたのOpenWeatherMapのAPIキー
     ```
   - `.env` ファイルはGit管理対象外です（`.gitignore`に追加済み）。

4. **デバイス確認**
   ```bash
   flutter devices
   ```

5. **アプリ実行**
   ```bash
   flutter run
   ```

### プラットフォーム別実行

```bash
# Android
flutter run -d android

# iOS (macOSのみ)
flutter run -d ios

# Web
flutter run -d chrome

# Windows (Windowsのみ)
flutter run -d windows

# macOS (macOSのみ)
flutter run -d macos

# Linux
flutter run -d linux
```

---

## 使用方法

- タスク追加：右下の「+」ボタンをタップ
- タスク完了：タスク左側のチェックボックスをタップ
- タスク編集：タスクをタップして編集画面へ
- タスク削除：ゴミ箱ボタンをタップ
- テーマ変更：設定画面から4つのテーマを選択
- 天気確認：ホーム画面上部で当日の天気（OpenWeatherMap APIによる実データ）を確認

---

## 注意事項

- 天気情報取得にはOpenWeatherMapのAPIキーが必要です．
- APIキーは無料で取得できますが，利用制限があります．
- インターネット接続が必要です．

---

## ライセンス

このプロジェクトは MIT ライセンスの下で公開されています．

---

## サポート

質問やバグ報告は [Issues](../../issues) でお知らせください．
