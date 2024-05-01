# Source: https://github.com/anton-rs/3074-invokers/tree/main

all: build-forge-patch build-solc-patch build-anvil-patch 

.PHONY: build-anvil-patch
build-anvil-patch:
	@echo "Building anvil patch..."
	@cd lib/foundry && \
		cargo build --bin anvil --release && \
		mkdir -p ../../bin && \
		cp target/release/anvil ../../bin/anvil
	@echo "Done, patched anvil binary is located at `bin/anvil` relative to the project root"

.PHONY: build-forge-patch
build-forge-patch:
	@echo "Building forge patch..."
	@cd lib/foundry && \
		cargo build --bin forge --release && \
		mkdir -p ../../bin && \
		cp target/release/forge ../../bin/forge
	@echo "Done, patched forge binary is located at `bin/forge` relative to the project root"

.PHONY: build-solc-patch
build-solc-patch:
	@echo "Building solc patch..."
	@cd lib/solidity && \
		mkdir -p build && \
		cd build && \
		cmake .. && \
		make && \
		mkdir -p ../../../bin && \
		cp solc/solc ../../../bin/solc
	@echo "Done, patched solc binary is located at `bin/solc` relative to the project root"