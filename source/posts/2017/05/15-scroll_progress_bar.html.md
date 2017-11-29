---

title: Индикатор прокрутки страницы
date: 2017-05-15 00:00 UTC
tags: javascript, ui
author: artyom

---

В этой статье поговорим о том, как сделать Ваш сайт немного дружелюбнее с помощью индикатора прокрутки страницы.
Немного "погуглив" можно найти множество вариантов реализации этой задачи. Мы разберем 2 из них.
(READMORE)

1. PrognRoll (https://mburakerman.github.io/prognroll/)
Очень простой и легковесный скрипт, в сжатом виде весит всего 966 байт. Единственный минус этого скрипта заключается в том, что для его работы необходимо дополнительно подключить библиотеку jQuery. Впрочем jQuery очень широко используется и решать, является ли эта зависимость минусом или плюсом, вам.

Приступим к подключению скрипта. Первое, что необходимо сделать, подготовить необходимые файлы.

  * Скачать скрипт с официальной страницы (https://mburakerman.github.io/prognroll/) или из репозитория (https://github.com/mburakerman/prognroll)
  * Скачать библиотеку jQuery (http://jquery.com/)
  * Создать JS-файл для размещения кода инициализации и настройки скрипта. Назовем его scroll.js.

Подключаем файлы к странице

```html
<script src="jquery.js"></script>
<script src="prognroll.min.js"></script>
<script src="scroll.js"></script>
```

В файле scroll.js размещаем код для инициализации скрипта

```javascript
$(function() {
  $("body").prognroll();
});
```

Теперь при прокрутке страницы отображается индикатор.
![Progn Roll Screen 01](posts/2017/05/progn_roll_screen_01.png "Progress bar with PrognRoll")

Мы также можем изменить несколько параметров, которые необходимо передать в функцию prognroll

```javascript
$(function() {
  $("body").prognroll({
    height:5,         //Высота индикатора
    color:"#50bcb6",  //Цвет индикатора
    custom:false      //Если переключить в true, то можно подключить скрипт к любому div элементу
  });
});
```

Параметры height и color вполне понятны и не требуют объяснения. Параметру custom нужно указать значение true в том случае, если вы хотите добавить индикатор к какому-нибудь блочному элементу, например к div.
Поиграть с параметрами можно по ссылке http://codepen.io/anon/pen/GjzArK

2. youAreHere.js (http://nicolasjengler.github.io/youAreHere.js/demo/)
Этот скрипт написан на чистом JS и не требует никаких дополнительных библиотек. Его размер 1009 байт.
Подготовим необходимые файлы:

  ** Скачать скрипт из  репозитория (https://github.com/NicolasJEngler/youAreHere.js)
  ** Как и в предыдущем примере, создать JS-файл для размещения кода инициализации и настройки скрипта. Назовем его scroll.js.

Подключаем скрипты к странице

```html
<script src="js/youarehere.min.js"></script>
<script src="scroll.js"></script>
```

Вот так будет выглядеть индикатор с настройками по умолчанию
![You are here screen 01](posts/2017/05/you_are_here_screen_01.png "Default progress bar with YouAreHere")

Немного изменим отображение индикатора добавив в файл scroll.js следующий код
![You are here screen 02](posts/2017/05/you_are_here_screen_02.png "Custom progress bar with YouAreHere")

```javascript
youAreHere({
  height: '5px', // Высота индикатора (возможны значения в px, % и rem)
  color: '#ff0000',// Возможны значения в форматах HEX, RGB и RGBA
  easing: true // Если значение выставлено в true тогда будет изменена анимация у индикатора
});
```

На этом все. Спасибо за внимание.

