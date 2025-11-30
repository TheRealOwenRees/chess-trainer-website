# 📝 Project TODOs

## 🚀 High Priority

- [x] Spec fixes in `game.ex`.
- [ ] Spec fixes in `show.ex`.
- [ ] Fix tests in `test/chess_trainer_web/live/endgame_live_test.exs`.
- [ ] Add tags to endgame.
  - Choose from (searchable) existing tags
  - add new tag if not available
  - can select multiple tags
- [ ] Create page for interactive endgame play:
  - Larger board - LiveView
  - List of moves made
  - Forwards / backwards buttons
  - Flip board button
  - Move highlighting
  - opponent move auto-play - which move from moves list in tablebase? First? Random from all that are relevant?
- [ ] Add player colour for endgame based on FEN, auto populating DB

## 📦 Medium Priority

- [x] Editing an endgame should not allow us to edit the FEN.
- [x] Result when making new or editing endgame should be a dropdown containing win/draw/loss
- [ ] Key is a specific format eg KvKQ. Can we enforce this rule?

## 🛠️ Low Priority

- [ ] Swap out custom cache in favour of CacheX. This might allow us to increase the size of the cache since dealing with LRU will be more efficient. Benchmark it.
- [ ] Update GenServer tests to match pattern in Elixir Patterns book.

## 📚 Documentation

- [ ]

---

✅ Keep this file updated as tasks are completed. Use `git diff` to track progress.
