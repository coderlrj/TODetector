pragma solidity 0.4.24;

contract SomeToken {
    mapping(address => uint256) balances;
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    function transfer(address _to, uint _value) public returns (bool) {
        if (_value > balances[msg.sender] || _value > balances[_to] + _value) {
            return false;
        }
        balances[msg.sender] = balances[msg.sender] - _value;
        balances[_to] = balances[_to] + _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
}
