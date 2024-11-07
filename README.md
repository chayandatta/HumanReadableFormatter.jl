# HumanReadableFormatter.jl

`HumanReadableFormatter.jl` is a Julia package that offers straightforward functions for converting data sizes (and upcoming, time) into easy-to-read, human-friendly formats. Whether you’re dealing with bytes or seconds, `HumanReadableFormatter.jl` simplifies your data into comprehensible units, so you can focus on what matters.

## Installation

To install `HumanReadableFormatter.jl`, open your Julia REPL, press `]` to enter the package manager, and then run:

```julia
add HumanReadableFormatter
```

## Usage

### Data Size Conversion

The package provides functions that convert data sizes (in bytes) into human-readable formats, automatically using appropriate units (KB, MB, GB, etc.). 

#### Example

```julia
julia> using HumanReadableFormatter

julia> datasize(1000, format=:decimal)
"1.0k"

julia> datasize(1024)
"1.0KB"

julia> datasize(1024, format=:jdec)
"1.0KB"

julia> datasize(1024, format=:binary)
"1.0KiB"
```

*`datasize` automatically converts the byte size to the best-fitting unit, rounding for simplicity and ease of understanding.*

### Time Conversion (Upcoming)

The next version of `HumanReadableFormatter.jl` will include time conversion functions, making it just as easy to format time intervals in a human-friendly way."

## Function Reference

### `datasize(bytes::Int; format::Symbol=:si) -> String`

Converts an integer representing bytes into a more readable string format, choosing the best-fitting unit (e.g., KB, MB, GB) based on the input size.

- **Parameters**:
  - `bytes`: An integer representing the size in bytes.
  - `format` (optional): Name for the format (default: SI).

- **Returns**: A string with the human-readable format of the data size.

### Future Functions (Time Conversion)

Time conversion functions will soon be available to handle time durations in a similar human-readable format.

## Contributing

Contributions are welcome! If you’d like to contribute to `HumanReadableFormatter.jl`, feel free to submit issues, open pull requests, or reach out for suggestions.

## License

`HumanReadableFormatter.jl` is open-source software, available under the MIT License.

---
