
.PHONY: all
all: build cs200.css

.PHONY: build
build:
	r2w
	cp build/* .

cs200.css:
	wget -O $@ http://faculty.ycp.edu/~dhovemey/rest2web/cs200.css

