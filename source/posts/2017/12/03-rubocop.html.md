---

title: 'Эпизод #2 - Rubocop'
date: 2017-12-03 20:33 UTC
tags: ruby, gems, clean code
author: artyom
category: episodes

---
В этом эпизоде поговорим о стиле программирования.
Если вы работаете в команде, коммитите в Open Source проекты или просто хотите чтобы ваш код был чище и читабельнее, то этот урок будет для вас полезен. (READMORE)

Ruby очень гибкий язык, который дает нам возможность писать идентичный по функциональности код разными способами.
Вы наверняка хоть раз задумывались о том, где делать отступы, использовать для блока конструкцию `do … end` или же использовать `{ ... }`, использовать `def` с круглыми скобками, если у метода есть переменные или нет…

Ruby сообщество уже давно сформировало свод правил, которые соблюдают большинство программистов при написании кода. Эти правила с подробными описаниями и примерами можно посмотреть в репозиториях:

  1. Ruby - https://github.com/arbox/ruby-style-guide/blob/master/README-ruRU.md
  2. Rails - https://github.com/arbox/rails-style-guide/blob/master/README-ruRU.md#activerecord

  Например в Ruby-style-guide вы можете увидеть, что необходимо использовать 2 пробела в качестве уровня отступа и не использовать табуляцию.

Для более удобного восприятия больших чисел необходимо использовать нижнее подчеркивание `_`

```ruby
# плохо (Сколько тут нолей?)
num = 1000000

# хорошо (число воспринимается гораздо легче)
num = 1_000_000
```

Для того, чтобы придерживаться этому своду правил существует статический анализатор кода Rubocop.

