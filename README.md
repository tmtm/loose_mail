# LooseMail

[Mail](https://github.com/mikel/mail) ではちゃんと扱えないような日本固有のメールをテキトーに扱えるように Mail にモンキーパッチをあてます。

* charset が ISO-2022-JP なのに ISO-2022-JP に無い文字(① / ㈱ / ｱ(半角カナ)等)が使われててもそれなりになんとかします
* 文字の途中で分割されているような不正な MIME エンコーディングされた文字列をそれなりになんとかします
* ISO-2022-JP の MIME エンコーディングで表現された添付ファイル名をそれなりになんとかします

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'loose_mail'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install loose_mail

## Usage

```ruby
require 'loose_mail'
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
