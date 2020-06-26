**Installing part**

                                        
- 1: Download the ZIP by clicking Clone and Download ZIP | 
                                  
- 2: You need to run `install.bat`, if you have already Game Booster, the script prevent's you and stopping the execution.


**Modifing part**


If you want's to modifiy INI of Game Booster, you need to reinstall it, run `uninstall.bat` first, and you need to redownload this repository.
After that, follow the first step of **Installing part**.
Create a file in the folder with `install.bat` and `uninstall.bat` named `config.ini`.

**INI part**


We have just one option if you want's to edit the INI file.

```
[Config]
Folder=C:\GameBooster
```

You can edit the value of folder key.


Ex:
```
[Config]
Folder=F:\BoostGame
```

⚠: Do not add a backslash at the end of your folder key.

⚠ (2): The keys is case sensitive and the name of keys and the name of sections.
