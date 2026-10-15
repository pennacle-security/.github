## What

<!-- one or two sentences -->

## Why

<!-- link the issue, or explain the problem -->

## How tested

- [ ] `pytest -q` passes locally
- [ ] new check registered in `summit/scan/modules/__init__.py` (if applicable)
- [ ] safe defaults kept (no blind payload spraying, no third-party callback hosts)
- [ ] verified against `examples/vuln_app.py` (if the change affects detection)

## Detection quality impact

<!-- Does this fire on more pages than before? Did any existing finding change? -->
