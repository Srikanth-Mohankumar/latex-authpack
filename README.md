# authpack - Advanced Author/Affiliation Management for LuaLaTeX

**Version:** 1.2  
**Date:** 2025-10-16  
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
\usepackage[style=inline, marker=num, orcid=icon, debug=false]{authpack}
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
| `backlink` | `true`, `false` | `false` | Add return links from affiliations (inline style only) |
| `debug` | `true`, `false` | `false` | Enable debug output to console/log |

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

- `affils`: Comma-separated list of affiliation keys (supports multiple affiliations)
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

**Features:**
- Authors in single line with clickable superscript markers
- Affiliations listed below with hyperlink targets
- Optional backlinks from affiliations to author list
- Handles multiple affiliations per author

### Block Style

Authors grouped by their affiliation combinations with affiliation text below each group.

```latex
\usepackage[style=block]{authpack}
```

**Output format:**
```
John Doe¹ and Jane Smith¹,²
¹Massachusetts Institute of Technology
²Harvard University

Bob Johnson³
³University of Oxford
```

**Features:**
- Authors grouped by shared affiliations
- Each group shows relevant affiliations immediately below
- Ideal for documents with clear institutional groupings

### Footnote Style

Authors listed with superscript markers, affiliations rendered as LaTeX footnotes at page bottom.

```latex
\usepackage[style=footnote]{authpack}
```

**Output format:**
```
John Doe¹, Jane Smith¹,² and Bob Johnson³
```

With footnotes at bottom of page:
- ¹ Massachusetts Institute of Technology
- ² Harvard University
- ³ University of Oxford

**Features:**
- Uses `\footnotetext` for proper footnote placement
- Clickable superscript markers link to footnotes
- Each affiliation appears exactly once
- Ideal for traditional academic paper format

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

### Clickable ORCID Links

By default, ORCID identifiers are clickable and link to `https://orcid.org/[ID]`. Disable with:

```latex
\usepackage[orcidlink=false]{authpack}
```

## Advanced Features

### Multiple Affiliations per Author

Authors can have multiple affiliations with proper marker display:

```latex
\Affil{uni1}{University A}
\Affil{uni2}{University B}
\Affil{uni3}{University C}

\Author{jdoe}{John Doe}{affils=uni1,uni2,uni3}
% Displays as: John Doe¹,²,³
```

**Important:** No spaces in the affiliation list value:
- ✓ Correct: `affils=uni1,uni2,uni3`
- ✗ Wrong: `affils=uni1, uni2, uni3` (spaces will cause parsing issues)

### Custom Markers

Override automatic marker generation:

```latex
\Affil[*]{primary}{Primary Institution}
\Affil[†]{secondary}{Secondary Institution}
```

### Clickable Links

When `hyperref` is loaded, affiliation markers are clickable and link to the affiliation text.

**Inline style:** Use `backlink=true` to add return links from affiliations:

```latex
\usepackage[style=inline, backlink=true]{authpack}
```

**Footnote style:** Superscript markers are automatically clickable and link to footnotes at page bottom.

### Duplicate Label Handling

If duplicate markers are detected, the package automatically adds suffixes (a, b, c, etc.) and issues a warning.

### Debug Mode

Enable comprehensive debug output to trace package behavior:

```latex
\usepackage[debug=true]{authpack}
```

Debug output includes:
- Affiliation registration with keys and markers
- Author registration with affiliation lists
- Marker generation and assignment
- Complete data dump before rendering
- Step-by-step rendering process

Debug messages appear in console output and `.log` file.

## Complete Examples

### Example 1: Basic Multi-Affiliation

```latex
\documentclass{article}
\usepackage{hyperref}
\usepackage[style=inline]{authpack}

\begin{document}

\Affil{mit}{Massachusetts Institute of Technology}
\Affil{harvard}{Harvard University}
\Affil{oxford}{University of Oxford}

\Author{jdoe}{John Doe}{affils=mit, orcid=0000-0001-2345-6789}
\Author{jsmith}{Jane Smith}{affils=mit,harvard}
\Author{bjohnson}{Bob Johnson}{affils=oxford}

\title{My Research Paper}
\maketitle

\end{document}
```

### Example 2: Block Style with Custom Markers

```latex
\documentclass{article}
\usepackage{hyperref}
\usepackage[style=block, marker=alpha]{authpack}

\begin{document}

\Affil{inst1}{First Institution}
\Affil{inst2}{Second Institution}

\Author{auth1}{Author One}{affils=inst1,inst2}
\Author{auth2}{Author Two}{affils=inst2}

\title{Collaborative Research}
\maketitle

\end{document}
```

### Example 3: Footnote Style for Traditional Papers

```latex
\documentclass{article}
\usepackage{hyperref}
\usepackage[style=footnote, marker=num]{authpack}

\begin{document}

\Affil{univ}{University Name}
\Affil{lab}{Laboratory Name}

\Author{lead}{Lead Author}{affils=univ,lab, orcid=0000-0001-2345-6789}
\Author{second}{Second Author}{affils=univ}

\title{Traditional Academic Paper}
\maketitle

\end{document}
```

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

### Multiple affiliations not showing all markers

**Problem:** Only first affiliation appears for authors with multiple affiliations.

**Solution:** Ensure no spaces in affiliation list:
- ✓ Use: `affils=mit,harvard,oxford`
- ✗ Don't use: `affils=mit, harvard, oxford`

### Duplicate label warnings

**Solution:** Use explicit labels with `\Affil[label]` to control marker assignment.

### Footnotes not appearing at page bottom

**Solution:** Ensure you're using `style=footnote`. The package uses `\footnotetext` which requires proper page layout. If footnotes still don't appear, check for conflicting packages.

### Debug output needed

**Solution:** Enable debug mode to see detailed processing:

```latex
\usepackage[debug=true]{authpack}
```

Check console output and `.log` file for debug messages.

## Limitations

- Requires LuaLaTeX (not compatible with pdfLaTeX or XeLaTeX)
- ORCID icon requires external `orcid.pdf` file
- Maximum of ~81 symbols in symbol mode (9 base symbols × 9 repetitions)
- Affiliation lists in `\Author` command must not contain spaces around commas
- `backlink` option only works with `inline` style

## Version History

### Version 1.2 (2025-10-16)
- **Fixed:** Multi-affiliation support now works correctly in all styles
- **Fixed:** Key-value parser now handles comma-separated affiliation lists properly
- **Fixed:** Footnote style now uses `\footnotetext` with proper placement
- **Added:** Clickable hyperlinks in footnote style markers
- **Added:** `debug` option for comprehensive troubleshooting
- **Added:** Affiliation order tracking for consistent output
- **Improved:** Block style now groups authors by affiliation combinations
- **Improved:** Better handling of multiple affiliations per author

### Version 1.0 (2025-10-15)
- Initial release
- Inline and block styles
- Multiple marker types (numeric, alphabetic, symbolic)
- ORCID integration with clickable links
- Automatic duplicate label handling
- Hyperlink support with optional backlinks

## Contributing

Report bugs and request features at the package repository.

## License

This package is released under the LaTeX Project Public License v1.3c or later.

## Author

Srikanth Mohankumar

For support, please use the issue tracker or consult the debug output with `debug=true` enabled.