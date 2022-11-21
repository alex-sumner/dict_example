%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize
from starkware.cairo.common.dict import dict_read, dict_write
from starkware.cairo.common.dict_access import DictAccess

@external
func start_here{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
   keys_len: felt, keys: felt*, vals_len: felt, vals: felt*, targets_len: felt, targets: felt*
) {
    alloc_locals;
    let (local dict) = default_dict_new(default_value=0);
    let (dict_start, dict_end) = process_key_val_pairs(num_left=keys_len, next_key=keys, next_val=vals, dict_start=dict, dict_end=dict);
    let (dict_start, dict_end) = search_for_target_mappings(num_left=targets_len, next_target=targets, dict_start=dict_start, dict_end=dict_end);
    default_dict_finalize(dict_start, dict_end, 0);
    return();
}

func process_key_val_pairs{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
   num_left: felt, next_key: felt*, next_val: felt*, dict_start: DictAccess*, dict_end: DictAccess*
) -> (dict_start: DictAccess*, dict_end: DictAccess*) {
    alloc_locals;
    if (num_left == 0) {
        return (dict_start, dict_end);
    }
    local key = [next_key]; 
    local val = [next_val];
    dict_write{dict_ptr=dict_end}(key, val);
    return process_key_val_pairs(num_left - 1, next_key + 1, next_val + 1, dict_start, dict_end);
}

func search_for_target_mappings{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
   num_left: felt, next_target: felt*, dict_start: DictAccess*, dict_end: DictAccess*
) -> (dict_start: DictAccess*, dict_end: DictAccess*) {
    alloc_locals;
    if (num_left == 0) {
        return(dict_start, dict_end);
    }
    local target = [next_target]; 
    let (local mapped_val) = dict_read{dict_ptr=dict_end}(target);
    %{
        print(f'{ids.target} -> {ids.mapped_val}')
    %}
    return search_for_target_mappings(num_left - 1, next_target + 1, dict_start, dict_end);
}
