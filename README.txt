Скрипт посика в "шарах" отделов:
	1) По и исполняемые файлы типа:
	'.ps1','.exe','.com','.application','.msi','.msp','.gadget'
         ,'.scr','.hta','.msc','.cpl','.jar','.jpg','.jpeg'
         ,'.bat','.cmd','.vbe','.vb','.vbs','.msh1xml', '.msh2xml'
         ,'.mshxml', '.msh1','.msh2','.msh','.psc1','.psc2','.ps1'
         '.ps1xml','.ps2xml','.wsh','.wsc','.wsf','.ws','.jse','.js'
	2) Текстовые файлы типа:
	'.txt','.doc','.text','.doc','.docx','.xlsx','.xls'

Скрипт формирует *.cvs файлы с указанием путей до файлов

Не исполнено:
1) Поиск по фильтру в текстовых файлах

Запуск скрипта .\Findyoursecret.ps1 -Path <каталог>

Где в <каталог> принимаются и сетевой путь.