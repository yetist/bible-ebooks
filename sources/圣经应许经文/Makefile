TARGET = $(notdir $(CURDIR)).epub
SOURCES = $(wildcard *.md)
OBJ=$(SOURCES:.md=.html)

$(TARGET): $(OBJ)
	echo $(TARGET)
	echo $(OBJ)

%.html: %.md
	markdown_py2 -f $@ -o html5 $<

clean:
	@rm -f *.html

.PHONY: clean
