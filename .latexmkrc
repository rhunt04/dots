# rjh .latexmkrc

# Workflow:
#
#  $ latexmk -pv    # compile once with preview
#  < then, repeat whilst editing... >
#  $ vim source.tex # make edits...
#  $ latexmk        # update pdf, reader refresh
#  ...

# Generate pdf using pdflatex
$pdf_mode = 1;

# Use bibtex (if .bib exists)
$bibtex_use = 1;

# pdflatex command spec
$pdflatex = 'pdflatex --interaction=nonstopmode -file-line-error';

# Use zathura to preview
$pdf_previewer = 'zathura';

# Extra remove files:
$clean_ext = 'synctex.gz nav run.xml snm %R-blx.bib';
