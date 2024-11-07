module HumanReadableFormatter
export datasize

"""
    datasize(bytes::Int; format::Symbol=:si)

Converts a given byte value to a human-readable format with appropriate units. 
The function supports various formats for representing datasizes, including SI (decimal), binary, and GNU conventions, among others.

### Arguments:
- `bytes::Int`: The size in bytes to be converted. Must be a non-negative integer.
- `format::Symbol`: The format to use for the conversion. Options include:
  - `:si` (default) - Uses the SI (International System of Units) standard, where each unit is a power of 1000 (e.g., 1 KB = 1000 bytes).
  - `:binary` - Uses the binary system, where each unit is a power of 1024 (e.g., 1 KiB = 1024 bytes).
  - `:gnu` - Similar to the binary format but with shorter unit names (e.g., 1K = 1024 bytes).
  - `:jdec` - Uses the JEDEC standard, which is similar to the SI format, but with distinct unit names (e.g., 1 KB = 1000 bytes, but with specific naming like "MiB").
  - `:decimal` - Uses the decimal system, where each unit is a power of 1000 (e.g., 1 KB = 1000 bytes).

### Returns:
- A string representing the size in a human-readable format, with the appropriate unit.

### Examples:
```julia
datasize(1024)                  # "1KB" (SI format, default)
datasize(1024, format=:binary)  # "1KiB" (Binary format)
datasize(1024, format=:gnu)     # "1K" (GNU format)
datasize(1048576, format=:jdec) # "1MB" (JEDEC format)
datasize(5000000000, format=:decimal) # "5GB" (Decimal format)

"""
function datasize(bytes::Int; format::Symbol=:si)
    # check for valid bytes
    if bytes == 0
        return "0B"
    elseif bytes < 0
        throw(DomainError("Byte value cannot be negative"))
    end

    # check for valid format
    VALID_FORMATS = [:si, :binary, :gnu, :jdec, :decimal]

    if !(format in VALID_FORMATS)
        throw(ArgumentError("Invalid format: $format. Available formats are :si, :binary, :gnu, :jdec, :decimal."))
    end

    # suffixes
    decimal_units = ["B", "k", "M", "G", "T", "P", "E", "Z", "Y"]
    binary_units = ["B", "KiB", "MiB", "GiB", "TiB", "PiB", "EiB", "ZiB", "YiB"]
    si_units = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
    gnu_units = ["B", "K", "M", "G", "T", "P", "E", "Z", "Y"]
    jedec_units = si_units  # JEDEC uses SI suffixes

    # base and units based on format
    if format == :binary
        base, units = 1024, binary_units
    elseif format == :gnu
        base, units = 1024, gnu_units
    elseif format == :jdec
        base, units = 1024, jedec_units
    elseif format == :decimal
        base, units = 1000, decimal_units
    else  # default :si
        base, units = 1000, si_units
    end

    # Calculate exponent
    exponent = min(floor(Int, log(float(bytes)) / log(base)), length(units) - 1)
    scaled_value = bytes / base^exponent

    non_formatted_val = string(round(scaled_value, digits=1), " ", units[exponent+1])
    formatted_val = replace(non_formatted_val, r"\.0\s+([A-Za-z]+)" => s"\1", r"\s+([A-Za-z]+)" => s"\1")

    return formatted_val
end

end # module
