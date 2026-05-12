# pre-compact hook: 上下文压缩前保存快照 (Windows)

$storyState = ".story-state"
$snapshot = ".story-snapshot.json"

if (-not (Test-Path $storyState)) { exit 0 }

Copy-Item $storyState $snapshot -Force
Write-Output "ai-story: 快照已保存到 .story-snapshot.json"
