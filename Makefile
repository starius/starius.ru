
.PHONY: all
all: build cs200.css

.PHONY: build
build:
	r2w
	cp build/* .

cs200.css:
	wget -O $@ http://faculty.ycp.edu/~dhovemey/rest2web/cs200.css

.PHONY: install
install:
	install wt-classes/examples/wtclasses-examples.sh /etc/init.d/
	insserv wtclasses-examples.sh
	cp starius.ru.nginx /etc/nginx/sites-available/
	cd /etc/nginx/sites-enabled && ln -sf ../sites-available/starius.ru.nginx

