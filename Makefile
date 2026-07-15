.PHONY: install plots serve build deploy clean

# Install all dependencies (site + notebooks) into a uv-managed venv.
install:
	uv sync --all-groups

# Execute notebooks and regenerate plot assets in docs/assets/plots/.
plots:
	uv run --group notebooks jupyter nbconvert --to notebook --execute --inplace notebooks/*.ipynb

# Live-preview the site at http://127.0.0.1:8000 with auto-reload.
serve:
	uv run mkdocs serve

# Build the static site into ./site.
build:
	uv run mkdocs build --strict

# Build and push to the gh-pages branch (manual alternative to the GH Action).
deploy:
	uv run mkdocs gh-deploy --force

clean:
	rm -rf site
