# post-compact hook: 上下文压缩后提示恢复 (Windows)

$storyState = ".story-state"

if (-not (Test-Path $storyState)) { exit 0 }

try {
    $state = Get-Content $storyState -Raw | ConvertFrom-Json
    $bookName = $state.book_name
    $currentVol = $state.current_volume
    $currentCh = $state.current_chapter

    Write-Output "ai-story: ⚠️ 上下文已压缩。"
    Write-Output "  项目：《${bookName}》第${currentVol}卷 第${currentCh}章"
    Write-Output "  请读取 .story-state 和 03-追踪/ 恢复完整上下文后再继续写作。"

    if ($state.writing_in_progress) {
        Write-Output "  ⚠️ 检测到未完成的写作任务，说`"继续`"恢复。"
    }
}
catch {
    Write-Output "ai-story: ⚠️ 上下文已压缩，请读取 .story-state 恢复。"
}
