# Makefile for testing authpack LaTeX package

# LaTeX compiler
LATEX = lualatex
LATEX_OPTS = --interaction=nonstopmode

# Test files
TESTS = test-basic test-inline test-block test-advanced test-options
TEST_DIR = tests
PDFS = $(addprefix $(TEST_DIR)/, $(addsuffix .pdf, $(TESTS)))

# Default target
all: $(PDFS)

# Individual test compilation
$(TEST_DIR)/%.pdf: $(TEST_DIR)/%.tex
	cd $(TEST_DIR) && TEXINPUTS=..:$(TEXINPUTS) $(LATEX) $(LATEX_OPTS) $*.tex

# Clean generated files
clean:
	rm -f $(PDFS) $(addprefix $(TEST_DIR)/, $(addsuffix .aux, $(TESTS))) $(addprefix $(TEST_DIR)/, $(addsuffix .log, $(TESTS)))

# Test target - compile all and check for errors
test: all
	@echo "All tests compiled successfully!"

# Help target
help:
	@echo "Available targets:"
	@echo "  all     - Compile all test documents"
	@echo "  test    - Compile all tests and verify success"
	@echo "  clean   - Remove generated files"
	@echo "  help    - Show this help message"

.PHONY: all clean test help