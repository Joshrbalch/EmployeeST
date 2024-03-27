# Makefile for GNU Smalltalk

# Compiler and flags
GST = gst
GST_FLAGS = -f

# Source files
SOURCES = main.st salary.st hourly.st commission.st

# Output executable
EXECUTABLE = payroll

all: $(EXECUTABLE)

$(EXECUTABLE): $(SOURCES)
    $(GST) $(GST_FLAGS) $^ -o $@

.PHONY: clean

clean:
    rm -f $(EXECUTABLE)
