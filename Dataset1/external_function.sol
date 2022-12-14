//pragma solidity ^0.4.24;

import "./external_function_import.sol";

contract ContractWithFunctionCalledSuper is ContractWithFunctionCalled {
    function callWithSuper() public {
        uint256 i = 0;
    }
}

contract ContractWithFunctionNotCalled {

    function funcNotCalled3() public {

    }

    function funcNotCalled2() public {

    }

    function funcNotCalled() public {

    }

    function my_func() internal returns(bool){
        return true;
    }

}

contract ContractWithFunctionNotCalled2 is ContractWithFunctionCalledSuper {
    function funcNotCalled() public {
        uint256 i = 0;
        address three = address(new ContractWithFunctionNotCalled());
        three.call(abi.encode(bytes4(keccak256("helloTwo()"))));
        super.callWithSuper();
        ContractWithFunctionCalled c = new ContractWithFunctionCalled();
        c.funcCalled();
    }
}

contract Internalceshi {
    function test0() public returns(uint){
        return 0;
    }
}

contract InternalCall is Internalceshi{
    
    function() returns(uint) ptr;
    
    function set_test1() external{
        ptr = test1;
    }
    
    function set_test2() external{
        ptr = test2;
    }
    
    function test1() public returns(uint){
        return 1;
    }
    
    function test2() public returns(uint){
        return 2;
    }
    
    function test3() public returns(uint){
        return 3;
    }
    
    function exec() external returns(uint){
        return ptr();
    }
    
}

contract FunctionParameterWrite {
  
  function parameter_read_ok_for_external (uint i) public {
    uint local = i;
  }

  function parameter_read_not_ok_for_external (uint i) public returns (uint) {
    i += 1;
    return (i);
  }
}
