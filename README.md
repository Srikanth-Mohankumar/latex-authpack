# authpack - Advanced Author/Affiliation Management for LuaLaTeX

**Version:** 1.0  
**Date:** 2025-10-15  
**Author:** Srikanth Mohankumar  
**License:** LaTeX Project Public License

## Overview

`authpack` is a sophisticated LaTeX package for managing authors and their affiliations in academic documents. It provides clickable markers, ORCID integration, and flexible layout styles using Lua scripting for maximum flexibility and performance.

## Requirements

- **LuaLaTeX** (required - will not work with pdfLaTeX or XeLaTeX)
- `hyperref` package (optional, for clickable links)
- `graphicx` package (for ORCID icon display)
- ORCID icon file: `orcid.pdf` (optional, for icon display)

## Installation

1. Place `authpack.sty` in your LaTeX project directory or in your local texmf tree
2. Optionally place `orcid.pdf` icon in the same directory
3. Compile your document with `lualatex`

## Basic Usage

```latex
\documentclass{article}
\usepackage{hyperref}
\usepackage{authpack}

\begin{document}

% Define affiliations
\Affil{uni1}{University of Example}
\Affil{uni2}{Institute of Technology}

% Define authors
\Author{author1}{John Doe}{affils=uni1, orcid=0000-0001-2345-6789}
\Author{author2}{Jane Smith}{affils=uni2}

\title{My Research Paper}
\maketitle

\end{document}
```

## Package Options

Load the package with options:

```latex
\usepackage[style=inline, marker=num, orcid=icon]{authpack}
```

### Available Options

| Option | Values | Default | Description |
|--------|--------|---------|-------------|
| `style` | `inline`, `block`, `footnote` | `inline` | Layout style for authors/affiliations |
| `marker` | `num`, `alpha`, `symbol` | `num` | Marker style for affiliations |
| `commasep` | `true`, `false` | `true` | Use commas between author names |
| `oxford` | `true`, `false` | `true` | Use Oxford comma before "and" |
| `showand` | `true`, `false` | `true` | Show "and" before last author |
| `orcid` | `icon`, `text`, `none` | `icon` | ORCID display style |
| `orcidlink` | `true`, `false` | `true` | Make ORCID clickable |
| `backlink` | `true`, `false` | `false` | Add return links from affiliations |

## Commands

### `\Affil[label][id]{key}{text}`

Defines an affiliation.

- `label` (optional): Custom marker label (e.g., `*`, `a`, `1`)
- `id` (optional): Custom HTML anchor ID for hyperlinks
- `key` (required): Unique identifier for this affiliation
- `text` (required): Affiliation text to display

**Examples:**

```latex
\Affil{mit}{Massachusetts Institute of Technology}
\Affil[*]{harvard}{Harvard University}
\Affil[A][custom-id]{oxford}{University of Oxford}
```

### `\Author{key}{name}{options}`

Defines an author with optional metadata.

- `key` (required): Unique identifier for this author
- `name` (required): Author's full name
- `options` (required): Comma-separated key=value pairs

**Options:**

- `affils`: Comma-separated list of affiliation keys
- `email`: Email address
- `orcid`: ORCID identifier (format: 0000-0000-0000-0000)
- `marker`: Custom marker (rarely needed)

**Examples:**

```latex
\Author{jdoe}{John Doe}{affils=mit, orcid=0000-0001-2345-6789}
\Author{jsmith}{Jane Smith}{affils=mit,harvard, email=jane@example.com}
\Author{bob}{Bob Johnson}{affils=oxford}
```

### `\PrintAuthors`

Manually renders the author and affiliation block. Usually not needed as `\maketitle` automatically calls this.

## Styles

### Inline Style (default)

Authors listed in a single paragraph with superscript affiliation markers, followed by affiliation list.

```latex
\usepackage[style=inline]{authpack}
```

**Output format:**
```
John Doe¹, Jane Smith¹,² and Bob Johnson³

¹Massachusetts Institute of Technology
²Harvard University
³University of Oxford
```

### Block Style

Authors grouped by affiliation with affiliation text below each group.

```latex
\usepackage[style=block]{authpack}
```

**Output format:**
```
John Doe and Jane Smith
  Massachusetts Institute of Technology

Jane Smith
  Harvard University

Bob Johnson
  University of Oxford
```

## Marker Styles

### Numeric (default)

```latex
\usepackage[marker=num]{authpack}
```
Produces: ¹, ², ³, 4, 5...

### Alphabetic

```latex
\usepackage[marker=alpha]{authpack}
```
Produces: A, B, C, D, E...

### Symbolic

```latex
\usepackage[marker=symbol]{authpack}
```
Produces: *, †, ‡, §, ¶, ||, **, ††, ‡‡

## ORCID Integration

### Icon Display (default)

```latex
\usepackage[orcid=icon]{authpack}
```
Displays the ORCID icon next to author names (requires `orcid.pdf`).

### Text Display

```latex
\usepackage[orcid=text]{authpack}
```
Displays "ORCID: 0000-0000-0000-0000" next to author names.

### No Display

```latex
\usepackage[orcid=none]{authpack}
```
Hides ORCID information.

## Advanced Features

### Multiple Affiliations

Authors can have multiple affiliations:

```latex
\Affil{uni1}{University A}
\Affil{uni2}{University B}
\Affil{uni3}{University C}

\Author{jdoe}{John Doe}{affils=uni1,uni2,uni3}
```

### Custom Markers

Override automatic marker generation:

```latex
\Affil[*]{primary}{Primary Institution}
\Affil[†]{secondary}{Secondary Institution}
```

### Clickable Links

When `hyperref` is loaded, affiliation markers are clickable and link to the affiliation text. Use `backlink=true` to add return links:

```latex
\usepackage[backlink=true]{authpack}
```

### Duplicate Label Handling

If duplicate markers are detected, the package automatically adds suffixes (a, b, c, etc.) and issues a warning.

## Complete Examples

See the test files:
- `test-basic.tex` - Basic usage
- `test-inline.tex` - Inline style with all marker types
- `test-block.tex` - Block style layout
- `test-advanced.tex` - Multiple affiliations and ORCID
- `test-options.tex` - Various option combinations

## Troubleshooting

### "LuaTeX required" error

**Solution:** Compile with `lualatex` instead of `pdflatex`:

```bash
lualatex mydocument.tex
```

### ORCID icon not displaying

**Solution:** 
1. Download the ORCID icon from https://orcid.org/trademark-and-id-display-guidelines
2. Save as `orcid.pdf` in your document directory
3. Or use `orcid=text` option instead

### Markers not clickable

**Solution:** Load `hyperref` package before `authpack`:

```latex
\usepackage{hyperref}
\usepackage{authpack}
```

### Duplicate label warnings

**Solution:** Use explicit labels with `\Affil[label]` to control marker assignment.

## Limitations

- Requires LuaLaTeX (not compatible with pdfLaTeX or XeLaTeX)
- ORCID icon requires external `orcid.pdf` file
- Maximum of ~81 symbols in symbol mode (9 base symbols × 9 repetitions)

## Contributing

Report bugs and request features at the package repository.

## License

This package is released under the LaTeX Project Public License v1.3c or later.

## Changelog

### Version 1.0 (2025-10-15)
- Initial release
- Inline and block styles
- Multiple marker types (numeric, alphabetic, symbolic)
- ORCID integration with clickable links
- Automatic duplicate label handling
- Hyperlink support with optional backlinks