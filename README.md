# Website

This website is built using [Docusaurus](https://docusaurus.io/), a modern static website generator.

Node.js is not installed on the host. Run all npm commands inside Docker via Colima (see `~/git/AGENTS.md`).

### Prerequisites

```bash
colima start
```

### Local Development

From this directory:

```bash
docker compose up
```

This builds the `writing-dev` image and starts the Docusaurus dev server with live reload. Open [http://localhost:3000/writing/](http://localhost:3000/writing/).

Useful one-offs:

```bash
docker compose run --rm writing-dev npm run build
docker compose run --rm writing-dev npm run typecheck
```

### Build

```bash
docker compose run --rm writing-dev npm run build
```

This generates static content into the `build` directory.

### Production image

```bash
docker build --target prod -t writing:prod .
docker run --rm -p 3000:3000 writing:prod
```

### Deployment

Rebuild the image after Dockerfile changes (`docker compose build writing-dev`).

Using SSH (Colima cannot use the macOS SSH agent socket — mount your GitHub key and git identity instead):

```bash
docker compose run --rm \
  -e USE_SSH=true \
  -v "$HOME/.ssh/id_ed25519:/root/.ssh/id_ed25519:ro" \
  -v "$HOME/.ssh/id_ed25519.pub:/root/.ssh/id_ed25519.pub:ro" \
  -v "$HOME/.ssh:/Users/adam/.ssh:ro" \
  -v "$HOME/.gitconfig:/root/.gitconfig:ro" \
  writing-dev npm run deploy
```

The `/Users/adam/.ssh` mount is required because your gitconfig signs commits with that absolute key path.
Not using SSH:

```bash
docker compose run --rm \
  -e GIT_USER=<Your GitHub username> \
  -v "$HOME/.gitconfig:/root/.gitconfig:ro" \
  writing-dev npm run deploy
```

If you are using GitHub pages for hosting, this command is a convenient way to build the website and push to the `gh-pages` branch.
