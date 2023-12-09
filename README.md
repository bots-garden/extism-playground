# Extism playground
**[🍊 Open this project with Gitpod](https://gitpod.io/#https://github.com/bots-garden/extism-playground)**

Ready to use development platform  to learn Extism plug-in creation

This project is "[Gitpodified](https://www.gitpod.io/)" and brings to you all the necessary tools to start quickly with the [development of the Extism plug-ins](https://extism.org/docs/quickstart/plugin-quickstart).

| Installed components                        | Version  |
| :------------------------------------------ | -------: | 
| [Extism CLI](https://github.com/extism/cli) | `0.3.3`  | 
| Go                                          | `1.21.3` | 
| TinyGo                                      | `0.30.0` | 
| Rustc / Cargo                               | `1.74.1` | 
| Wasm-pack                                   | `0.12.1` | 
|                                             |          | 

> 🐳 The Docker image https://hub.docker.com/r/k33g/gitpod-extism-playground used by the Gitpod project is built with this Dockerfile: `docker/Dockerfile`

## Create a TinyGo plug-in

### Generate the project

```bash
mkdir hello
cd hello
go mod init hello
go get github.com/extism/go-sdk
touch main.go
```

Add this source code to `main.go`:
```go
package main

import (
    "github.com/extism/go-pdk"
)

//export hello
func hello() {
    input := pdk.Input()

    message := "🤗 Hello " + string(input)
    
    mem := pdk.AllocateString(message)
    pdk.OutputMemory(mem)
}

func main() {}
```

### Build the wasm plug-in

```bash
tinygo build -scheduler=none --no-debug \
-o hello.wasm \
-target wasi main.go
```

### Call the function with the Extism CLI

```bash
extism call hello.wasm hello --input "Bob Morane" --wasi
# you should get: 🤗 Hello Bob Morane
```

## Create a Rust plug-in

### Generate the project

```bash
cargo new --lib hello_demo --name hello
cd hello_demo
cargo add extism-pdk@1.0.0-rc1
```

Add this section to the `Cargo.toml` file:
```toml
[lib]
crate_type = ["cdylib"]
```

Replace the source code of `srg/lib.rs` by this content:
```rust
use extism_pdk::*;

#[plugin_fn]
pub fn hello(name: String) -> FnResult<String> {
    Ok(format!("👋 Hello, {}!", name))
}
```

### Build the wasm plug-in

```bash
cargo clean
cargo build --release --target wasm32-wasi
```

### Call the function with the Extism CLI

```bash
extism call ./target/wasm32-wasi/release/hello.wasm hello --input "Bob Morane" --wasi
# you should get: 👋 Hello, Bob Morane!
```
