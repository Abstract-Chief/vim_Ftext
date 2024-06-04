#Ftext
# Install the plugin
   vim plug -> Plug 'Abstract-Chief/vim_Ftext'
# Information
  This plugin allows you to create patterns for generating new files
  this means that you can set a file pattern and each file of this type (or full name) will be created in this pattern
  patterns provide dynamic variables such as: 
- %name <filename_type>
- %pname <filename.type>
- %type <type>
- %user <username>
- %time <12:56>
- %date1 <Mon 01 Apr 2024 12:53:10 PM CEST>
- %date2 <2024-04-1>
- %date3 <Monday>
- %pos --set cursor on last %pos in file
# Usage example 
  ![image](https://github.com/Abstract-Chief/vim_Ftext/assets/92479577/d5daea8d-b677-41f6-b825-32c7c8e83f99)

# Functions
  - call SetBaseText() --sets the pattern for file types for example .c .py .cpp .h
  - call SetBaseTextFull() --sets the pattern for a specific file name, for example main.c
