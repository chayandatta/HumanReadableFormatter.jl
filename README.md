# Readable.jl

Just a few functions for helping sizes readable.
This library turns datasizes into a abbreviated human-friendly form.

examples:

```julia
julia> using Readable
julia> datasize(1000, format=:decimal)
"1.0k"
julia> datasize(1024)
"1.0KB"
julia> datasize(1024, format=:jdec)
"1.0KB"
julia> datasize(1024, format=:binary)
"1.0KiB"
```
