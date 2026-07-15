---
date: 2026-07-14
authors:
  - yourname
categories:
  - Meta
tags:
  - getting-started
slug: welcome
---

# Welcome to ML Research Notes

This is an example post showing what a plain-Markdown entry looks like — headings,
math, code, callouts, and footnotes. Adding a new post is as simple as dropping a
Markdown file into `docs/blog/posts/`.

<!-- more -->

## Math renders with LaTeX

Inline math like $\nabla_\theta \mathcal{L}(\theta)$ works, and so do display
equations:

$$
\theta_{t+1} = \theta_t - \eta \, \nabla_\theta \mathcal{L}(\theta_t)
$$

## Code blocks have highlighting and a copy button

```python
import torch

def gradient_step(model, batch, lr=1e-3):
    loss = model.loss(batch)
    loss.backward()
    with torch.no_grad():
        for p in model.parameters():
            p -= lr * p.grad
            p.grad = None
    return loss.item()
```

## Callouts for intuition and caveats

!!! note "Intuition"
    SGD is just repeatedly nudging parameters downhill along a noisy estimate of
    the gradient.

!!! warning "Caveat"
    Learning-rate choice dominates everything. When in doubt, sweep it.[^lr]

[^lr]: A log-spaced sweep over three orders of magnitude is usually enough to find
    the right ballpark.

That's it — see the [interactive plots demo](interactive-plots-demo.md) for how to
embed charts.
