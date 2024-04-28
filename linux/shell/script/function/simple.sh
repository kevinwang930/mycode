foo() {
    echo inside function foo
}

test=2
# use foo_return to change change global variable test value
foo_return() {
    echo inside function foo_return 
    echo global variable test in foo_return $test
    test=3
}

echo "script starting"
foo
foo_return
echo global value test $test
echo script finished