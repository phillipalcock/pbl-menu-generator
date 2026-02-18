# Generate PBL Menu

Generate a complete PBL project choice menu system from the teacher's input file.

## What This Does

Reads `/home/claude/pbl-menu-input.md` and produces:
1. `menu-slide.pptx` — the 5-column project card menu
2. 20 student project brief `.docx` files (one per project card)
3. `teacher-guide.docx` — launch guide with coaching questions and rubric

## Usage

```
/pbl-menu-generator:generate
```

Or with a custom input file:

```
/pbl-menu-generator:generate path/to/my-input.md
```

## Before Running

Make sure you've filled in your input file at `/home/claude/pbl-menu-input.md`.
A blank template is included with this plugin. Example files are in `examples/`.

## Output Location

All files are saved to `/mnt/user-data/outputs/pbl-menu/`
