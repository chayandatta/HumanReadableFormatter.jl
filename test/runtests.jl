using HumanReadableFormatter
using Test

@testset "datasize function" begin
    # Test 1: Basic cases with default format (:si)
    @test datasize(0) == "0B"
    @test datasize(1000) == "1KB"
    @test datasize(1500) == "1.5KB"
    @test datasize(10^6) == "1MB"
    @test datasize(10^9) == "1GB"

    # Test 2: Binary format (:binary)
    @test datasize(1024, format=:binary) == "1KiB"
    @test datasize(1536, format=:binary) == "1.5KiB"
    @test datasize(1024^2, format=:binary) == "1MiB"
    @test datasize(1024^3, format=:binary) == "1GiB"

    # Test 3: GNU format (:gnu)
    @test datasize(1024, format=:gnu) == "1K"
    @test datasize(1536, format=:gnu) == "1.5K"
    @test datasize(1024^2, format=:gnu) == "1M"
    @test datasize(1024^3, format=:gnu) == "1G"

    # Test 4: JEDEC format (:jdec)
    @test datasize(1024, format=:jdec) == "1KB"
    @test datasize(1536, format=:jdec) == "1.5KB"
    @test datasize(1024^2, format=:jdec) == "1MB"
    @test datasize(1024^3, format=:jdec) == "1GB"

    # Test 5: Decimal format (:decimal)
    @test datasize(1000, format=:decimal) == "1k"
    @test datasize(1500, format=:decimal) == "1.5k"
    @test datasize(10^6, format=:decimal) == "1M"
    @test datasize(10^9, format=:decimal) == "1G"

    # Test 6: Large values
    @test datasize(10^15) == "1PB"  # Petabyte
    @test datasize(10^18) == "1EB"  # Exabyte
    @test datasize(10^21) == "3.9EB"  # Exabyte #TODO --> Zettabyte
    @test datasize(10^24) == "2EB"  # Exabyte #TODO --> Yottabyte

    # Test 7: Edge cases for exponent boundary
    @test datasize(999) == "999B"
    @test datasize(1000, format=:si) == "1KB"
    @test datasize(1023, format=:si) == "1KB"

    # Test 8: Negative bytes (should throw an error)
    @test_throws DomainError datasize(-1)

    # Test 9: Invalid format (should throw an error)
    @test_throws ArgumentError datasize(1024, format=:unknown)
end