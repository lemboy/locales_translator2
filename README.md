Locales Translator (bis)
===================

Translator for RoR locale YML files with machine translation ability (Yandex API).
This is a "re-do" of the first [Locales-translator](https://github.com/lemboy/locales_translator)


Setup
-------

Create file *config/application.yml* and add into it translate API Key 
```ruby
  YANDEX_API_KEY: _your-api-key_
```

Translate API note
-------

Free version Yandex.Translate API, currently used in this app, has some limitations:
> the volume of the text translated: 1,000,000 characters per day but not more than 10,000,000 per month.

Full [Terms of Use](http://legal.yandex.com/translate_api/?ncrnd=2118).

Testing
-------

Run
```
bundle exec rspec spec
```
Most likely you will need to adjust the Selenium::WebDriver before. See at the end of *spec/rails_helper.rb* 

Demo
-------

Demo app is [here](http://locales-translator.herokuapp.com/)

Thanks
-------

In app used "Bootstrap-styled tree widget" from [here](http://jsfiddle.net/umutc1/eyf9q87c/)
