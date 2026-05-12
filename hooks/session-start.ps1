# session-start hook: 会话启动时读取项目状态并输出进度提示
# Windows PowerShell 版本

$storyState = ".story-state"

if (-not (Test-Path $storyState)) {
    Write-Output "ai-story: 未检测到小说项目。说`"帮我开一本小说`"开始创作。"
    exit 0
}

try {
    $state = Get-Content $storyState -Raw | ConvertFrom-Json
    $bookName = $state.book_name
    $currentVol = $state.current_volume
    $currentCh = $state.current_chapter
    $totalWords = $state.total_words
    $status = $state.status
    $nextCh = $currentCh + 1

    Write-Output "ai-story: 《${bookName}》第${currentVol}卷 第${currentCh}章 共${totalWords}字 [${status}]"

    if ($state.writing_in_progress) {
        $wipCh = $state.writing_in_progress.chapter
        $wipStage = $state.writing_in_progress.stage
        Write-Output "  ⚠️ 上次写第${wipCh}章在${wipStage}阶段被中断，说`"继续`"恢复"
    }
    elseif ($status -eq "initialized") {
        Write-Output "  → 下一步：说`"写大纲`"生成章纲"
    }
    elseif ($currentCh -eq 0) {
        Write-Output "  → 下一步：说`"写第一章`"开始创作"
    }
    else {
        Write-Output "  → 下一步：说`"日更`"写第${nextCh}章"
    }
}
catch {
    Write-Output "ai-story: .story-state 读取异常，请检查文件格式"
}
