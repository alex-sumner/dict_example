%lang starknet
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc

from src.dictex import start_here

@external
func test_mapped_values{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    let (keys: felt*) = alloc();
    assert keys[0] = 3;
    assert keys[1] = 5;
    assert keys[2] = 7;
    assert keys[3] = 9;
    let (vals: felt*) = alloc();
    assert vals[0] = 9;
    assert vals[1] = 25;
    assert vals[2] = 49;
    assert vals[3] = 81;
    let (targets: felt*) = alloc();
    assert targets[0] = 5;
    assert targets[1] = 7;
    assert targets[2] = 9;
    start_here(4, keys, 4, vals, 3, targets);
    return ();
}

@external
func test_unmapped_values{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    let (keys: felt*) = alloc();
    assert keys[0] = 3;
    assert keys[1] = 5;
    assert keys[2] = 7;
    assert keys[3] = 9;
    let (vals: felt*) = alloc();
    assert vals[0] = 9;
    assert vals[1] = 25;
    assert vals[2] = 49;
    assert vals[3] = 81;
    let (targets: felt*) = alloc();
    assert targets[0] = 5;
    assert targets[1] = 6;
    assert targets[2] = 7;
    assert targets[3] = 8;
    assert targets[4] = 9;
    start_here(4, keys, 4, vals, 5, targets);
    return ();
}

@external
func test_remapped_value{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    let (keys: felt*) = alloc();
    assert keys[0] = 3;
    assert keys[1] = 5;
    assert keys[2] = 3;
    let (vals: felt*) = alloc();
    assert vals[0] = 9;
    assert vals[1] = 25;
    assert vals[2] = 10;
    let (targets: felt*) = alloc();
    assert targets[0] = 3;
    assert targets[1] = 4;
    assert targets[2] = 5;
    start_here(3, keys, 3, vals, 3, targets);
    return ();
}
