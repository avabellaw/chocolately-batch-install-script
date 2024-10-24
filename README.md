# chocolately-batch-install-script
Neatly installs all programs in the array using Chocolately package manager. Useful for after reinstalling Windows.
Outputs progress and informs you at end if any failed.

**Chocolately will be installed automatically**

## Steps

1. Add the programs you want to install into the programs.txt file.
    
    _Google "choco [program name]" to find the exact name to use. You can then review the package before installing_
    * **Alternatively**, set ```$programs``` to an array of the programs you want to install. For example:

       ![List of programs](docs/program-list-example.png)
2. Run Powershell as administrator and locate the script.
3. Run the script:
    ```.\InstallPrograms.ps1```

## Notes

The following command will update all programs previously installed with Chocolately:

```choco upgrade all -y```

or alternatively:

```cup all -y```

If Chocolately is in the system PATH.

