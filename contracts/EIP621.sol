pragma solidity 0.4.21;

import "./EIP621Abstract.sol";

contract EIP621 is EIP621Abstract {

    function EIP621(
        uint256 _initialAmount,
        string _tokenName,
        uint8 _decimalUnits,
        string _tokenSymbol
    ) EIP20(
        _initialAmount,
        _tokenName,
        _decimalUnits,
        _tokenSymbol
    ) public
    {}

    function increaseSupply(uint value, address to) public {
        totalSupply = safeAdd(totalSupply, value);
        balances[to] = safeAdd(balances[to], value);

        emit Transfer(0, to, value);
    }

    function safeAdd(uint a, uint b) internal pure returns (uint) {
        require(a + b >= a);
        return a + b;
    }

    function decreaseSupply(uint value, address from) public {
        balances[from] = safeSub(balances[from], value);
        totalSupply = safeSub(totalSupply, value);

        emit Transfer(from, 0, value);
    }

    function safeSub(uint a, uint b) internal pure returns (uint) {
        require(a >= b);
        return a - b;
    }
}
