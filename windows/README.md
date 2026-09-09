# DSC

To get a list of installed `winget` packages with `dsc`:

```powershell
dsc resource export --resource Microsoft.WinGet/Package --output-format yaml | Out-File -FilePath .\windows\current.yaml
```
