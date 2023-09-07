lib: $(wildcard lib/*)
	cargo rustc --release -- -C link-arg=-undefined -C link-arg=dynamic_lookup
	cp -f ./target/release/libengine.dylib ./lua/engine.so
	cp -f ./target/release/libengine.dylib ~/.config/nvim/lua/engine.so
