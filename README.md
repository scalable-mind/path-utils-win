# path-utils-win
Useful scripts for Windows Path variable manipulating

## PathUtils.Show.ps1

Prints the `Path` variable.

* Specifying `-env_type` param as `System` (by default), the system `Path` is
  printed. Specifying `-env_type` param as `User`, the current user `Path` is
  printed.
* Specifying `-view` param as `List` (by default), the `Path` is splitted and
  displayed in a list. Specifying `-view` param as `Raw`, the `Path` displayed
  as a string value, as is.
* When `-view:List`, it also prints the total information about count of paths
  before the list.
* When `-view:List`, it also understands which paths do not exist. The existent
  paths are marked by `*`; the nonexistent ones are colored in red, and marked
  by `!`.

## PathUtils.Add.ps1

## PathUtils.Remove.ps1

## PathUtils.Clean.ps1
