Get-ScheduledJob | Unregister-ScheduledJob -Force #Powershell için kayıtlı olan tüm schedule job'ları siliyoruz.                                                            
Unregister-ScheduledJob -Name "*" -Force      
          
$trigger = New-JobTrigger -Once -At 13:45

Register-ScheduledJob -Name CPU_Getir -Trigger $trigger -ScriptBlock { #her gün 13:45 de çalışacak CPU_Getir isminde bir schedule job kayıt ediyoruz.

$a = Get-Process | Where-Object { $_.CPU -gt 10 } | Sort CPU -descending | Select -Property ProcessName,CPU |
format-table  #cpu nun %10 dan fazla kullandığı işlemlerin isimleri ve cpu kullanımlarını getiriyoruz. 

$logfilepath="C:\Users\samet\OneDrive\Masaüstü\işletim\Sonuç.txt" #Sonuçları yazdıracağımız dosya yolunu tanımladık.
if(Test-Path $logfilepath)
{
    Remove-Item $logfilepath #Eğer daha önceden eklenmiş bir sonuç varsa onu siliyoruz.
}
$a +" - "+ (Get-Date).ToString() >> $logfilepath } #Sonuçları txt dosyasına yazdırıp programın çalıştırıldığı anın saat ve tarihinide sonuçlara ekliyoruz. 

Start-Job -DefinitionName CPU_Getir #Kayıt ettiğimiz CPU_Getir schedule job'ı çalıştırıyoruz.