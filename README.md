# Website

This website is built using [Docusaurus 2](https://docusaurus.io/), a modern static website generator.

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

Using SSH:

```bash
docker compose run --rm -e USE_SSH=true writing-dev npm run deploy
```

Not using SSH:

```bash
docker compose run --rm -e GIT_USER=<Your GitHub username> writing-dev npm run deploy
```

If you are using GitHub pages for hosting, this command is a convenient way to build the website and push to the `gh-pages` branch.
