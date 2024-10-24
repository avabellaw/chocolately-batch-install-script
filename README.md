# chocolately-batch-install-script
Neatly installs all programs in the array using Chocolately package manager. Useful for after reinstalling Windows.
Outputs progress and informs you at end if any failed.

**Chocolately will be installed automatically**

## Steps
1. Add the programs you want to install into the array at the top of the file. For example:

    _Google "choco [program name]" to find the exact name to use. You can then review the package before installing_

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

