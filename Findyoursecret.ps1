param (
    [string]$Path
)

#Поиск расширений

function extention($Path){

    $result_extension = @()

    $files = gci -Recurse $Path

    $extension = ('.exe','.com','.application','.msi','.msp','.gadget'`
                  ,'.scr','.hta','.msc','.cpl','.jar','.jpg','.jpeg'`
                  ,'.bat','.cmd','.vbe','.vb','.vbs','.msh1xml', '.msh2xml'`
                  , '.mshxml', '.msh1','.msh2','.msh','.psc1','.psc2','.ps1',`
                  '.ps1xml','.ps2xml','.wsh','.wsc','.wsf','.ws','.jse','.js')  
    
    $c1 = 0
    
    foreach ($file in $files){
    
    $c1++
    
    Write-Progress -Id 0 -Activity 'Ищем исполняемые файлы' -Status "Завершено $($c1) из $($files.count)" -CurrentOperation $file -PercentComplete (($c1/$files.Count) * 100)
       
        for ($i = 0;$i -lt $extension.Length; $i++){
        
                if ($extension[$i] -eq $file.Extension){
              
                    $result_extension+= $file.FullName 
        }
        }
        }
        $text = 'Исполняемые файлы.csv'

    $result_extension >   $text
    }

#Поиск медиа и литературы по расширениям

Function bookin($Path){
    $result_extension = @()

    $files = gci -Recurse $Path

    $extension = ('.epub','.pdf','.mobi','.avi','.mvk','.mp3','wav','.ogg') 
    
    $c1 = 0
    
    foreach ($file in $files){
    
    $c1++
    
    Write-Progress -Id 1 -Activity 'Ищем медиа' -Status "Завершено $($c1) из $($files.count)" -CurrentOperation $file -PercentComplete (($c1/$files.Count) * 100)
       
        for ($i = 0;$i -lt $extension.Length; $i++){
        
                if ($extension[$i] -eq $file.Extension){
              
                    $result_extension+= $file.FullName 
        }
        }
        }
        $text = 'Книги, видео, музыка.csv'

    $result_extension >   $text
    }


#Поиск слов по фильтрам

function filtered($Path){
       
       $result_filtered = @()
       
       $finding_word = @()
       
       $files  = gci -Recurse $Path

       $extension = ('.txt','.text','.doc','.docx','.xlsx','.xls')
     
       $c2 = 0 
       
       foreach ($file in $files){
       
       $c2++
       
       for ($i = 0;$i -lt $extension.Length; $i++){
           Write-Progress -Id 2 -Activity 'Ищем текстовые форматы' -Status "Завершено $($c2) из $($files.count)"`
           -CurrentOperation $file -PercentComplete (($c2/$files.Count) * 100)

           if ($extension[$i] -eq $file.Extension){
                   
                   $result_filtered+= $file.FullName 
                         }
                         }
                         }
       #$result_filtered > result_extention.csv
        
       $filter = ('пароль','pass','password','пасс','логин','login','личный кабинет')
       
       $regex = '(?:^|\W)*?(?i)'

       $regex_end = '(?:$|\W)*?'
       
       $c3 = 0
       
       foreach ($fil in $filter){
            
            $c3++
            
            for ($i = 0;$i -lt $result_filtered.Length; $i++){
                
                Write-Progress -id 3 -Activity "Фильтруем" -status "Поиск фразы $($fil). Завершено $($c3) из $($filter.count) " `
               -percentComplete (($c3/$filter.count)*100)
                
                #$read = Get-Content $result_filtered[$i]
                
                if ($result_filtered[$i] -like '*.txt' -or $result_filtered[$i] -like '*.text'){

                    $finding_word += searchtxt($result_filtered[$i],$fil)
                    
                    }
                if (($result_filtered[$i] -like '*.xlsx' -or $result_filtered[$i] -like '*.xls')){
                    
                    $finding_word += searchxls($result_filtered[$i],$fil)
                    
                    }
                if (($result_filtered[$i] -like '*.docx' -or $result_filtered[$i] -like '*.doc')){
                    
                   $finding_word += searchdoc($result_filtered[$i],$fil)
                    
                    }
                }
                }
       $finding_word > 'Файлы с паролями.csv'             
       }   


#Поиск в txt файлах
       
function searchtxt(){

    foreach ($text in (Get-Content $result_filtered[$i])) {
 
       $regex = '(?:^|\W)*?'
       
       $regex_end = '(?:$|\W)*?'
  
       $a = $text -match $regex+$fil+$regex_end 
       
       if ($a -eq $true){
                
                return $result_filtered[$i]
                }
                }
                }
                    
#Поиск в xml(xmlx) файлах 
 
function searchxls(){

    $Excel = New-Object -ComObject Excel.Application
    
    $Workbook = $Excel.Workbooks.Open($result_filtered[$i])
    
    If($Workbook.Sheets.Item(1).Range("A:Z").Find($fil)){
    
        $Workbook.Close($false)
        
        $Excel.quit()    
        
        return $result_filtered[$i]
    
        break
    
    }
    
    $workbook.close($false)

    $Excel.quit()
        
    }

# Поиск в doc(docx) файлах

function searchdoc(){

    $Word = New-Object -ComObject Word.Application

    $Word.visible = $false
       
    $document = $Word.documents.open($result_filtered[$i])

    $range = $document.content

    $wordFound = $range.find.execute($fil)

    if ($wordFound) {

        $document.close()

        $Word.quit()

        return $result_filtered[$i]

        break
    }

    $document.close()
    
    $Word.quit() 
    
    }              

 extention($Path)

 bookin($Path)
 
 filtered($Path)   