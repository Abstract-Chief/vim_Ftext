# Ftext
# Установка плагина
   vim plug -> Plug 'Abstract-Chief/vim_Ftext'
# Информация
  Данный плагин позволяет создавать паттерны для генерации новых файлов
  это значит что вы можете задать паттерн файла и каждый файл этого (типа или полного имени) будет создаватся в этом патерне
  паттерны предусматривают диннамические переменные такие как: 
- %name <filename_type>
- %pname <filename.type>
- %type <type>
- %user <username>
- %time <12:56>
- %date1 <Mon 01 Apr 2024 12:53:10 PM CEST>
- %date2 <2024-04-1>
- %date3 <Monday>
- %pos --set cursor on last %pos in file
# Пример использования 
  ![image](https://github.com/Abstract-Chief/vim_Ftext/assets/92479577/d5daea8d-b677-41f6-b825-32c7c8e83f99)

# Функции
  - call SetBaseText() --устанавливает паттерн для типов файлов например .c .py .cpp .h
  - call SetBaseTextFull() --устанавливает паттерн для конкретного имени файла например main.c 
