module Readable
export datasize

"""
    datasize()

TBW
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

    return string(round(scaled_value, digits=1), "", units[exponent+1])
end

end # module

