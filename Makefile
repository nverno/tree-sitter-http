.PHONY: test parse parser lib

src/parser.c:
	@npm install

parser:
	@mkdir -p $@

lib: parser/libtree-sitter-pyhttp.so

parser/libtree-sitter-pyhttp.so: src/parser.c | parser
	$(CC) -fPIC -c -Isrc $^ -o parser/parser.o
	$(CC) -fPIC -shared -o $@ $(@D)/*.o

test:
	@tree-sitter generate
	@tree-sitter test

parse:
	@tree-sitter generate
	@tree-sitter parse testfile
