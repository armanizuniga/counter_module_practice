# Array of test case files
test_cases=(
    "testcase.sv"
    "testcase2.sv"
    "testcase3_bug.sv"
    "testcase4_disable.sv"
    "testcase5_reset.sv"
    "testcase6_reset_disable.sv"
    "testcase7_preload.sv"
)

# Initialize counters
total_tests=0
passed_tests=0
failed_tests=0
no_status_tests=0

# Initialize arrays
declare -a passed_cases
declare -a failed_cases
declare -a no_status_cases

# Create or clear the summary log file
echo "Regression Test Summary" > summary.log
echo "----------------------" >> summary.log

# Run each test case
for test_case in "${test_cases[@]}"
do
    echo "Running $test_case"
    vcs +vcs+lic+wait +v2k -full64 -sverilog -R -l vcs_${test_case%.sv}.log testbench.sv counter_fixed.v $test_case +ntb_random_seed_automatic
    
    # Extract the random seed used
    random_seed=$(grep "automatic random seed used" vcs_${test_case%.sv}.log | awk '{print $NF}')
    
    # Check the test status
    if grep -q "Test Passed" vcs_${test_case%.sv}.log; then
        passed_cases+=("$test_case (Seed: $random_seed)")
        ((passed_tests++))
    elif grep -q "Test Failed" vcs_${test_case%.sv}.log; then
        failed_cases+=("$test_case (Seed: $random_seed)")
        ((failed_tests++))
    else
        no_status_cases+=("$test_case (Seed: $random_seed)")
        ((no_status_tests++))
    fi
    
    ((total_tests++))
done

# Add summary to the log file
echo "" >> summary.log
echo "Regression Summary:" >> summary.log
echo "Total test cases run: $total_tests" >> summary.log
echo "Test cases passed: $passed_tests" >> summary.log
echo "Test cases failed: $failed_tests" >> summary.log
echo "Test cases without status: $no_status_tests" >> summary.log

# Print results to the summary log file
echo "" >> summary.log
echo "Passing Test Cases:" >> summary.log
for case in "${passed_cases[@]}"; do
    echo "  $case" >> summary.log
done

echo "" >> summary.log
echo "Failing Test Cases:" >> summary.log
for case in "${failed_cases[@]}"; do
    echo "  $case" >> summary.log
done

echo "" >> summary.log
echo "Test Cases without Status:" >> summary.log
for case in "${no_status_cases[@]}"; do
    echo "  $case" >> summary.log
done


# Print summary to console
echo "Regression completed. See summary.log for details." 