Скрипт посика в "шарах" отделов:
	1) По и исполняемые файлы типа:
	'.exe','.com','.application','.msi','.msp','.gadget'
         ,'.scr','.hta','.msc','.cpl','.jar','.jpg','.jpeg'
         ,'.bat','.cmd','.vbe','.vb','.vbs','.msh1xml', '.msh2xml'
         ,'.mshxml', '.msh1','.msh2','.msh','.psc1','.psc2','.ps1'
         '.ps1xml','.ps2xml','.wsh','.wsc','.wsf','.ws','.jse','.js'
	2) Текстовые файлы типа:
	'.txt','.doc','.text','.doc','.docx','.xlsx','.xls'

По пункту 2. Реализовывается поиск через регулярные выражения по словам:
	'Пароль','ПАРОЛЬ','пароль','pass',
	'password','Password','PASSWORD',
        'пасс','ПАСС','Пасс'
        'логин','login','Login','LOGIN','личный кабинет'

Знаю, что есть игнорирование по кейсам, скрипт в стадии разработки.

Скрипт формирует *.cvs файлы с указанием путей до файлов

Не исполнено:
1) Поиск по xlsx и xls форматам
2) Поиск по doc и docx

Запуск скрипта .\Findyoursecret.ps1 -Path <каталог>

Где в <каталог> принимаются и сетевые пути.
