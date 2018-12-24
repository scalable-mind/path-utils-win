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

function Write-HostMulticolor {
    param (
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Black', 'DarkBlue', 'DarkGreen', 'DarkCyan',
                     'DarkRed', 'DarkMagenta', 'DarkYellow', 'Gray',
                     'DarkGray', 'Blue', 'Green', 'Cyan', 'Red',
                     'Magenta', 'Yellow', 'White', 'ColorDefault')]
        [String[]]$colors,

        [ValidateNotNullOrEmpty()]
        [String[]]$messages,

        [Switch]$single = $false
    )

    if ($single) {
        Write-Host -ForegroundColor:$colors[0] $messages
        return
    }

    if ($colors.Count -ne $messages.Count) {
        throw 'Number of colors and messages must be equal!'
    }

    for ($i = 0; $i -lt $colors.Count; $i++) {
        if ($colors[$i] -eq 'ColorDefault') {
            $colors[$i] = (get-host).ui.rawui.ForegroundColor
        }
    }
    
    for ($i = 0; $i -lt ($messages.Count - 1); $i++) {
        Write-Host -ForegroundColor:$colors[$i] ($messages[$i], "") -NoNewline
    }

    Write-Host -ForegroundColor:$colors[$colors.Count - 1] $messages[$messages.Count - 1]
}

[string]$current_path = [System.Environment]::GetEnvironmentVariable('Path', $env_types_map[$env_type])
[string[]]$paths = $current_path.Split(';', [System.StringSplitOptions]::RemoveEmptyEntries)

[string[]]$inaccessible_paths = @()
foreach ($path in $paths) {
    if (-not (Test-Path $path)) {
        $inaccessible_paths += $path
    }
}

[hashtable]$paths_occurrences  = @{}
foreach ($path in $paths) {
    $paths_occurrences[$path]++
}

switch ($view) {
    'Raw' {
        Write-Output $current_path
    }

    'List' {
        Write-Host "Total $($paths.Length) items" -ForegroundColor:DarkGreen
        foreach ($path in $paths) {
            if ($paths_occurrences[$path] -gt 1) {
                Write-HostMulticolor -colors:Yellow -messages:("#", $path) -single
            }
            elseif ($inaccessible_paths -contains $path) {
                Write-HostMulticolor -colors:Red -messages:("!", $path) -single
            } else {
                Write-HostMulticolor -colors:Green,ColorDefault -messages:("*", $path)
            }
        }
    }

    default {
        throw "View type '$view' is not supported."
    }
}
