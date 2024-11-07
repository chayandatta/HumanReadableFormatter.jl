# Layman.jl

A handful of straightforward functions to make data sizes clear for the layman. This library converts data sizes into a simple, human-friendly format for easy understanding.

examples:

```julia
julia> using Layman
julia> datasize(1000, format=:decimal)
"1.0k"
julia> datasize(1024)
"1.0KB"
julia> datasize(1024, format=:jdec)
"1.0KB"
julia> datasize(1024, format=:binary)
"1.0KiB"
```
