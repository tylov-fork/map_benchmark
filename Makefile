CXX=ccache g++
CXX_FLAGS=-g -O2 -std=c++14
#CXX_FLAGS=-g -std=c++14

maps=\
	robin_hood_map \
	std_unordered_map \
	std_map \
	null_map \
	skarupke_flat_hash_map

binaries=$(patsubst %,build/%,$(maps))

all: $(binaries)

all_fetch: $(patsubst %,fetch/%,$(maps))

fetch/%: src/maps/$(@F)
	$(MAKE) -C src/maps/$(@F)

clean: 
	rm -f $(binaries)

build/%: src/maps/$(@F)
	$(CXX) $(CXX_FLAGS) -Isrc/maps/$(@F) -Isrc/app -lm -o build/$(@F) src/app/*.cpp src/benchmarks/*.cpp -pthread -ldl

.PHONY: clean all
