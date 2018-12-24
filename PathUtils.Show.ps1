# Path-Utils.Show
#
# Params:
#   -env_type   Environment namespace ('System' or 'User'), 'System' is by default.
#   -view       How to display path (as 'List', or as 'Raw' value), as 'List' is by default.
#

param (
    [ValidateNotNullOrEmpty()]
    [ValidateSet('System', 'User')]
    [String]$env_type = 'System',

    [ValidateNotNullOrEmpty()]
    [ValidateSet('List', 'Raw')]
    [String]$view = 'List'
)

$env_types_map = @{
    'System' = [System.EnvironmentVariableTarget]::Machine
    'User' = [System.EnvironmentVariableTarget]::User
}

[string]$current_path = [System.Environment]::GetEnvironmentVariable('Path', $env_types_map[$env_type])
[string[]]$paths = $current_path.Split(';', [System.StringSplitOptions]::RemoveEmptyEntries)

[string[]]$inaccessible_paths = @()
foreach ($path in $paths) {
    if (-not (Test-Path $path)) {
        $inaccessible_paths += $path
    }
}

switch ($view) {
    'Raw' {
        Write-Output $current_path
    }

    'List' {
        Write-Host "total $($paths.Length) items"
        foreach ($path in $paths) {
            if ($inaccessible_paths -contains $path) {
                Write-Host -ForegroundColor:Red "! $path"
            } else {
                Write-Host "* $path"
            }
        }
    }

    default {
        throw "View type '$view' is not supported."
    }
}
