# 字数统计脚本 (Windows)
# 用法: powershell word-count.ps1 [目录路径]
# 示例: powershell word-count.ps1 "04-正文/"

param(
    [string]$Target = "."
)

Write-Output "=== ai-story 字数统计 ==="
Write-Output ""

$total = 0

Get-ChildItem -Path $Target -Filter "*.md" -Recurse | Sort-Object FullName | ForEach-Object {
    $content = Get-Content $_.FullName -Raw -Encoding UTF8
    # 去掉Markdown标记和空白，统计剩余字符数
    $clean = $content -replace '[#*\[\]()>\-`]', '' -replace '\s+', ''
    $chars = $clean.Length

    if ($chars -gt 0) {
        $relative = $_.FullName.Replace((Resolve-Path $Target).Path, "").TrimStart("\")
        Write-Output ("  {0}: {1} 字" -f $relative, $chars)
        $script:total += $chars
    }
}

Write-Output ""
Write-Output ("  总计: {0} 字" -f $total)

if ($total -gt 0) {
    $days = [math]::Floor($total / 4000)
    Write-Output ("  约等于 {0} 天日更量（按4000字/天计算）" -f $days)
}
