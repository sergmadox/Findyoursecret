param (
    [string]$Path
)
#Поиск расширений
function extention($Path){

    $result_extension = @()

    $files = gci -Recurse $Path

    $extension = ('.ps1','.exe','.com','.application','.msi','.msp','.gadget'`
              ,'.scr','.hta','.msc','.cpl','.jar','.jpg','.jpeg'`
              ,'.bat','.cmd','.vbe','.vb','.vbs','.msh1xml', '.msh2xml'`
              , '.mshxml', '.msh1','.msh2','.msh','.psc1','.psc2','.ps1',`
              '.ps1xml','.ps2xml','.wsh','.wsc','.wsf','.ws','.jse','.js')
    
    $text_extension = ('.txt','.doc','.text','.doc','.docx','.xlsx','.xls')
    
    
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
        $text = 'result.csv'
    $result_extension >   $text
    }




#Поиск слов по фильтрам

function filtered($Path){
       
       $result_filtered = @()
       $finding_word = @()
       $files  = gci -Recurse $Path

       $extension = ('.txt','.doc','.text','.doc','.docx','.xlsx','.xls')
     
       $c2 = 0 
       foreach ($file in $files){
       $c2++
       for ($i = 0;$i -lt $extension.Length; $i++){
               Write-Progress -Id 1 -Activity 'Ищем текстовые форматы' -Status "Завершено $($c2) из $($files.count)" -CurrentOperation $file -PercentComplete (($c2/$files.Count) * 100)
               if ($extension[$i] -eq $file.Extension){
                   $result_filtered+= $file.FullName 
       }
       }
       }
       $result_filtered > result_extention.csv
        
       $filter = ('Пароль','ПАРОЛЬ','пароль','pass',`
                  'password','Password','PASSWORD',`
                  'пасс','ПАСС','Пасс'`
                  ,'логин','Логин','ЛОГИН','login','Login','LOGIN','личный кабинет')
       
       $regex = '(?:^|\W)*?'

       $regex_end = '(?:$|\W)*?'
       $c3 = 0
       foreach ($fil in $filter){
            $c3++
            for ($i = 0;$i -lt $result_filtered.Length; $i++){
                
                Write-Progress -id 2 -Activity "Фильтруем" -status "Поиск фразы $($fil). Завершено $($c3) из $($filter.count) " `
               -percentComplete (($c3/$filter.count)*100)
                
                #$read = Get-Content $result_filtered[$i]
                
                if ($result_filtered[$i] -like '*.txt'){

                    searchtxt($result_filtered[$i],$fil)
                   
                    $finding_word += $result_filtered[$i]
                    }
                }
                }
       $finding_word > finding.csv             
       }   


       
function searchtxt(){

    foreach ($text in (Get-Content $result_filtered[$i])) {
 
       $regex = '(?:^|\W)*?'
       $regex_end = '(?:$|\W)*?'
     
       if ($text -cmatch $regex+$filter_word+$regex_end -eq $true){
                return $result_filtered[$i]
                }
                }
                }
                    
        

 extention($Path)
 
 filtered($Path)      