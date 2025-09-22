# Makefile for LaTeX document compilation

# Document name (without .tex extension)
DOCUMENT = uw-ethesis

# Compiler
LATEX = pdflatex
BIBTEX = bibtex
MAKEINDEX = makeindex

# File extensions
TEX_EXT = .tex
PDF_EXT = .pdf
AUX_EXT = .aux
LOG_EXT = .log
TOC_EXT = .toc
LOT_EXT = .lot
LOF_EXT = .lof
BLG_EXT = .blg
BBL_EXT = .bbl
IDX_EXT = .idx
IND_EXT = .ind
ILG_EXT = .ilg
OUT_EXT = .out
NAV_EXT = .nav
SNM_EXT = .snm
GLG_EXT = .glg
GLS_EXT = .gls
GLO_EXT = .glo
IST_EXT = .ist
GLG_EXT_NOM = .nomenclature-glg
GLS_EXT_NOM = .nomenclature-gls
GLO_EXT_NOM = .nomenclature-glo
GLG_EXT_SYM = .symbols-glg
GLS_EXT_SYM = .symbols-gls
GLO_EXT_SYM = .symbols-glo
GLG_EXT_ABR = .glg-abr
GLS_EXT_ABR = .gls-abr
GLO_EXT_ABR = .glo-abr

# All artefact files to be cleaned
ARTEFACTS = \
    $(AUX_EXT) \
    $(LOG_EXT) \
    $(TOC_EXT) \
    $(LOT_EXT) \
    $(LOF_EXT) \
    $(BLG_EXT) \
    $(BBL_EXT) \
    $(IDX_EXT) \
    $(IND_EXT) \
    $(ILG_EXT) \
    $(OUT_EXT) \
    $(NAV_EXT) \
    $(SNM_EXT) \
    $(GLS_EXT) \
    $(GLO_EXT) \
	$(GLG_EXT) \
	$(IST_EXT) \
    $(GLO_EXT_NOM) \
	$(GLG_EXT_NOM) \
	$(GLS_EXT_NOM) \
    $(GLO_EXT_SYM) \
	$(GLG_EXT_SYM) \
    $(GLS_EXT_SYM) \
	$(GLO_EXT_ABR) \
	$(GLG_EXT_ABR) \
    $(GLS_EXT_ABR) \
    .bcf .run.xml .synctex.gz .fls .fdb_latexmk

# Default target
all: $(DOCUMENT)$(PDF_EXT)

# Main PDF generation rule
$(DOCUMENT)$(PDF_EXT): $(DOCUMENT)$(TEX_EXT)
	@echo "=== First pass of $(LATEX) ==="
	$(LATEX) $(DOCUMENT)
	@echo ""
	
	@if grep -q "citation" $(DOCUMENT)$(AUX_EXT); then \
		echo "=== Running $(BIBTEX) ==="; \
		$(BIBTEX) $(DOCUMENT); \
		echo ""; \
	fi
	
	@if [ -f $(DOCUMENT)$(IDX_EXT) ]; then \
		echo "=== Running $(MAKEINDEX) ==="; \
		$(MAKEINDEX) $(DOCUMENT); \
		echo ""; \
	fi
	
	@echo "=== Second pass of $(LATEX) ==="
	$(LATEX) $(DOCUMENT)
	@echo ""
	
	@echo "=== Third pass of $(LATEX) ==="
	$(LATEX) $(DOCUMENT)
	@echo ""
	
	@echo "Compilation complete: $(DOCUMENT)$(PDF_EXT)"


# Clean up all generated files except PDF
clean:
	@echo "Cleaning up artefacts..."
	@for ext in $(ARTEFACTS); do \
		if [ -f "$(DOCUMENT)$$ext" ]; then \
			rm -v "$(DOCUMENT)$$ext"; \
		fi; \
	done

# Clean everything including PDF
distclean: clean
	@if [ -f "$(DOCUMENT)$(PDF_EXT)" ]; then \
		rm -v "$(DOCUMENT)$(PDF_EXT)"; \
	fi


# Help message
help:
	@echo "Available targets:"
	@echo "  all        - Compile document with bibliography and index (default)"
	@echo "  clean      - Remove all intermediate files"
	@echo "  distclean  - Remove all generated files including PDF"
	@echo "  help       - Show this help message"

.PHONY: all clean distclean help