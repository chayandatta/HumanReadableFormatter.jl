using Readable
using Test

@testset "datasize" begin
    # Test values (in bytes)
    TEST_VALUES = [
        10, 3000, 3000000, 3000000000, 
        3000000000000, 10^26, 3141592, 82854982
    ]
    
    # Multipliers for each format style
    MULTIPLIERS = Dict(
        :si => 1.5, :binary => 2.1, :gnu => 1.6, 
        :jedec => 1.4, :decimal => 1.3
    )

    # Expected results for each format style
    EXPECTED_RESULTS = Dict(
        :si => [
            "15.0B", "4.5KB", "4.5MB", "4.5GB", 
            "4.5TB", "150.0YB", "4.7MB", "124.3MB"
        ],
        :binary => [
            "21.0B", "6.2KiB", "6.0MiB", "5.9GiB", 
            "5.7TiB", "173.7YiB", "6.3MiB", "79.0MiB"
        ],
        :gnu => [
            "16.0B", "4.7K", "4.6M", "4.5G", 
            "4.4T", "132.3Y", "4.8M", "79.0M"
        ],
        :jedec => [
            "14.0B", "4.2KB", "4.2MB", "4.1GB", 
            "4.1TB", "123.5YB", "4.4MB", "73.0MB"
        ],
        :decimal => [
            "13.0B", "3.9k", "3.9M", "3.9G", 
            "3.9T", "130.0Y", "4.1M", "107.7M"
        ]
    )

    # Test for each format style
    for style in [:si, :binary, :gnu, :jedec, :decimal]
        @testset "$style format" begin
            for (value, expected) in zip(TEST_VALUES, EXPECTED_RESULTS[style])
                println(value, expected)
                # Apply the multiplier for the style to the test value
                size = Int(value * MULTIPLIERS[style])
                
                # Call the datasize function with the selected style
                result = datasize(size, format=style)
                
                # Test the result against the expected output
                @test result == expected
            end
        end
    end
end


