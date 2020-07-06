# F-FORM
F-FORMとはサイトにフォームを`簡単`に設置することを実現するアプリです。

フォームのHTMLを貼ることによってフォーム内容をメールで転送します。
HTMLとCSSをカスタマイズして独自のフォームを作ることが可能です。

[デモサイト](http://stage-form-maker.herokuapp.com/)

※デモのため、本格的に使用する場合は自身のサーバーに設置してお使いください。sendgridを使っているため、上限に達するとメールが届かない恐れがあります。
## Environment
- Ruby 2.7.1
- Rails 6.0.3.2
- Postgresql 11+

## INSTALL
`bin/setup`

`bin/foreman`
## TEST
`bundle exec rspec`
## LINT
`rubocop -a`
## SETUP
### reCAPTCHA
reCAPTCHAを使う場合は、公式サイトより`v2`のrepcatchs_site_keyとrecaptcha_seceret_keyを取得して、環境変数にいれてください。
その際に`reCAPTCHA ソリューションの入手元を検証する`をオフにしてください。
.env.sampleを参考に環境変数の設定をお願いします。
なお、開発にはDirenvを使ってます。

[reCAPTCHA](https://developers.google.com/recaptcha/)
```
export RECAPTCHA_SECRET_KEY=
export RECAPTCHA_SITE_KEY=
```

