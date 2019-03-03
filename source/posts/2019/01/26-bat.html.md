---

title: BAT - улучшенный CAT с подсветкой синтаксиса
date: 2019-01-26 05:24 UTC
tags: tools

---

В UNIX подобных системах `cat` используется для последовательного считывания и вывода содержимого файлов в стандартный вывод.
В этой статье мы разберем похожую утилиту, являющуюся клоном `cat`, но с дополнительными улчшениями, такими как подсветка синтаксиса и интеграция с [GIT][1].

(READMORE)

![Bat and Cat comparison][bat-cat-comparison]

## Установка

### Ubuntu

Скачайте последнюю версию `.deb` пакета [отсюда][3] и выполните команду:

```sh
# замените имя пакета, на скаченный вами
sudo dpkg -i bat_0.9.0_amd64.deb
```

### MacOS

Установите `bat` с помощью пакетного менеджера [Homebrew][4]:

```sh
brew install bat
```

### Arch Linux

Установите пакет `bat` из официального репозитория:

```sh
pacman -S bat
```

### Другие системы

Если в списке выше вы не нашли своей операционной системы, то загляните в [репозитрий][5].


## Использование

Чтобы посмотреть содержимое файла, нужно выполнить команду:

```sh
bat file01.md
```

Вы также можете посмотреть содержимое сразу нескольких файлов:

```sh
bat file01.md file02.md
```

Или соединить несколько файлов в один:

```sh
bat file01.md file02.md > multifile.md
```

Перейдем к основным преимуществам `bat`.


<br>
### Интеграция с Git
Если внести изменения в файл, который находится под контролем системы управления версиями [Git][1], то в колонке слева будут отображаться изменения.
![Bat Git integration][bat-git-integration]

<br>
### Подсветка синтаксиса

`bat` поддерживает подсветку синтаксиса для большого кол-ва языков разметки и программирования.

```sh
bat posts_controller.rb
```

С полным списком можно познакомиться, написав команду:

```sh
bat --list-languages
```
![bat-list-languages][bat-list-languages]


## Конфигурация
Если вам не нравится тема по умолчанию, вы можете её поменять. Для того чтобы посмотреть список всех доступных команд запустите команду:

```sh
bat --list-themes
```

![bat-list-themes][bat-list-themes]

Для использования темы, для примера возьмем `Monokai Extended Origin`, запустите:

```sh
bat --theme="Monokai Extended Origin" posts_controller.rb
```

![bat-custom-theme][bat-custom-theme]

Для того, чтобы изменить тему по умолчанию, можно присвоить переменной окружения `BAT_THEME` понравившуюся тему:

```sh
export BAT_THEME="TwoDark"
```

### Добавление новой темы

Первое, что нужно сделать, это создать папку, где мы будем хранить новые темы:

```sh
mkdir -p "$(bat --config-dir)/themes"
cd "$(bat --config-dir)/themes"
```

Теперь ищем тему с расширением `*.tmTheme`, например по этой [ссылке][6], скачиваем, копируем в только что созданную папку и обновляем кэш:

```sh
# Перемещаем скачанную тему Railscasts.tmTheme
mv ~/Downloads/Railscasts.tmTheme .

# Обновляем кэш
bat cache --build
```

После этого новая тему будет доступна для выбора.
![bat-railscasts-theme][bat-railscasts-theme]

### Файл конфигурации

Есть еще один вариант изменения настроек по умолчанию, использовать файл настроек. Для этого нужно создать файл `bat.conf` и через переменную окружения
`BAT_CONFIG_PATH` указать путь к этому файлу:

```sh
export BAT_CONFIG_PATH="/path/to/bat.conf"
```

Пример такого файла:

```sh
# Установить тему по умолчанию "TwoDark"
--theme="TwoDark"

# Показать номера строк, изменения Git и отобразить имя файла
--style="numbers,changes,header"
```

<br>
На этом все. Надеюсь, что этот пост был вам полезен.

[1]: https://git-scm.com/
[2]: https://github.com/sharkdp/bat
[3]: https://github.com/sharkdp/bat/releases
[4]: https://docs.brew.sh/Installation
[5]: https://github.com/sharkdp/bat#installation
[6]: https://github.com/filmgirl/TextMate-Themes

[bat-cat-comparison]: posts/2019/01/bat-cat-comparison.png
[bat-git-integration]: posts/2019/01/bat-git-integration.png
[bat-list-languages]: posts/2019/01/bat-list-languages.png
[bat-list-themes]: posts/2019/01/bat-list-themes.png
[bat-custom-theme]: posts/2019/01/bat-custom-theme.png
[bat-railscasts-theme]: posts/2019/01/bat-railscasts-theme.png
