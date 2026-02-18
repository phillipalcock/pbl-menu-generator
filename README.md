# PBL Menu Generator for Claude Cowork

Generate a complete PBL project choice system from a single input file.

**What you get in one run:**
- A PowerPoint menu slide with 5 columns of project cards (ready to print or display)
- 20 individual student project brief documents (one per card)
- A teacher launch guide with coaching questions and a rubric template

---

## Install

Open Claude Cowork and run these two commands:

```bash
git clone https://github.com/[YOUR-HANDLE]/pbl-menu-generator.git
cd pbl-menu-generator && bash install.sh
```

That's it. The skill is now available in Cowork.

---

## Use It

**Step 1** — Open the input template:
```
/home/claude/pbl-menu-input.md
```

**Step 2** — Fill in your class details. Takes about 5 minutes. The key fields are:
- Subject/Theme
- Year Group and Age Range
- Weeks Available
- Your 5 category names and 4 project titles per category
- Any curriculum standards you want embedded

**Step 3** — In the Cowork chat, say:
```
Generate my PBL menu using the pbl-menu-generator skill
```

**Step 4** — Find your outputs:
```
/mnt/user-data/outputs/pbl-menu/
├── menu-slide.pptx
├── teacher-guide.docx
└── project-briefs/
    ├── entrepreneurship-food-truck.docx
    ├── ... (20 files total)
```

---

## Customise

You can:
- **Rename categories** — change any of the 5 column headers
- **Swap projects** — replace any of the 20 cards with your own titles
- **Set custom colours** — provide hex codes per category
- **Add your school name** — appears in footers of all documents
- **Paste curriculum standards** — Claude maps these into every brief and the rubric

---

## Examples

See `/home/claude/pbl-examples/` for two ready-to-run examples:
- `example-input-science.md` — Environmental Science, Year 8
- `example-input-humanities.md` — History & Global Citizenship, Year 10

To use an example, copy it to the working directory and run:
```bash
cp /home/claude/pbl-examples/example-input-science.md /home/claude/pbl-menu-input.md
```
Then trigger Cowork as normal.

---

## Re-install / Update

Re-running `install.sh` is safe — it overwrites the skill file and resets the input template to the default blank version. Your previous outputs are not affected.

To get the latest version:
```bash
git pull
bash install.sh
```

---

## Troubleshooting

**"Skill not found"** — Run `install.sh` again. The skill directory may have reset.

**Fewer than 20 project briefs generated** — Check your input file has exactly 4 projects per category. Run the generator again; it will pick up where it left off if some files already exist.

**PPTX looks wrong visually** — Add a note in your input file under "Additional Notes" describing what's wrong, then run again. Claude performs visual QA on the slide automatically.

**Input file validation failed** — The error message will tell you exactly which field is missing or incorrectly formatted.

---

## What's Inside

```
pbl-menu-generator/
├── README.md
├── install.sh
├── skill/
│   └── SKILL.md          ← The Cowork skill (don't edit unless you know what you're doing)
├── templates/
│   └── pbl-menu-input.md ← The teacher input template
└── examples/
    ├── example-input-science.md
    └── example-input-humanities.md
```

---

## Built by Phil @ PBL Future Labs

Questions or issues → open a GitHub issue or reach out directly.
