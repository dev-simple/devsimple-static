---

title: 'Эпизод #3 - Hound'
date: 2017-12-12 18:54 UTC
tags: ruby, gems, clean code
author: artyom
category: episodes
video: https://www.youtube.com/embed/WG4V0PUN0RU

---

В этом эпизоде рассмотрим HoundCI, инструмент для автоматического анализа кода в Pull Request’ах, который работает в связке с GitHub.
(READMORE)
Hound может проанализировать несколько типов кода. Для каждого типа он использует свою технологию:

  1. Ruby - [Rubocop](https://github.com/bbatsov/rubocop)
  2. CoffeeScript - [CoffeeLint](http://www.coffeelint.org/)
  3. JavaScript - [JSHint](https://github.com/jshint/jshint)
  4. SCSS - [SCSS-Lint](https://github.com/causes/scss-lint)
  5. SASS - [SASS-Lint](https://github.com/sasstools/sass-lint)
  6. Haml - [Haml-Lint](https://github.com/brigade/haml-lint)
  7. Go - [Golint](https://github.com/golang/lint)
  8. Swift - [SwiftLint](https://github.com/realm/SwiftLint)
  9. ESLint - [ESLint](http://eslint.org/)
  10. Python - [Flake8](http://flake8.readthedocs.org/en/latest/)
  11. TypeScript - [TSLint](https://palantir.github.io/tslint/)
  12. Elixir - [Credo](http://credo-ci.org/)

Подробнее можно посмотреть в [оф.документации](https://houndci.com/configuration)

## Как это работает
1. Вы пишите код
2. Делает Pull Request
3. Hound проверяет ваш код и комментирует все проблемные места от имени пользователя houndci
4. Вы исправляете замечания
5. Делаете merge с master

## Подключаем Hound к проекту
Первое, что необходимо сделать, это выполнить [Вход](https://houndci.com/) используя свой GitHub аккаунт.
После этого вы увидите список всех Ваших репозиториев.
Для того, чтобы активировать Hound, нужно в строке с нужным репозиторием нажать на кнопку `Activate`.

![Hound Activate](posts/2017/12/hound_activate.png "Hound Activate repository")

После этого Hound будет делать Code Review для каждого Pull Request’а в вашем проекте.

## Конфигурация
Мы можем подключить или отключить любой из линтеров.
Разместите в корне Вашего проекта файл `.hound.yml` и, к примеру мы хотим отключить SCSS, напишем следующее:

```yml
scss:
  enabled: false
```

Это строка отключит слежку за файлами `*.scss`.

Мы также можем подключить свой файл конфигурации для каждого линтера.
Для Ruby это может выглядеть так:

```yml
ruby:
  config_file: .rubocop.yml
```

Также можно исключить некоторые файлы из проверки:

```yml
scss:
  exclude:
    - "app/assets/stylesheets/plugins/**"
```

Hound очень удобен и прост в использовании. Он поможет Вам сохранить массу времени для поддержания чистого кода.

### Ссылки

  * **Hound:** https://houndci.com/
  * **Оф. документация:** https://houndci.com/configuration
  * **Проект, используемый в видео:** https://github.com/dev-simple/create_blog_on_rails

