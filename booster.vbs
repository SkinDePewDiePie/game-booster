If WScript.Arguments < 1 Then
    WScript.Quit
Elif WScript.Arguments > 1 Then
    WScript.Quit
End

CreateObject("Wscript.Shell").Run CreateObject("Wscript.Shell").CurrentDirectory & "\app\booster.bat " & WScript.Arguments(0) & " " & chr(34) & WScript.Arguments(1) & chr(34), 0, false
