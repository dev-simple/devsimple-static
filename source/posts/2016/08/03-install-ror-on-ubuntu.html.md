---

title: Установка Ruby on Rails на Ubuntu
date: 2016-08-03 00:00 UTC
author: artyom
tags: ruby, ruby on rails

---

В этой статье Вы узнаете, как установить язык программирования Ruby и один из наиболее популярных веб фреймворков Ruby on Rails в операционной системе Ubuntu.
Мы будем использовать простой, но мощный инструмент командной строки rbenv. С его помощью мы без труда сможем установить несколько версий языка Ruby и также просто переключаться между ними.
Весь процесс установки базируется на использовании командной строки. Поэтому открываем "Терминал" и начинаем!
(READMORE)

## Обновление системы и установка зависимостей
Первое, что необходимо сделать, обновить систему:

```console
$ sudo apt-get update
```

Далее необходимо установить дополнительные пакеты, которые необходимы для корректной работы rbenv и Ruby:

```console
$ sudo apt-get install autoconf bison build-essential libssl-dev \
libyaml-dev libreadline6-dev zlib1g-dev \
libncurses5-dev libffi-dev libgdbm3 libgdbm-dev git
```

Теперь, когда установлены все необходимые пакеты, приступим к установке rbenv.

## Установка rbenv
Код проекта расположен на [Github](https://github.com/rbenv/rbenv). Следующей командой, мы клонируем репозиторий в наш домашний каталог:

```console
$ git clone https://github.com/rbenv/rbenv.git ~/.rbenv
```

Теперь, когда мы скачали rbenv необходимо добавить в глобальную переменную `$PATH` путь к исполняемым файлам и добавить команду `rbenv init` для автоматического запуска rbenv:

```console
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' &gt;&gt; ~/.bashrc
$ echo 'eval "$(rbenv init -)"' &gt;&gt; ~/.bashrc
$ source ~/.bashrc
```

Чтобы устанавливать Ruby командой ruby install необходимо установить ruby-build. Делается это очень просто, клонируем репозиторий в папку ~/.rbenv/plugins/

```console
$ git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
```

## Установка Ruby
Подошло время к установке Ruby. Полный список доступных версий Ruby можно посмотреть с помощью следующей команды:

```console
$ rbenv install -l
```

Установим последнюю, доступную на данный момент версию 2.3.1, а также сделаем данную версию Ruby используемой по умолчанию с помощью команды global:

```console
$ rbenv install 2.3.1
$ rbenv global 2.3.1
```

И проверим, что по умолчанию используется Ruby версии 2.3.1, с помощью команды:

```console
$ ruby -v
```

## Настройка Gems
Gems это пакеты, которые подключают дополнительный функционал к Ruby. Большинство гемов сопровождаются с подробной документацией. Для того чтобы отключить загрузку документации используем команду:

```console
$ echo "gem: --no-document" &gt; ~/.gemrc
```

Установим первый гем, который называется bundler. Он используется для управления зависимостями приложения:

```console
$ gem install bundler
```

## Установка Rails
Для того чтобы установить Rails в командной строке необходимо выполнить следующую команду:

```console
$ gem install rails
$ rbenv rehash
```

Для работы Rails необходимо установить nodejs. Не будем вдаваться в подробности и последовательно выполним все команды, представленные ниже.

```console
$ cd /tmp
$ \curl -sSL https://deb.nodesource.com/setup_6.x -o nodejs.sh
$ cat /tmp/nodejs.sh | sudo -E bash -
$ sudo apt-get install -y nodejs
```

## Заключение
После того, как Вы прошли все шаги из этой инструкции, у Вас появится настроенное рабочее окружение, готовое для написания веб приложений с использованием популярного веб фреймворка Ruby on Rails.

Как создать своё веб приложение читайте в следующих статьях!
