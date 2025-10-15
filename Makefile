# Makefile for testing authpack LaTeX package

# Test files
TESTS = test-basic test-inline test-block test-advanced test-options
TEST_DIR = tests
PDFS = $(addprefix $(TEST_DIR)/, $(addsuffix .pdf, $(TESTS)))

# LaTeX compiler
LATEX = lualatex
LATEX_OPTS = --interaction=nonstopmode

# Default target
all: $(PDFS)

# Individual test compilation
$(TEST_DIR)/%.pdf: $(TEST_DIR)/%.tex
	cd $(TEST_DIR) && TEXINPUTS=..:$(TEXINPUTS) $(LATEX) $(LATEX_OPTS) $*.tex

# Clean generated files
clean:
	rm -f $(addprefix $(TEST_DIR)/, $(addsuffix .aux, $(TESTS))) $(addprefix $(TEST_DIR)/, $(addsuffix .log, $(TESTS))) $(addprefix $(TEST_DIR)/, $(addsuffix .out, $(TESTS))) $(PDFS)

# Individual test targets
test-basic: $(TEST_DIR)/test-basic.pdf
test-inline: $(TEST_DIR)/test-inline.pdf
test-block: $(TEST_DIR)/test-block.pdf
test-advanced: $(TEST_DIR)/test-advanced.pdf
test-options: $(TEST_DIR)/test-options.pdf

# Test target - compile all and check for errors
test: all
	@echo "All tests compiled successfully!"

# Help target
help:
	@echo "Available targets:"
	@echo "  all         - Compile all test documents"
	@echo "  test        - Compile all tests and verify success"
	@echo "  test-basic  - Compile test-basic.tex"
	@echo "  test-inline - Compile test-inline.tex"
	@echo "  test-block  - Compile test-block.tex"
	@echo "  test-advanced - Compile test-advanced.tex"
	@echo "  test-options - Compile test-options.tex"
	@echo "  clean       - Remove generated files"
	@echo "  help        - Show this help message"

.PHONY: all clean test test-basic test-inline test-block test-advanced test-options help