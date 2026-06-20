# Wiki Log

> Append-only.
> Format: `## [YYYY-MM-DD] action | subject`
> Actions: create, ingest, compile, update, query, lint, archive

## [2026-06-17] create | Wiki initialized
- Path: `/home/shin/PersonalKnowledge/Wiki`
- Symlink: `/home/shin/wiki` -> `/home/shin/PersonalKnowledge/Wiki`
- Created core files: `SCHEMA.md`, `index.md`, `log.md`
- Created directories: `raw/{web,video,audio,documents,share-text,assets}`, `entities/`, `concepts/`, `comparisons/`, `queries/`
- Decision: Wiki is a compile layer parallel to `Conclusions/`, `Knowledge/`, and `AI-Center/`
- Decision: do not compile directly from `_inbox/`; require upstream parsing/staging first

## [2026-06-17] compile | Scenario A YouTube sample
- Source staging note: `/home/shin/PersonalKnowledge/Conclusions/_staging/video_20260604_110453_Rick_Astley_-_Never_Gonn.md`
- Created raw snapshot: `raw/video/2026-06-04-youtube-rick-astley-never-gonna-give-you-up.md`
- Created concept pages: `concepts/knowledge-compilation-layer.md`, `concepts/video-link-ingestion.md`
- Created query page: `queries/scenario-a-youtube-sample.md`
- Updated `index.md` total pages to 3
- Finding: current workflow can compile staging into Wiki, but ASR quality still requires downstream judgment

## [2026-06-18] compile | Scenario A Bilibili sample
- Source staging note: `/home/shin/PersonalKnowledge/Conclusions/_staging/video_20260618_005558_花了一周半把我用codex的坑全部总结了出来_如.md`
- Created raw snapshot: `raw/video/2026-06-18-bilibili-codex-pitfalls-ak007.md`
- Created query page: `queries/scenario-a-bilibili-sample.md`
- Verified boundary: bare `yt-dlp` hit HTTP 412, browser-profile-assisted flow succeeded
- Verified quality: no subtitles were exposed; fallback path was audio + ASR via `openai-whisper tiny`

