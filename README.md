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
* When `-view:List`, script prints the total information about count of paths
  before the list. It also Marks existent paths with `*` (the mark is green),
  nonexistent as `!` (the whole line is red),  and duplicated as `#` (the
  whole line is yellow).
* When `-view:Raw`, valid semicolons have green background and white foreground,
  and extra semicolons have red background and white foreground.

## PathUtils.Add.ps1

## PathUtils.Remove.ps1

## PathUtils.Clean.ps1
