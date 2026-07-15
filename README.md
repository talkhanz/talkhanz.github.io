# ML Research Notes

A perosnal research blog built with [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/),
managed entirely with [uv](https://docs.astral.sh/uv/). Posts are plain Markdown;
interactive plots are generated from Jupyter notebooks and embedded statically.

## Quick start

```bash
make install     # create the venv and install everything
make serve       # live preview at http://127.0.0.1:8000
```

(Or without make: `uv sync --all-groups`, then `uv run mkdocs serve`.)

## Test it locally

From the project root:

```bash
make install     # one-time: creates the venv and installs everything via uv
make serve       # starts the live-reload dev server
```

Then open:

```
http://127.0.0.1:8000/
```

`make serve` hot-reloads — edit any `.md` and the browser refreshes
automatically. Press `Ctrl+C` to stop.

Without `make`:

```bash
uv sync --all-groups          # = make install
uv run mkdocs serve           # = make serve
```

### What to check on the running site

- **Home** → `/`
- **Blog list** → `/blog/`
- **Static + interactive plots** → `/blog/2026/07/14/interactive-plots-demo/`
  (hover, zoom, and pan the Plotly chart)
- **Dark/light toggle** (top bar), **search**, and **math rendering** on the
  welcome post

To regenerate plots after editing the notebook, run `make plots` (see
[Adding plots](#adding-plots)).

## Writing a new post

1. Create a Markdown file in `docs/blog/posts/`, e.g. `my-post.md`.
2. Add front matter at the top:

   ```yaml
   ---
   date: 2026-07-14
   authors:
     - yourname
   categories:
     - Papers
   tags:
     - transformers
   slug: my-post
   ---

   # My Post Title

   A one-paragraph teaser shown on the blog index.

   <!-- more -->

   The rest of the post...
   ```

3. Save. `make serve` hot-reloads it. That's the whole workflow.

Math (`$...$` / `$$...$$`), fenced code blocks, admonitions (`!!! note`), and
footnotes all work out of the box.

## Adding plots

Plots live in a notebook so you can regenerate them reproducibly.

1. Edit or add a notebook in `notebooks/` (see `example_plots.ipynb`). Write
   outputs into `docs/assets/plots/`.
2. Regenerate the committed assets:

   ```bash
   make plots
   ```

3. Embed them in a post:

   - **Static image:** `![caption](../../assets/plots/loss_curve.png){ .plot }`
   - **Interactive Plotly:** export with
     `fig.write_html(path, include_plotlyjs="cdn", full_html=False)` then inline
     it with `--8<-- "assets/plots/scaling.html"`.

The generated PNG/HTML are committed to the repo, so deploys never execute
notebooks.

## Deploying to GitHub Pages

This project is configured as a **user site**, served at the domain root.

1. Create a GitHub repo named **exactly** `YOUR_USERNAME.github.io` (this exact
   name is what makes it a root user site). Push this project to it.
2. Replace `YOUR_USERNAME` throughout `mkdocs.yml` (`site_url`, `repo_url`,
   `repo_name`), and update `site_author`, `docs/blog/.authors.yml`, and
   `docs/about.md` with your details.
3. In the repo, go to **Settings → Pages → Build and deployment** and set
   **Source** to **GitHub Actions**.
4. Push to `main`. The workflow in `.github/workflows/deploy.yml` builds and
   publishes automatically. Your site appears at `https://YOUR_USERNAME.github.io/`.

> **Want a project site instead** (repo with any name, served at
> `https://YOUR_USERNAME.github.io/REPO_NAME/`)? Set
> `site_url: https://YOUR_USERNAME.github.io/REPO_NAME/` and point `repo_url` /
> `repo_name` at that repo. Everything else is identical.

## Project layout

```
mkdocs.yml                 # site config, theme, plugins
pyproject.toml             # uv-managed deps (site + notebooks group)
Makefile                   # install / serve / build / plots / deploy
docs/
  index.md                 # landing page
  about.md
  blog/
    index.md               # blog home
    .authors.yml           # author profiles
    posts/                 # <-- add Markdown posts here
  assets/
    plots/                 # generated PNG/HTML (committed)
    stylesheets/extra.css
    javascripts/mathjax.js
notebooks/
  example_plots.ipynb      # generates the plot assets
.github/workflows/deploy.yml
```
