set-content env:path "$(get-content env:path);$((get-item .\bin\).FullName)"