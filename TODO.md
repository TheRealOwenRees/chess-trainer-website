# 📝 Project TODOs

## 🚀 High Priority

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
- [ ] Fix liveview tests for navigation
- [ ] Fix endgame tests
- [ ] Fix color for endgame tests
- [ ] validate FEN added into new endgame and check it is a valid endgame

## 📦 Medium Priority

- [ ] basic password auth for admin

## 🛠️ Low Priority

- [ ] Swap out custom cache in favour of CacheX. This might allow us to increase the size of the cache since dealing with LRU will be more efficient. Benchmark it.
- [ ] Update GenServer tests to match pattern in Elixir Patterns book.
- [ ] Increase test coverage

## 📚 Documentation

- [ ]

---

✅ Keep this file updated as tasks are completed. Use `git diff` to track progress.
