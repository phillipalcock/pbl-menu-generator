---
name: pbl-menu-generator
description: "Generates a complete PBL project choice menu system from a teacher input file. Creates: (1) a PowerPoint menu slide with 5 columns of project cards matching the visual style of the PBL menu image, (2) one individual student project brief per card as a .docx file, and (3) a teacher launch guide. Trigger when a teacher provides a pbl-menu-input.md file and asks to generate their PBL menu, project choices, or student project briefs."
---

# PBL Menu Generator

Generates a complete PBL project choice system from a single teacher input file.

## What This Skill Produces

1. `menu-slide.pptx` — the 5-column project card menu (one slide, print/display ready)
2. `/project-briefs/[project-name].docx` — one student brief per project card (20 total)
3. `teacher-guide.docx` — launch guide, coaching questions, and rubric template

---

## Step 0: Read Dependencies

Before writing any code, read these two skills in full:
- `/mnt/skills/public/pptx/SKILL.md`
- `/mnt/skills/public/docx/SKILL.md`

---

## Step 1: Read and Parse the Teacher Input File

Read `/home/claude/pbl-menu-input.md`

Extract:
- `subject` — subject area or theme
- `year_group` — e.g. "Year 9", "Grade 7", "KS3"
- `age_range` — e.g. "13-14"
- `weeks` — number of weeks available
- `class_size` — number of students
- `curriculum_standards` — the learning objectives to embed
- `categories` — array of 5 category objects, each with:
  - `name` — display name
  - `color` — hex color (use defaults if blank: #4DB6AC, #E07B5A, #2C4A6E, #D4A843, #6B9E7A)
  - `projects` — array of 4 project title strings
- `color_scheme` — "default", "warm", "cool", or custom hex values
- `school_name` — optional, for footer
- `additional_notes` — any extra context

### Validation Check
Before proceeding, verify:
- [ ] Exactly 5 categories present
- [ ] Each category has exactly 4 project titles
- [ ] year_group is specified
- [ ] weeks is a number

If validation fails, stop and tell the teacher exactly which fields are missing.

---

## Step 2: Generate the Menu Slide (PPTX)

Follow `/mnt/skills/public/pptx/SKILL.md` — use pptxgenjs to create from scratch.

### Slide Specification

**Slide dimensions:** 33.87cm × 19.05cm (widescreen 16:9)

**Layout:**
- No slide title needed — the cards ARE the content
- 5 equal columns across the full width
- Each column: colored header rectangle + 4 white project cards stacked below
- Bottom banner: full-width light gray bar with the text "Students choose from the menu. They shape their own driving question within it."

**Column headers:**
- Height: 2.8cm
- Full column width
- Text: category name, white, bold, 18pt, centered vertically and horizontally
- Background: the category hex color

**Project cards:**
- White background: `#FFFFFF`
- Rounded corners: 0.3cm radius
- Subtle shadow: use pptxgenjs shadow options
- Card size: column width minus 0.3cm padding on each side × 3.2cm tall
- Card content: project name centered, 13pt, bold, dark gray `#2D2D2D`
- Gap between cards: 0.25cm
- Cards start 0.3cm below the column header

**Colors (defaults — override with teacher's choices):**
- Entrepreneurship: `#4DB6AC`
- Creative Production: `#E07B5A`
- Technology: `#2C4A6E`
- Community: `#D4A843`
- Environment: `#6B9E7A`

**Bottom banner:**
- Y position: below last card row
- Background: `#F0F0F0`
- Text: "Students choose from the menu. They shape their own driving question within it."
- Font: 12pt, italic, dark gray, centered

**If school_name is provided:** add it as a small footer in the bottom-right corner, 9pt, gray.

### Visual QA
Convert to image and inspect:
```bash
python scripts/office/soffice.py --headless --convert-to pdf menu-slide.pptx
pdftoppm -jpeg -r 150 menu-slide.pdf slide
```

Check:
- All 5 columns visible and equal width
- All 20 project cards present with correct names
- No text overflow or truncation
- Colors match the teacher's input
- Bottom banner text is complete and readable

Fix any issues before proceeding.

---

## Step 3: Generate Student Project Briefs (DOCX × 20)

Follow `/mnt/skills/public/docx/SKILL.md` — use docx-js to create each file.

**Output path:** `/mnt/user-data/outputs/pbl-menu/project-briefs/[category]-[project-name].docx`

For EACH of the 20 project cards, generate one .docx with this structure:

### Brief Template

**Page 1 Header:**
- Project category (colored, matches column color)
- Project title (H1, large, bold)
- Colored horizontal rule in the category color

**Section 1 — Your Driving Question**
- Heading: "Shape Your Driving Question"
- Body text: "Use the stem below to write your own driving question for this project:"
- Styled callout box: "How might we _________ ?"
- 3 lines for students to draft their question

**Section 2 — Why This Project Matters**
- Heading: "Real-World Problems This Solves"
- 3 bullet points — generate 3 real-world problems relevant to this specific project type
- Calibrate language to the teacher's `year_group` and `age_range`

**Section 3 — Your Project Milestones**
- Heading: "Milestone Plan"
- Table with columns: Week | Milestone | What You'll Produce
- 5 rows — generate milestone tasks appropriate to this project type
- Spread milestones across the teacher's `weeks` value
- Reference any relevant `curriculum_standards`

**Section 4 — What You'll Need**
- Heading: "Resources & Tools"
- Bullet list of 4-6 resources appropriate to the project type
- Include: research sources, tools, people/experts to consult

**Section 5 — Success Criteria**
- Heading: "You'll Know You've Succeeded When..."
- 4 bullet points in student-facing language ("I can...", "My project shows...", "I have...")
- Align with `curriculum_standards` where provided

**Footer:**
- Left: Subject/theme + Year group
- Right: School name (if provided)

### Batch Generation Strategy
Generate all 20 briefs using a loop. Name files as:
`[category-slug]-[project-slug].docx`
e.g. `entrepreneurship-food-truck.docx`

---

## Step 4: Generate Teacher Guide (DOCX)

Follow `/mnt/skills/public/docx/SKILL.md`

**Output:** `/mnt/user-data/outputs/pbl-menu/teacher-guide.docx`

Structure:

**Cover:** "PBL Project Menu — Teacher Launch Guide" + subject + year group + school name

**Section 1 — How to Launch**
- Step-by-step instructions for introducing the menu to students
- Suggested timing (e.g. one lesson for menu exploration and question drafting)
- How to handle students who can't decide

**Section 2 — Coaching the Driving Question**
- Why driving questions matter in PBL
- 8 coaching questions to ask students as they draft (e.g. "Who is affected by this?", "What would success look like for a real audience?")
- Common weak question patterns to watch for + how to redirect

**Section 3 — Differentiation Notes**
- For each of the 5 categories: one note on how to support lower-confidence students and one on how to stretch high-ability students
- Format as a simple 3-column table: Category | Support | Stretch

**Section 4 — Assessment Rubric Template**
- Table with columns: Criterion | Beginning | Developing | Achieving | Exceeding
- 5 rows: Driving Question Quality, Project Execution, Real-World Connection, Collaboration, Presentation/Product
- Leave cells editable (not pre-filled) so teacher can customise

**Section 5 — Curriculum Alignment**
- If `curriculum_standards` were provided, a mapping table: Standard → Which Projects Address It
- If not provided, placeholder section with instructions

---

## Step 5: Final Output Check

```
/mnt/user-data/outputs/pbl-menu/
├── menu-slide.pptx
├── teacher-guide.docx
└── project-briefs/
    ├── entrepreneurship-food-truck.docx
    ├── entrepreneurship-clothing-brand.docx
    ├── ... (20 files total)
```

Verify:
- [ ] menu-slide.pptx exists and passed visual QA
- [ ] Exactly 20 project brief files exist
- [ ] teacher-guide.docx exists
- [ ] All files open without errors (run validate.py on each docx)

Report to the teacher:
- Total files generated
- Any warnings or issues found
- Suggested next step (print the menu slide, distribute briefs by project choice)
