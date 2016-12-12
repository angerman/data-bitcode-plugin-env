# A nix-shell environment for Data.BitCode.Plugin

The purpose of this repository is to facilitate the testing of the
ghc plugin that produces bitcode instead of textual ir files.

See also the README at [data-bitcode-plugin](https://github.com/angerman/data-bitcode-plugin).

## Running via nix

```
$ nix-shell
```

should be sufficient to drop into a nix shell with the patched `ghc`
and the `data-bitcode-plugin` package in the packages database.

## Taking the bitcode backend for a spin

Executing `ghc` with the `Data.BitCode.Plugin` plugin
```
[nix-shell]$ ghc examples/HelloWorld.hs -fplugin Data.BitCode.Plugin -fllvm
```
should produce the `examples/HelloWorld` binary via the bitcode
compilation pass.

## Breaking (and fixing) the bitcode backend

Simply add more complex modules to the `examples` folder, and try
to compile them as above.  If this does not lead to the expected
result, please open a pull request with your module!

Fixing the compilation should often only require to look into
[src/Data/BitCode/LLVM/Gen.hs](https://github.com/angerman/data-bitcode-plugin/blob/master/src/Data/BitCode/LLVM/Gen.hs)
in the [data-bitcode-plugin](https://github.com/angerman/data-bitcode-plugin)
package.  And comparing it to the current llvm backend in ghc at [compiler/llvmGen/LlvmCodeGen/CodeGen.hs](https://github.com/ghc/ghc/blob/master/compiler/llvmGen/LlvmCodeGen/CodeGen.hs).
