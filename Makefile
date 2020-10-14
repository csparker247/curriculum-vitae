MAIN_FILE=cv
OUTPUT_DIR=build
DEBUG_LOG_PDF=$(OUTPUT_DIR)/debug-pdf.log
DEBUG_LOG_DOCX=$(OUTPUT_DIR)/debug-docx.log

TEX=lualatex
TEX_FLAGS=--interaction=nonstopmode --file-line-error --output-dir=$(OUTPUT_DIR)
TEX_FLAGS_DEBUG=--file-line-error --output-dir=$(OUTPUT_DIR)

BIB=biber
BIB_FLAGS=--input-directory=bibtex-refs/

all: compress

setup:
	@echo "Setting up output directory:"
	@mkdir -p $(OUTPUT_DIR)
	# Complete

clean:
	@echo "Clearing build cache..."
	@rm -rf $(OUTPUT_DIR)/*
	@echo "Complete."
	# Complete

# Create a PDF
paper: | setup $(MAIN_FILE).tex
	@echo "Making PDF:"
	# Setup debug log
	@> $(DEBUG_LOG_PDF)
	# Generate temp output
	@$(TEX) $(TEX_FLAGS) $(MAIN_FILE).tex 2>&1 >> $(DEBUG_LOG_PDF)
	# Collect bib refs
	@$(BIB) $(BIB_FLAGS) $(OUTPUT_DIR)/$(MAIN_FILE).bcf 2>&1 >> $(DEBUG_LOG_PDF)
	# Put refs in bibliography
	@$(TEX) $(TEX_FLAGS) $(MAIN_FILE).tex 2>&1 >> $(DEBUG_LOG_PDF)
	# Link in-text refs to bibliography numbering
	@$(TEX) $(TEX_FLAGS) $(MAIN_FILE).tex 2>&1 >> $(DEBUG_LOG_PDF)
	# Complete

debug: | setup $(MAIN_FILE).tex
	@echo "Making PDF:"
	# Generate temp output
	@$(TEX) $(TEX_FLAGS_DEBUG) $(MAIN_FILE).tex
	# Collect bib refs
	@$(BIB) $(BIB_FLAGS) $(OUTPUT_DIR)/$(MAIN_FILE).bcf
	# Put refs in bibliography
	@$(TEX) $(TEX_FLAGS_DEBUG) $(MAIN_FILE).tex
	# Link in-text refs to bibliography numbering
	@$(TEX) $(TEX_FLAGS_DEBUG) $(MAIN_FILE).tex
	# Complete

# Create a compressed PDF
compress: | paper $(OUTPUT_DIR)/$(MAIN_FILE).pdf
	@echo "Compressing PDF:"
	@gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer \
	-dDownsampleColorImages=true -dColorImageResolution=300 -dNOPAUSE -dQUIET \
	-dBATCH -sOutputFile=$(OUTPUT_DIR)/$(MAIN_FILE)-compressed.pdf $(OUTPUT_DIR)/$(MAIN_FILE).pdf
	# Complete