## Rubocop
Для того, чтобы проанализировать ваш код, [Rubocop](https://github.com/bbatsov/rubocop) использует так называемые cop'ы.
Существует несколько категорий cop'ов:

  1. **Style** - анализирует стиль кода (форматирование)
    * **Style/TrailingWhitespace** - не использовать пробел в конце строки
    * **Style/UnlessElse** - не использовать Unlses вместе с Else, т.к. Это затрудняет чтение вашего кода
    * **Style/StringLiterals** - использование двойной или одинарных кавычек

  2. **Layout** - анализирует использование отступов, выравнивание
    * **ayout/AlignArray** - выравние элементов в массиве, который имеет Болле одной строки
    * **ayout/AlignHash** - выравние элементов в хэше, который имеет Болле одной строки

  3. **Lint** - анализирует синтаксис и плохие практики
    * **Lint/AssignmentInCondition** - присвоение значения переменной в условии
    * **Lint/DuplicateMethods** - проверяет наличие повторяющихся методов

  4. **Metrics** - различные метрики кода
    * **Metrics/LineLength** - следит за длиной строки
    * **Metrics/MethodLength** - следит за числом строк в методе

  5. **Naming** - следит за ошибками в наименовании, таких как наименование метода, констант и т.д.
    * **Naming/AccessorMethodName** - следит за тем, чтобы вы не использовали в наименовании методов `get` и `set` префиксы
    * **Naming/AsciiIdentifiers** - следит за тем, чтобы в наименовании не использовались non-ascii символы

  6. **Performance** - следит за тем, чтобы использовались более быстрые семантически эквивалентные методы.
    * **Performance/Detect** - использовать `detect` вместо констуркции `select.first`
    * **Performance/FlatMap** - использовать `flat_map` вместо конструкции `map.flatten`

  7. **Security** - следит за потенциально не безопасными методами и конструкциями
  8. **Rails** - специфичный для Ruby on Rails проектов
    * **Rails/ApplicationRecord** - следит за тем, чтобы модель наслаивалась от `ApplicationRecord` вместо `ActiveRecord::Base`
    * **Rails/DynamicFindBy** - следит за динамическими методами `find_by_*`, рекомендуя использовать `find_by`

  9. **Bundler** - следит за стилями и хорошими практиками в `Gemfile`
    * **Bundler/DuplicatedGem** - следит за дупликатами в `Gemfile`
    * **Bundler/OrderedGems** - следит за тем, чтобы gem'ы объявлялись в отсортированном порядке

  10. **Gemspec** - следит за стилями и хорошими практиками в `gemspec` файлах

Подробнее можно почитать в [официальной документации](http://rubocop.readthedocs.io/en/latest/).

## Практика

Установим rubocop
```console
gem install rubocop
```

Для примера используем код из курса «Создание блога Rails». Перейдем в папку проекта и запустим rubocop c флагом `-D` для отображения cop'а, который вызвал нарушение

```console
cd blog
rubocop -D
…
db/migrate/20170212144127_devise_create_users.rb:33:1: C: Layout/EmptyLines: Extra blank line detected.

75 files inspected, 236 offenses detected
```

Мы видим, что rubocop проанализировал проект и нашел 236 нарушений в 75 файлах. Так же в каждой строке можно увидеть какой именно cop обнаружил нарушение. В нашем примере последнее нарушение найдено cop'ом `Layout/EmptyLines`. Он говорит нам, что в 33 строке одной из миграций есть пустая строка.
Можно вывести  все нарушения связанные с этим cop'ом

```console
rubocop -D --only Layout/EmptyLines

Inspecting 75 files
..C.......................................................................C

Offenses:

Gemfile:3:1: C: Layout/EmptyLines: Extra blank line detected.
db/migrate/20170212144127_devise_create_users.rb:33:1: C: Layout/EmptyLines: Extra blank line detected.

75 files inspected, 2 offenses detected
```

Мы видим, что подобная ошибка встречается дважды в миграции и `Gemfile`.
Для исправления нарушения, мы можем вручную зайти в эти файлы и удалить пустую строку.

Для удобства Rubocop поддерживает режим автокоррекции. Для этого достаточно запустить rubocop c флагом `-a`. Если скомбинировать с флагом `--only` и указать конкретный cop, то будут исправлены только присущие данному cop'у нарушения.

```console
rubocop -D -a --only Layout/EmptyLines

Inspecting 75 files
..C.......................................................................C

Offenses:

Gemfile:3:1: C: [Corrected] Layout/EmptyLines: Extra blank line detected.
db/migrate/20170212144127_devise_create_users.rb:33:1: C: [Corrected] Layout/EmptyLines: Extra blank line detected.

75 files inspected, 2 offenses detected, 2 offenses corrected
```

Мы видим, что нарушения были исправлены. При повторном запуске rubocop, данных нарушений уже не будет

```console
rubocop -D --only Layout/EmptyLines

Inspecting 75 files
...........................................................................

75 files inspected, no offenses detected
```

Автокоррекция надежный помощник, но бывают случаи когда не возможно автоматически скорректировать ваш код. Ярким примером может послужить cop `Metrics/LineLength`, который следит за длинной строки.

```console
rubocop -D -a --only Metrics/LineLength
```

Запустив такой cop в режиме автокорреции мы увидим, что эти нарушения не были изменены, что логично, ведь он не знает как правильно перенести код на разные строки. В таких случаях вам придется вручную исправить эти нарушения.

## Конфигурация Rubocop

По умолчанию Rubocop следит за всеми нарушениями, но вы можете изменить его поведение, добавив правила в файл `.rubocop.yml`.

Этот файл может размещаться в вашей домашней директории и тогда эти настройки будут применяться для всех ваших проектов, а также можете разместить его в корне вашего проекта.

В этом файле можно отключить любой cop или исключить отслеживаемые файлы.
К примеру мы хотим исключить файл `config/initializers/devise.rb`,  все файлы в папке `db` и увеличить длину строки до 120 символов. Для этого в файле `.rubocop.yml` напишем следующее

```yml
AllCops:
  Exclude:
    - 'config/initializers/devise.rb'
    - 'db/**/*'
Metrics/LineLength:
  Max: 120
```

Приведу другой пример. Теперь мы хотим отключить cop который отвечает за документацию класса `Style/Documentation`. Для этого в нашем конфиг-файле добавим следующую строку:

```yml
Style/Documentation:
  Enabled: false
```

При запуске команды `rubocop -D` мы больше не увидим нарушений этого типа. Но если ввести команду `rubocop -D --only Style/Documentation`, то нарушения снова отобразятся.

Чтобы каждый раз не вводить флаг `-D` для отображение имени cop'a нам может пригодится настройка `DisplayCopNames: true` в секции `AllCops`

```yml
AllCops:
  DisplayCopNames: true
  Exclude:
    - 'config/initializers/devise.rb'
    - 'db/**/*'

Metrics/LineLength:
  Max: 120

Style/Documentation:
  Enabled: false
```

## Git Хук

Велика вероятность того, что вы можете забыть проверить ваш код перед коммитом в репозиторий. Чтобы исключить вероятность человеческого фактора воспользуемся pre-commit хуком для git.

В каждом проекте, в котором был инициализирован git репозиторий есть папка `.git/hooks`. Создайте файл `pre-commit` и скопируйте в него содержимое из файла по ссылке https://gist.github.com/arty88/95ab0189d42d05da92f74fdee6d38abf

Для работы данного хука, ему нужно добавить право доступа на исполнение

```console
chmod +x .git/hooks/pre-commit
```

Данный хук отслеживает все измененные в коммите файлы и «натравливает» на них rubocop. Если были найдены какие-либо нарушения, то rubocop предложит вам их исправить перед коммитом.

Для отмены коммита достаточно нажать клавишу `n`. Но если вы не хотите  исправлять нарушения, достаточно нажать любую другую клавишу и тогда новый коммит будет создан.

Для примера внесем изменения в файл `app/controllers/admin/posts_controller.rb`, сохраним его и сделаем коммит.

```console
git add app/controllers/admin/posts_controller.rb
git commit -m ‘Test commit’
Inspecting 1 file
C

Offenses:

app/controllers/admin/posts_controller.rb:1:1: C: Style/FrozenStringLiteralComment: Missing magic comment # frozen_string_literal: true.
class Admin::PostsController < Admin::AdminController
^
app/controllers/admin/posts_controller.rb:1:7: C: Style/ClassAndModuleChildren: Use nested module/class definitions instead of compact style.
class Admin::PostsController < Admin::AdminController
      ^^^^^^^^^^^^^^^^^^^^^^
app/controllers/admin/posts_controller.rb:2:34: C: Style/SymbolArray: Use %i or %I for an array of symbols.
  before_action :set_post, only: [:edit, :update, :destroy]
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^
app/controllers/admin/posts_controller.rb:18:3: C: Style/EmptyMethod: Put empty method definitions on a single line.
  def edit ...
  ^^^^^^^^

1 file inspected, 4 offenses detected
Would you like to continue press 'any key' or 'n/N' to halt?
```

Мы видим все нарушения, который нашел rubocop. Если мы хотим их исправить, то просто вводим `n` и нажимаем `Enter`.

### Ссылки:

  * **Ruby Style Guide:** https://github.com/arbox/ruby-style-guide/blob/master/README-ruRU.md
  * **Rails Style Guide:** https://github.com/arbox/rails-style-guide/blob/master/README-ruRU.md#activerecord
  * **Rubocop:** https://github.com/bbatsov/rubocop
  * **Rubocop оф. документация:** http://rubocop.readthedocs.io/en/latest/
  * **Git Hook:** https://gist.github.com/arty88/95ab0189d42d05da92f74fdee6d38abf

