docker compose run --rm \
  -e USE_SSH=true \
  -v "$HOME/.ssh/id_ed25519:/root/.ssh/id_ed25519:ro" \
  -v "$HOME/.ssh/id_ed25519.pub:/root/.ssh/id_ed25519.pub:ro" \
  -v "$HOME/.ssh:/Users/adam/.ssh:ro" \
  -v "$HOME/.gitconfig:/root/.gitconfig:ro" \
  writing-dev npm run deploy
